# Mac Setup

# THIS IS FOR COLEMAK LAYOUT

## karabiner-elements
- https://karabiner-elements.pqrs.org
- Swap Esc with Caps Lock key
- Swap left_command with right_command
- Swap right_command with right_control
![client](./images/swap_keys.png "client")
- Add complex modifications rules
- see karabiner_complex_modifications.json file
![client](./images/complex_modifications.png "client")

```
COLEMAK
╔══════════════════════════════════════╦══════════════════════════════════════╗
left_command + h                       ║ arrow left
left_command + j                       ║ arrow down
left_command + k                       ║ arrow up
left_command + l                       ║ arrow right
right_command + right_control + r      ║ open bracket [ 
right_command + right_control + s      ║ open curly bracket { 
right_command + right_control + t      ║ open parenthesis ( 
right_command + right_control + n      ║ open parenthesis ) 
right_command + right_control + e      ║ close curly bracket } 
right_command + right_control + i      ║ close bracket ] 
╚══════════════════════════════════════╩══════════════════════════════════════╝
```
## Increase key speed
![client](./images/mac_keyboard_speed.png "client")

## Turn off press and hold and dictionary 
```
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool falsedefaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'
```
## Remove all text modifications in Keyboard settings
![client](./images/keyboard_text.png "client")

## Mac App Shortcuts
- System Preferences > Keyboard > App Shortcuts
- Change Chrome shortcuts
![client](./images/chrome_shortcuts.png "client")

## Mac Mission Control
- System Preferences > Keyboard > Mission Control
![client](./images/mission_control.png "client")
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
left_command + j                       ║ move desktop window left
left_command + ;                       ║ move desktop window right
╚══════════════════════════════════════╩══════════════════════════════════════╝
```

## Terminal
- Alacritty
- https://github.com/alacritty/alacritty
```
brew cask install alacritty
```
- Install Ranger
```
https://github.com/ranger/ranger
```

## Multiplexer
- Tmux + Oh-my-zsh
- Use zshrc
- Use tmux.conf and tmux.conf.local 
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
right_command + tab                    ║ toggle terminal               *remap*
right_command + `                      ║ toggle terminal fullscreen    *remap*
right_command + left_command > l       ║ move to right tmux tab
right_command + w > c                  ║ create new tab
right_command + w > , > enter          ║ rename tab
right_command + w > x > y > enter      ║ close window
right_command + w > %                  ║ split window vertical
right_command + w > "                  ║ split window horizontal
right_command + w > {                  ║ swap window with left 
right_command + w > }                  ║ swap window with right
right_command + w > z                  ║ toggle split window expand
right_command + w > h                  ║ move left split window
right_command + w > l                  ║ move right split window
right_command + r > {word}             ║ reverse search command history 
╚══════════════════════════════════════╩══════════════════════════════════════╝
```

## Shell Alias
```
vim ~/.zshrc
alias g="git"
alias p="python3"
alias c="git add . && git commit -m 'quick deploy' && git push"
alias v=". venv/bin/activate"
source ~/.zshrc
```
# Bookmarks (disabled)
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
m                                      ║ toggle bookmark line          *remap* 
n                                      ║ toggle next bookmark          *remap* 
space                                  ║ list bookmarks                *remap*
left_command + l                       ║ move to next bookmark         *remap* 
╚══════════════════════════════════════╩══════════════════════════════════════╝
```

# Editor VIM+VSCode   
- read: http://vimdoc.sourceforge.net/htmldoc/vimindex.html
- read: http://tnerual.eriogerg.free.fr/vimqrc.html
- vscode 'when' conditions:
  - https://code.visualstudio.com/docs/getstarted/keybindings#_contexts

## Macros
- use for repetitive for hotkeys
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
q > {char}                             ║ start macro recording
q > {char} > q                         ║ end macro recording
shift + 2 > {char}                     ║ use macro {char}
╚══════════════════════════════════════╩══════════════════════════════════════╝
```

## Motion
- enable sneak plugin (within vscode vim settings) 
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
h                                      ║ left
l                                      ║ right
j                                      ║ down
k                                      ║ up
left_command + a                       ║ move to start of cursor line
left_command + f                       ║ move to end of cursor line    *remap*
left_command + j                       ║ move down X lines             *remap*
left_command + k                       ║ move up X lines               *remap*
0                                      ║ move to start of cursor line
$                                      ║ move to end of cursor line
' > '                                  ║ move cursor to previous position
right_command > i                      ║ move cursor history forward
right_command > o                      ║ move cursor history back 
left_command + 3                       ║ go to definition of cursor    *remap*
g > d                                  ║ go to definition of cursor
s > {char} > {char}                    ║ search for character
s > {char} > {char} > ;                ║ search for character next
shift + s > {char} > {char}            ║ search backwards
shift + s > {char} > {char} > ;        ║ search backwards next
f > {char} > ,                         ║ move back to char
f > {char} > ;                         ║ move forward to char
shift + f > {char} > ;                 ║ move back to char
shift + h                              ║ move cursor to top of screen 
shift + m                              ║ move cursor to middle of screen 
shift + l                              ║ move cursor to bottom of screen 
g > i                                  ║ move to last edited section
g > g                                  ║ move first line of file
shift + g                              ║ move last line of file
shift + 5                              ║ move to matching {} or ()
{number} > shift + g                   ║ move to {num} line
shift + ; > {num} > enter              ║ move to line {num} 
╚══════════════════════════════════════╩══════════════════════════════════════╝
```

