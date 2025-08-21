- start session
```
tmux new-session -A -s tmp "/home/user/xkeys.sh; bash"
```
- kill session
```
tmux kill-session -t tmp
```

- get name of window:
```
xprop | grep WM_CLASS
```

