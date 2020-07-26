import re
from xkeysnail.transform import *

define_multipurpose_modmap({
    Key.BACKSPACE: [Key.BACKSPACE, Key.LEFT_META],
    Key.SPACE: [Key.SPACE, Key.LEFT_CTRL],
    Key.RIGHT_SHIFT: [Key.GRAVE, Key.RIGHT_SHIFT],
})

# Keybindings for Brave
define_keymap(re.compile("Brave"), {
    K("LC-Q"): K("LC-LShift-TAB"),
    K("LC-W"): K("LC-TAB"),
    K("LC-T"): K("LC-W"),
    # map copypasta
    K("LC-C"): K("LShift-LC-C"),                # COPY
    K("LC-V"): K("LShift-LC-V"),                # PASTE
    K("LC-X"): K("LShift-LC-X"),                # CUT
}, "Brave")


define_keymap(None, {
    # map super
    K("LC-LSuper-BACKSLASH"): Key.LEFT_META,
    # map copypasta
    K("LC-V"): K("LShift-LC-V"),                # PASTE
    # map arrow keys hnei
    K("LShift-LSuper-K"): K("UP"),
    K("LShift-LSuper-J"): K("DOWN"),
    K("LShift-LSuper-H"): K("LEFT"),
    K("LShift-LSuper-L"): K("RIGHT"),
    # map numbers to home row
    K("LC-A"): Key.KEY_1,                       # 1
    K("LC-S"): Key.KEY_2,                       # 2
    K("LC-D"): Key.KEY_3,                       # 3
    K("LC-F"): Key.KEY_4,                       # 4
    K("LC-G"): Key.KEY_5,                       # 5
    K("LC-H"): Key.KEY_6,                       # 6
    K("LC-J"): Key.KEY_7,                       # 7
    K("LC-K"): Key.KEY_8,                       # 8
    K("LC-L"): Key.KEY_9,                       # 9
    K("LC-SEMICOLON"): Key.KEY_0,               # 0
    # map programming characters to home row
    K("LC-LSuper-F"): K("RShift-KEY_9"),        # (
    K("LC-LSuper-J"): K("RShift-KEY_0"),        # )
    K("LC-LSuper-D"): K("RShift-LEFT_BRACE"),   # {
    K("LC-LSuper-K"): K("RShift-RIGHT_BRACE"),  # }
    K("LC-LSuper-S"): K("LEFT_BRACE"),          # [
    K("LC-LSuper-L"): K("RIGHT_BRACE"),         # ]
    K("LC-LSuper-G"): K("EQUAL"),               # =
    K("LC-LSuper-A"): K("RShift-EQUAL"),        # +
    K("LC-LSuper-H"): K("MINUS"),               # -
    K("LC-LSuper-SEMICOLON"): K("RShift-MINUS"),# _
    # map shift+numbers to bottom row
    K("LC-RShift-Z"): K("RShift-KEY_1"),        # !
    K("LC-RShift-X"): K("RShift-KEY_2"),        # @
    K("LC-RShift-C"): K("RShift-KEY_3"),        # #
    K("LC-RShift-V"): K("RShift-KEY_4"),        # $
    K("LC-RShift-B"): K("RShift-KEY_5"),        # %
    K("LC-RShift-N"): K("LShift-KEY_6"),        # ^
    K("LC-RShift-M"): K("LShift-KEY_7"),        # &
    K("LC-RShift-COMMA"): K("LShift-KEY_8"),    # *
    # K("LC-RShift-DOT"): K("LShift-KEY_9"),
    # K("LC-RShift-SLASH"): K("LShift-KEY_0"),
})

