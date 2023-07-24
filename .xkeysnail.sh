
#!/bin/bash
tmux
xhost +SI:localuser:root
X='';
echo -n -e '${X}' | /usr/local/bin/xkeysnail /usr/local/sbin/xkeysnail_config.py
