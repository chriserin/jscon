page = require('webpage').create();
server = require('webserver').create();
fs = require('fs');
system = require('system');
require("./evalInput.js");
require("./debugCallbacks.js");
require("./assetServer.js");
require("./arguments.js");
require("./connection.js");

//addDebugCallbacks(page);
phantomArgs = processArguments(system.args);
tmpDir = phantomArgs.tmpDir
page.onLoadFinished = function(status) {
  if (option('application')) {
    page.includeJs('/assets/application.js', runnerFunc);
  } else {
    runnerFunc();
  }
};

page.onConsoleMessage = function (msg) { console.log(msg); };

function option(name) {
  return (phantomArgs['options'] && phantomArgs['options'].indexOf(name) >= 0);
}

function rspchars(str) {
  if(str) {
    return str.replace(/\\n/g,"\n").replace(/\\t/g, "  ");
  }
}

log = function(v) { console.log(v)}

runRepl = function() {
  connection = new Connection({port: 9001, onmessage: function(input) {
    connection.send(rspchars(page.evaluate(evalInput, input.data)));
  }});
}
runnerFunc = runRepl

content = "<html><head></head><body></body></html>"
serveAssets(tmpDir, page, fs, server);
page.setContent(content, "file://" + fs.workingDirectory +  "/.req/empty_page/dummy.html");
