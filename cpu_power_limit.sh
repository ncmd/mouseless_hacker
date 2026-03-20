#!/usr/bin/env bash
# cpu_power_limit.sh — Cap CPU frequency and power for AMD Threadripper 3990X
#
# Prevents PSU overcurrent protection (OCP) from tripping under heavy
# all-core load (e.g., multiple concurrent cargo build processes).
#
# Usage:
#   sudo ./cpu_power_limit.sh          # Apply 3.5GHz cap + balance_power
#   sudo ./cpu_power_limit.sh --reset  # Restore defaults (4.8GHz + balance_performance)
#   sudo ./cpu_power_limit.sh --status # Show current settings
#
# To persist across reboots, install the systemd service:
#   sudo ./cpu_power_limit.sh --install-service

set -euo pipefail

MAX_FREQ_LIMITED=3500000   # 3.5 GHz — safe all-core power draw
MAX_FREQ_DEFAULT=4830600   # 4.83 GHz — stock boost clock
EPP_LIMITED="balance_power"
EPP_DEFAULT="balance_performance"

SYSFS_BOOST="/sys/devices/system/cpu/cpufreq/boost"
SERVICE_NAME="cpu-power-limit"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

log() { echo "[cpu_power_limit] $*"; }

check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "Error: must run as root (sudo)" >&2
        exit 1
    fi
}

apply_limit() {
    check_root
    local freq="$1" epp="$2" label="$3"

    log "Setting max frequency to $((freq / 1000)) MHz ($label)"
    for f in /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq; do
        echo "$freq" > "$f"
    done

    log "Setting energy_performance_preference to $epp"
    for f in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
        echo "$epp" > "$f"
    done

    # Ensure boost is off
    if [[ -f "$SYSFS_BOOST" ]]; then
        echo 0 > "$SYSFS_BOOST"
        log "CPU boost disabled"
    fi

    log "Done"
}

show_status() {
    local freq epp boost governor
    freq=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)
    epp=$(cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference)
    governor=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
    boost=$(cat "$SYSFS_BOOST" 2>/dev/null || echo "N/A")

    echo "CPU Power Settings (cpu0, applies to all cores):"
    echo "  Max frequency:  $((freq / 1000)) MHz"
    echo "  Governor:       $governor"
    echo "  Energy pref:    $epp"
    echo "  Boost:          $([ "$boost" = "0" ] && echo "disabled" || echo "enabled")"
    echo "  Driver:         $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver)"
    echo "  Cores:          $(nproc)"
}

install_service() {
    check_root
    local script_path
    script_path="$(readlink -f "$0")"

    cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=Cap CPU frequency for PSU overcurrent protection
After=multi-user.target

[Service]
Type=oneshot
ExecStart=$script_path
RemainAfterExit=yes
ExecStop=$script_path --reset

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable "$SERVICE_NAME"
    systemctl start "$SERVICE_NAME"
    log "Installed and started ${SERVICE_NAME}.service"
    log "Will persist across reboots"
}

uninstall_service() {
    check_root
    if [[ -f "$SERVICE_FILE" ]]; then
        systemctl stop "$SERVICE_NAME" 2>/dev/null || true
        systemctl disable "$SERVICE_NAME" 2>/dev/null || true
        rm -f "$SERVICE_FILE"
        systemctl daemon-reload
        log "Removed ${SERVICE_NAME}.service"
    else
        log "Service not installed"
    fi
}

case "${1:-}" in
    --reset)
        apply_limit "$MAX_FREQ_DEFAULT" "$EPP_DEFAULT" "stock"
        ;;
    --status)
        show_status
        ;;
    --install-service)
        install_service
        ;;
    --uninstall-service)
        uninstall_service
        ;;
    *)
        apply_limit "$MAX_FREQ_LIMITED" "$EPP_LIMITED" "limited"
        ;;
esac
