var dockProgress = {
  setup: function() {
    this.dlMgr = Components.classes["@mozilla.org/download-manager;1"]
      .getService(Components.interfaces.nsIDownloadManager);
    this.dlMgr.addListener(this);
  },
  
  update: function(meth) {
    window.dump("download state change! " + meth);
  },
  
  onDownloadStateChange: function(state, dl) { this.update("DL state") },
  onStateChange: function(prog, req, flags, status, dl)
    { this.update("state") },
  onProgressChange: function(prog, req, cur, max, tcur, tmax, dl)
    { this.update("progress") },
  onSecurityChange: function(prog, req, state, dl) { this.update("security") }
};

dockProgress.setup();
