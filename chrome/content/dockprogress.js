var dockProgress = {
  setup: function() {
    this.Cc = Components.classes;
    this.Ci = Components.interfaces;
    this.IDLM = this.Ci.nsIDownloadManager;
    
    this.dlMgr = this.Cc["@mozilla.org/download-manager;1"]
      .getService(this.IDLM);
    this.dlMgr.addListener(this);
    
    this.dockProgress = this.Cc["@vasi.dyndns.org/DockProgress/DockProgress;1"]
      .getService(this.Ci.IDockProgress);
    
    this.findGradient();
    this.monitorPrefs();
  },
  
  monitorPrefs : function() {
    this.prefs = this.Cc["@mozilla.org/preferences-service;1"]
      .getService(this.Ci.nsIPrefService)
      .getBranch("dockprogress.");
    this.prefs.QueryInterface(this.Ci.nsIPrefBranch2);
    this.prefs.addObserver("", this, false);
    
    this.updateStyle();
  },
  
  observe: function(subject, topic, data) {
    if (topic == "nsPref:changed" && data == "progressStyle")
      this.updateStyle();
  },
  
  updateStyle: function() {
    var style = this.prefs.getIntPref("progressStyle");
    this.dockProgress.SetStyle(style);
  },
  
  findGradient: function() {
    var extMgr = this.Cc["@mozilla.org/extensions/manager;1"]
      .getService(this.Ci.nsIExtensionManager);
    var extID = "dockprogress@vasi.dyndns.org";
    var instLoc = extMgr.getInstallLocation(extID);
    var file = instLoc.getItemFile(extID,
      "chrome/content/MiniProgressGradient.png");
    this.dockProgress.SetGradientPath(file.path);
  },
  
  update: function(meth) {
    var total = 0, cur = 0;
    
    var dls = this.dlMgr.activeDownloads;
    while (dls.hasMoreElements()) {
      var dl = dls.getNext().QueryInterface(this.Ci.nsIDownload);
      if (dl.state != this.IDLM.DOWNLOAD_DOWNLOADING ||
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
