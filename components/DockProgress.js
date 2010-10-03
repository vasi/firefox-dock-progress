Components.utils.import("resource://gre/modules/XPCOMUtils.jsm");

function DockProgress() {
    Components.utils.import("resource://gre/modules/ctypes.jsm");
    var file = this.getFile("chrome://dockprogress/content/DockProgressC.dylib");
    var lib = this.lib = ctypes.open(file);
    
    this.cSetHidden = lib.declare('FDPSetHidden', ctypes.default_abi,
        ctypes.void_t);
    this.cSetProgress = lib.declare('FDPSetProgress', ctypes.default_abi,
        ctypes.void_t, ctypes.double);
    this.cSetStyle = lib.declare('FDPSetStyle', ctypes.default_abi,
        ctypes.void_t, ctypes.int);
    this.cSetGradientPath = lib.declare('FDPSetGradientPath', ctypes.default_abi,
        ctypes.void_t, ctypes.char.ptr);
}

DockProgress.prototype = {
  classDescription: "Dock icon progress bar",
  classID:          Components.ID("{3146FBBB-CBDF-4A0F-BC00-00CAD2C75E58}"),
  contractID:       "@vasi.dyndns.org/DockProgress/DockProgress;1",
  QueryInterface: XPCOMUtils.generateQI([Components.interfaces.IDockProgress]),
  
  SetHidden: function() {
      this.cSetHidden();
  },
  SetProgress: function(percent) {
      this.cSetProgress(percent);
  },
  SetGradientPath: function(path) {
      this.cSetGradientPath(path);
  },
  SetStyle: function(style) {
      this.cSetStyle(style);
  },
  
  // From http://harthur.wordpress.com/2010/02/28/playing-around-with-js-ctypes-in-linux/
  getFile: function(chromeURL) {
    // convert the chrome URL into a file URL
    var cr = Components.classes['@mozilla.org/chrome/chrome-registry;1']
             .getService(Components.interfaces.nsIChromeRegistry);
    var io = Components.classes['@mozilla.org/network/io-service;1']
             .getService(Components.interfaces.nsIIOService);
    var uri = io.newURI(decodeURI(chromeURL), 'UTF-8', null);
    var fileURL = cr.convertChromeURL(uri);
    // get the nsILocalFile for the file
    return fileURL.QueryInterface(Components.interfaces.nsIFileURL).
        file.path;
  }
  
};

const NSGetFactory = XPCOMUtils.generateNSGetFactory([DockProgress]);
