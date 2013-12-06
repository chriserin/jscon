page = require('webpage').create();
server = require('webserver').create();
fs = require('fs');
system = require('system');
require("./evalInput.js");
require("./pipes.js");
require("./debugCallbacks.js");
require("./assetServer.js");
require("./arguments.js");
coffee = require("./coffee-script.js").CoffeeScript;

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

function compile(input) {
  if(option('coffee')) {
    try{
      compiled_input = coffee.compile(input, {bare: true});
      if(option("showjs")) {
        console.log(compiled_input);
      }
      return compiled_input;
    }catch(e){
      console.log("compilation error:")
      console.log(e)
    }
  } else {
    return input;
  }
}

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
  while(true) {
    var fullInPath  = tmpDir + "/" + inPipe
    var fullOutPath = tmpDir + "/" + outPipe
    result = rspchars(page.evaluate(evalInput, compile(fs.read(fullInPath))));
    fs.write(fullOutPath, result, "w");
  }
}
runnerFunc = runRepl

content = "<html><head></head><body></body></html>"
serveAssets(tmpDir, page, fs, server);
page.setContent(content, "file://" + fs.workingDirectory +  "/.req/empty_page/dummy.html");
