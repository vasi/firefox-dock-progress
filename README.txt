Dock Progress Extension    (C) 2009 Dave Vasilevsky
-----------------------

This Firefox extension displays a progress bar in the Mac OS X dock when files are being downloaded.

Building
--------

To build the extension for all supported platforms, you need the Mac OS X 10.4 and 10.6 SDKs, gcc 4.0 and clang. The easiest way to do get all of this is with a standard install of Xcode on 10.6 Snow Leopard.

On 10.7 Lion, you can use various hacks to install Xcode 3 with PPC support and the 10.4 SDK. Make sure to install it under /Xcode3, so the build scripts will detect it.

Licensing
---------

This software is available under the MIT License.

Thanks to Uli Kusterer (http://www.zathras.de) for the progress bar gradient, licensed under the MIT Licence.


Todo
----

* Multiple progress bars
* Throttle drawing?
