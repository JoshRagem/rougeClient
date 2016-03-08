import CNCurses
import CLibUV
import CZMQ

let loop = uv_default_loop()
uv_run(loop, UV_RUN_DEFAULT)
print("Event Loop: \(loop)")

let context = zmq_ctx_new()
let requester = zmq_socket(context, ZMQ_REQ)
print("socket \(requester)")
zmq_connect(requester, "tcp://localhost:5555")
print("connected")

print("printing")
initscr()
noecho()
clear()
move(1,1)
addch(64)
refresh()

var i:UInt = 0
let c:UInt = UInt(getch())
while i < 10000 {
      addch(c)
      refresh()
      i = i + 1
}

clear()
echo()
move(0,0)
var str = UnsafeMutablePointer<Int8>.alloc(1)
getstr(str)
endwin()
print("str: \(String.fromCString(str))")

if let str1 = String.fromCString(str) {
    zmq_send(requester, str, str1.characters.count, 0)
}
print("connected")

var buffer = UnsafeMutablePointer<Int8>.alloc(1)
zmq_recv(requester, buffer, 10, 0)
print("recv? \(String.fromCString(buffer))")

zmq_close(requester)
print("connected")
zmq_ctx_shutdown(context)
print("connected")
