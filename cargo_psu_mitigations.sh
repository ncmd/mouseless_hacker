#!/usr/bin/env bash
# cargo_psu_mitigations.sh — Prevent PSU overcurrent from parallel cargo builds
#
# AMD Threadripper 3990X (64c/128t, 280W TDP) + RTX 5070 Ti (330W) can trip
# PSU overcurrent protection (OCP) when multiple cargo build processes run
# simultaneously (e.g., CI agents, sprint workers).
#
# This script applies software-level mitigations:
#   1. User-level systemd cgroup slice (CPU + memory caps for cargo builds)
#   2. Cargo config limits (jobs, compiler threads)
#   3. Cargo wrapper with nice/ionice + cgroup enforcement
#
# Usage:
#   ./cargo_psu_mitigations.sh                  # Apply all mitigations
#   ./cargo_psu_mitigations.sh --status         # Show current settings
#   ./cargo_psu_mitigations.sh --remove         # Remove mitigations
#
# Pair with cpu_power_limit.sh (requires sudo) for full protection.
# This script does NOT require root.

set -euo pipefail

# --- Configuration ---
# Tune these for your hardware. Defaults are for 64GB RAM, 128-thread CPU.
CARGO_JOBS=8                # Max parallel rustc invocations per build
CARGO_THREADS=4             # -Z threads per rustc invocation (nightly)
CGROUP_CPU_QUOTA="4000%"    # 40 cores max for all cargo builds combined
CGROUP_MEM_MAX="48G"        # Hard memory ceiling
CGROUP_MEM_HIGH="40G"       # Memory pressure threshold (kernel reclaims)
CGROUP_IO_WEIGHT=50         # I/O priority (1-10000, default 100)
NICE_LEVEL=10               # CPU scheduling priority (0-19, higher = lower priority)
IONICE_CLASS=2              # Best-effort I/O class
IONICE_LEVEL=5              # I/O priority within class (0-7)

SLICE_DIR="$HOME/.config/systemd/user"
SLICE_FILE="$SLICE_DIR/cargo-build.slice"

log() { echo "[cargo_psu] $*"; }

apply_cgroup_slice() {
    mkdir -p "$SLICE_DIR"
    cat > "$SLICE_FILE" <<EOF
[Unit]
Description=CPU/Memory limit for cargo builds (PSU OCP prevention)

[Slice]
CPUQuota=$CGROUP_CPU_QUOTA
MemoryMax=$CGROUP_MEM_MAX
MemoryHigh=$CGROUP_MEM_HIGH
IOWeight=$CGROUP_IO_WEIGHT
EOF
    systemctl --user daemon-reload
    log "Installed cargo-build.slice (CPU: $CGROUP_CPU_QUOTA, Mem: $CGROUP_MEM_MAX)"
}

show_cargo_config() {
    local config
    for config in "$HOME/.cargo/config.toml" "$HOME/ss/repos/sigmashake_inc/.cargo/config.toml"; do
        if [[ -f "$config" ]]; then
            echo "  $config:"
            grep -E '(jobs|threads)' "$config" 2>/dev/null | sed 's/^/    /'
        fi
    done
}

show_status() {
    echo "=== Cargo PSU Mitigation Status ==="
    echo ""
    echo "Cgroup slice:"
    if systemctl --user is-active cargo-build.slice &>/dev/null; then
        echo "  Status: active"
        systemctl --user show cargo-build.slice --property=CPUQuotaPerSecUSec,MemoryMax 2>/dev/null | sed 's/^/  /'
    elif [[ -f "$SLICE_FILE" ]]; then
        echo "  Status: installed (inactive — activates on first cargo build)"
    else
        echo "  Status: not installed"
    fi
    echo ""
    echo "Cargo config:"
    show_cargo_config
    echo ""
    echo "Cargo wrapper:"
    local wrapper="$HOME/ss/shared/wrappers/cargo"
    if [[ -f "$wrapper" ]]; then
        if grep -q 'systemd-run.*cargo-build.slice' "$wrapper" 2>/dev/null; then
            echo "  Cgroup enforcement: yes"
        else
            echo "  Cgroup enforcement: no"
        fi
        if grep -q 'nice -n' "$wrapper" 2>/dev/null; then
            echo "  Nice priority: yes"
        else
            echo "  Nice priority: no"
        fi
        if grep -q 'flock' "$wrapper" 2>/dev/null; then
            echo "  Build serialization (flock): yes"
        else
            echo "  Build serialization (flock): no"
        fi
    else
        echo "  Not found at $wrapper"
    fi
    echo ""
    echo "Power budget estimate (2 concurrent agents):"
    local max_threads=$((CARGO_JOBS * CARGO_THREADS * 2))
    echo "  Per agent: $CARGO_JOBS jobs × $CARGO_THREADS threads = $((CARGO_JOBS * CARGO_THREADS)) thread activations"
    echo "  2 agents:  $max_threads thread activations (capped to ${CGROUP_CPU_QUOTA} by cgroup)"
    echo "  Est. CPU:  ~100-125W (vs. ~280W uncapped)"
}

apply_cargo_configs() {
    local global_config="$HOME/.cargo/config.toml"

    if [[ -f "$global_config" ]]; then
        # Update jobs in global config
        if grep -q "^jobs" "$global_config"; then
            sed -i "s/^jobs = .*/jobs = $CARGO_JOBS/" "$global_config"
            log "Updated $global_config: jobs = $CARGO_JOBS"
        fi
    fi

    # Workspace config is managed by the project — just report
    local ws_config="$HOME/ss/repos/sigmashake_inc/.cargo/config.toml"
    if [[ -f "$ws_config" ]]; then
        log "Workspace config ($ws_config): managed by project sync"
        log "  Current: $(grep -E 'jobs|threads' "$ws_config" | tr '\n' ' ')"
    fi
}

remove_mitigations() {
    if [[ -f "$SLICE_FILE" ]]; then
        rm -f "$SLICE_FILE"
        systemctl --user daemon-reload
        log "Removed cargo-build.slice"
    else
        log "No cgroup slice to remove"
    fi
    log "Note: cargo config and wrapper changes must be reverted manually"
}

case "${1:-}" in
    --status)
        show_status
        ;;
    --remove)
        remove_mitigations
        ;;
    *)
        log "Applying cargo PSU overcurrent mitigations..."
        echo ""
        apply_cgroup_slice
        apply_cargo_configs
        echo ""
        log "All mitigations applied. Run with --status to verify."
        log "For CPU frequency capping (requires sudo): ./cpu_power_limit.sh"
        ;;
esac
