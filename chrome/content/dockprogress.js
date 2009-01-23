var dockProgress = {
  setup: function() {
    this.Ci = Components.interfaces;
    this.iface = this.Ci.nsIDownloadManager;
    
    this.dlMgr = Components.classes["@mozilla.org/download-manager;1"]
      .getService(this.iface);
    this.dlMgr.addListener(this);
    
    this.dockProgress = Components.classes[
        "@vasi.dyndns.org/DockProgress/DockProgress;1"
      ].getService(Components.interfaces.IDockProgress);
  },
  
  update: function(meth) {
    var total = 0, cur = 0;
    
    var dls = this.dlMgr.activeDownloads;
    while (dls.hasMoreElements()) {
      var dl = dls.getNext().QueryInterface(this.Ci.nsIDownload);
      if (dl.state != this.iface.DOWNLOAD_DOWNLOADING ||
            dl.percentComplete == -1 /* indeterminate */)
          continue;
      
      total += dl.size;
      cur += dl.amountTransferred;
    }
    
    if (total == 0) {
      this.dockProgress.SetHidden();
    } else {
      var pct = 100.0 * cur / total;
      this.dockProgress.SetProgress(pct);
    }
  },
  
  onDownloadStateChange: function(state, dl) { this.update("DL state") },
  onStateChange: function(prog, req, flags, status, dl)
    { this.update("state") },
  onProgressChange: function(prog, req, cur, max, tcur, tmax, dl)
    { this.update("progress") },
  onSecurityChange: function(prog, req, state, dl) { this.update("security") }
};

dockProgress.setup();
