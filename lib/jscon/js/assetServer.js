serveAssets = function(tmpDir, page, fs, server) {
  server.listen("4242", function (request, response) {
    console.log("in server listen")
    response.statusCode = 200;
    response.headers = {"Cache": "no-cache", "Content-Type": "text/javascript"};
    try {
      //var assetPath = tmpDir + request.url.replace(/\?.*$/, "");
      var in_pipe   = tmpDir + '/js_asset_in.pipe'
      var out_pipe  = tmpDir + '/js_asset_out.pipe'
      if (fs.exists(in_pipe)) {
        console.log("before write");
        fs.write(in_pipe, request.url);
        console.log("after write");
        data = fs.read(out_pipe)
        response.write(data)
      } else {
        console.log(request.url + " not loaded")
      }
    } catch (err) {
      console.log("caught error")
      console.log(err)
    }
    response.close();
  });

  page.onResourceRequested = function (request, networkRequest) {
    if(request.url.indexOf(".js") > 0) {
      console.log("on resource_requested")
      console.log(request.url)
      assetPath = request.url.replace("file:///", "")
      networkRequest.changeUrl("http://localhost:4242/" + assetPath)
    }
  }
}
