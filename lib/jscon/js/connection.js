var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Connection = function(options) {
  this.port = options.port;
  this.socket = new WebSocket("ws://127.0.0.1:" + this.port + "/");
  this.socket.onmessage = options.onmessage;
  this.socket.onclose = function() {
    return phantom.exit();
  };
}

Connection.prototype.send = function(message) {
  return this.socket.send(message);
};
