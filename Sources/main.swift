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
zmq_send(requester, "hello", 5, 0)
print("connected")

print("printing")
initscr()
noecho()
clear()
move(1,1)
addch(64)
refresh()

var i:UInt = 0
let c:UInt = 64
while i < 10000 {
      addch(c)
      refresh()
      i = i + 1
}
endwin()

var buffer = UnsafeMutablePointer<Int8>.alloc(10)
zmq_recv(requester, buffer, 10, 0)
print("recv? \(buffer)")

zmq_close(requester)
print("connected")
zmq_ctx_shutdown(context)
print("connected")
