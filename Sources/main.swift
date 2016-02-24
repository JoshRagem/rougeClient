import CNCurses
import CLibUV

let loop = uv_default_loop()
uv_run(loop, UV_RUN_DEFAULT)
print("Event Loop: \(loop)")

initscr()
noecho()
clear()
move(1,1)
addch(64)
refresh()

var i:UInt = 0
let c:UInt = 64
while i < 100000 {
      addch(c)
      refresh()
      i = i + 1
}
endwin()