. "$HOME/.cargo/env"

# Cargo wrapper: flock serialization + cgroup limits + nice priority
# Prevents concurrent agent builds from tripping PSU overcurrent protection
export PATH="$HOME/ss/shared/wrappers:$PATH"