## Normal mode
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
tab                                    ║ escape to enter NORMAL mode
left_command > click                   ║ multi cursor select
/ > {word} > enter                     ║ search for word FORWARD 
? > {word} > enter                     ║ search for word BACKWARD 
/ > {word} > enter > n                 ║ find next
q > :                                  ║ vim history 
╚══════════════════════════════════════╩══════════════════════════════════════╝
```

## Insert and Replace
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
backspace > x                          ║ delete left                   *remap* 
: > %s/old/new/g                       ║ replace string
x                                      ║ delete character in cursor position
shift + r                              ║ REPLACE mode
i                                      ║ INSERT mode inbetween
a                                      ║ INSERT mode append   
shift + a                              ║ INSERT mode move to end of line
v                                      ║ VISUAL mode
shift + o                              ║ INSERT mode blank ABOVE selected line
o                                      ║ INSERT mode blank BELOW selected line
d > d                                  ║ delete line
c > c                                  ║ delete line and INSERT mode
shift + c                              ║ delete everything after cursor
shift + u                              ║ redo
u                                      ║ undo
d > l                                  ║ delete 1 character right
d > h                                  ║ delete 1 character left
d > a > w                              ║ delete selected word
c > a > w                              ║ delete selected word to insert mode
d > f > {char}                         ║ delete from CURSOR to {char}
left_command + k                       ║ move current line up
left_command + j                       ║ move current line down
y > y                                  ║ copy line
y > i > w                              ║ copy cursor word
v > i > w > p                          ║ paste replace cursor word
p                                      ║ paste line after cursor
shift + p                              ║ paste line before cursor
g > u > a > w                          ║ convert word to lower case
g > shift+u > a > w                    ║ convert word to upper case
g > u > u                              ║ convert line all lower case
g > shift+u > shift+u                  ║ convert line all upper case
g > g > g > u > shift + g              ║ convert all lines to lower case
g > g > g > shift + u > shift + g      ║ convert all lines to upper case
left_command + right_ctrl + y          ║ open cursor link
╚══════════════════════════════════════╩══════════════════════════════════════╝
```

## Visual mode
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
left_command > /                       ║ comment out selected lines
shift + v                              ║ select current line
v > highlight > o                      ║ swap highlight position
v > i > w                              ║ select word
v > i > w > shift + s                  ║ surround mode
v > i > w > shift + s > {char}         ║ surround with {char} 
v > i > w > y > esc > p                ║ copy word and paste after cursor
v > i > w > y > esc > P                ║ copy word and paste before cursor
╚══════════════════════════════════════╩══════════════════════════════════════╝
```

# Editor control
## Quick search
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
left_command + space                   ║ quick search                  *remap*
space > delete                         ║ search file                   *remap*
left_command + 1                       ║ find in files                 *remap*
left_command + 2                       ║ view explorer                 *remap*
left_command + 3                       ║ go to definition of cursor    *remap*
╚══════════════════════════════════════╩══════════════════════════════════════╝
```

## Tab control
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
left_command + shift + t               ║ re-open recently closed tab
left_command + d                       ║ close selected tab            *remap*
left_command + w                       ║ toggle to other split window  *remap*
left_command + e                       ║ toggle right tab              *remap*
left_command + q                       ║ toggle left tab               *remap*
╚══════════════════════════════════════╩══════════════════════════════════════╝
```

## Window Splitting
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
left_command + m                       ║ split vertical                *remap*
left_command + n                       ║ split horizontal              *remap*
left_command + right_command + ,       ║ move window left              *remap*
left_command + right_command + .       ║ move window right             *remap*
╚══════════════════════════════════════╩══════════════════════════════════════╝
```

# Brave Web Browser 
- Install [Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb) chrome extension
- Vimium custom mappings
```
# Insert your preferred key mappings here.
unmap o
unmap O
map o Vomnibar.activateInNewTab
unmap T
map t Vomnibar.activateTabSelection
unmap r
unmap b
unmap B
unmap g0
unmap g$
unmap x
unmap X
unmap W
map 0 firstTab
map $ lastTab
unmap p
unmap P
unamp u
unamp U
unmap gu
```
```
╔══════════════════════════════════════╦══════════════════════════════════════╗
?                                      ║ open vimium shortcut help 
g > e                                  ║ edit current url
shift + h                              ║ go back in history
shift + l                              ║ go forward in history
f > {char} > {char}                    ║ click on link
o > {word}                             ║ open URL, bookmark or history entry
T > {word}                             ║ search open tabs
ctrl + shift + t                       ║ re-open recently closed tab
left_command + e                       ║ toggle next tab               *remap*
left_command + q                       ║ close current tab             *remap*
left_command + d                       ║ open new tab                  *remap*
left_command + l                       ║ focus to search bar
space                                  ║ scroll down
shift + space                          ║ scroll up
left_command + shift + c               ║ open chrome debugger 
left_command + [                       ║ move previous panel 
left_command + ]                       ║ move next panel 
╚══════════════════════════════════════╩══════════════════════════════════════╝
```