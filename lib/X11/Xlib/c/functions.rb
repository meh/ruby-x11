#--
# Copyleft meh. [http://meh.paranoid.pk | meh@paranoici.org]
#
# Redistribution and use in source and binary forms, with or without modification, are
# permitted provided that the following conditions are met:
#
#    1. Redistributions of source code must retain the above copyright notice, this list of
#       conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above copyright notice, this list
#       of conditions and the following disclaimer in the documentation and/or other materials
#       provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY meh ''AS IS'' AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL meh OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# The views and conclusions contained in the software and documentation are those of the
# authors and should not be interpreted as representing official policies, either expressed
# or implied.
#++

module X11; module C

attach_function :XLoadQueryFont, [:pointer, :string], :pointer
attach_function :XQueryFont, [:pointer, :XID], :pointer

attach_function :XGetMotionEvents, [:pointer, :Window, :Time, :Time, :pointer], :pointer

attach_function :XDeleteModifiermapEntry, [:pointer, :KeyCode, :int], :pointer
attach_function :XGetModifierMapping, [:pointer], :pointer
attach_function :XInsertModifiermapEntry, [:pointer, :KeyCode, :int], :pointer
attach_function :XNewModifiermap, [:int], :pointer

attach_function :XCreateImage, [:pointer, :pointer, :uint, :int, :int, :pointer, :int, :int, :int, :int], :pointer
attach_function :XInitImage, [:pointer], :Status
attach_function :XGetImage, [:pointer, :Drawable, :int, :int, :uint, :uint, :ulong, :int], :pointer
attach_function :XGetSubImage, [:pointer, :Drawable, :int, :int, :uint, :uint, :ulong, :int, :pointer, :int, :int], :pointer

attach_function :XOpenDisplay, [:string], :pointer
attach_function :XrmInitialize, [], :void

attach_function :XFetchBytes, [:pointer, :int], :pointer
attach_function :XFetchBuffer, [:pointer, :pointer, :int], :pointer

attach_function :XGetAtomName, [:pointer, :Atom], :string
attach_function :XGetAtomNames, [:pointer, :pointer, :int, :pointer], :Status

attach_function :XGetDefault, [:pointer, :string, :string], :string
attach_function :XDisplayName, [:string], :string

attach_function :XKeysymToString, [:KeySym], :string

attach_function :XInternAtom, [:pointer, :string, :Bool], :Atom
attach_function :XInternAtoms, [:pointer, :pointer, :int, :Bool, :pointer], :Status

attach_function :XCopyColormapAndFree, [:pointer, :Colormap], :Colormap
attach_function :XCreateColormap, [:pointer, :Window, :pointer, :int], :Colormap

attach_function :XCreatePixmapCursor, [:pointer, :Pixmap, :Pixmap, :pointer, :pointer, :uint, :uint], :Cursor
attach_function :XCreateGlyphCursor, [:pointer, :Font, :Font, :uint, :uint, :pointer, :pointer], :Cursor
attach_function :XCreateFontCursor, [:pointer, :uint], :Cursor

attach_function :XLoadFont, [:pointer, :string], :Font

attach_function :XCreateGC, [:pointer, :Drawable, :ulong, :pointer], :GC
attach_function :XGContextFromGC, [:GC], :GContext
attach_function :XFlushGC, [:pointer, :GC], :void

attach_function :XCreatePixmap, [:pointer, :Drawable, :uint, :uint, :uint], :Pixmap
attach_function :XCreateBitmapFromData, [:pointer, :Drawable, :pointer, :int, :int], :Pixmap
attach_function :XCreatePixmapFromBitmapData, [:pointer, :Drawable, :pointer, :uint, :uint, :ulong, :ulong, :uint], :Pixmap

attach_function :XCreateSimpleWindow, [:pointer, :Window, :int, :int, :uint, :uint, :uint, :ulong, :ulong], :Window
attach_function :XGetSelectionOwner, [:pointer, :Atom], :Window
attach_function :XCreateWindow, [:pointer, :Window, :int, :int, :uint, :uint, :uint, :int, :uint, :pointer, :ulong, :pointer], :Window

attach_function :XListInstalledColormaps, [:pointer, :Window, :pointer], :pointer
attach_function :XListFonts, [:pointer, :string, :int, :pointer], :pointer
attach_function :XListFontsWithInfo, [:pointer, :string, :int, :pointer, :pointer], :pointer
attach_function :XGetFontPath, [:pointer, :int], :pointer
attach_function :XListExtensions, [:pointer, :pointer], :pointer
attach_function :XListProperties, [:pointer, :Window, :pointer], :pointer
attach_function :XListHosts, [:pointer, :pointer, :pointer], :pointer

attach_function :XKeycodeToKeysym, [:pointer, :KeyCode, :int], :KeySym
attach_function :XLookupKeysym, [:pointer, :int], :KeySym
attach_function :XGetKeyboardMapping, [:pointer, :KeyCode, :int, :pointer], :pointer
attach_function :XStringToKeysym, [:string], :KeySym

attach_function :XMaxRequestSize, [:pointer], :long
attach_function :XExtendedMaxRequestSize, [:pointer], :long

attach_function :XResourceManagerString, [:pointer], :string
attach_function :XScreenResourceString, [:pointer], :string

attach_function :XDisplayMotionBufferSize, [:pointer], :ulong

attach_function :XVisualIDFromVisual, [:pointer], :VisualID

# multithread routines
attach_function :XInitThreads, [], :Status
attach_function :XLockDisplay, [:pointer], :void
attach_function :XUnlockDisplay, [:pointer], :void

# routines for dealing with extensions
attach_function :XInitExtension, [:pointer, :string], :pointer
attach_function :XAddExtension, [:pointer], :pointer
attach_function :XFindOnExtensionList, [:pointer, :int], :pointer
#attach_function :XEHeadOfExtensionList, [XEDataObject], :pointer

# these are routines for which there are also macros
attach_function :XRootWindow, [:pointer, :int], :Window
attach_function :XDefaultRootWindow, [:pointer], :Window
attach_function :XRootWindowOfScreen, [:pointer], :Window
attach_function :XDefaultVisual, [:pointer, :int], :pointer
attach_function :XDefaultVisualOfScreen, [:pointer], :pointer
attach_function :XDefaultGC, [:pointer, :int], :GC
attach_function :XDefaultGCOfScreen, [:pointer], :GC
attach_function :XBlackPixel, [:pointer, :int], :ulong
attach_function :XWhitePixel, [:pointer, :int], :ulong
attach_function :XAllPlanes, [], :ulong
attach_function :XBlackPixelOfScreen, [:pointer], :ulong
attach_function :XWhitePixelOfScreen, [:pointer], :ulong
attach_function :XNextRequest, [:pointer], :ulong
attach_function :XLastKnownRequestProcessed, [:pointer], :ulong
attach_function :XServerVendor, [:pointer], :string
attach_function :XDisplayString, [:pointer], :string
attach_function :XDefaultColormap, [:pointer, :int], :Colormap
attach_function :XDefaultColormapOfScreen, [:pointer], :Colormap
attach_function :XDisplayOfScreen, [:pointer], :pointer
attach_function :XScreenOfDisplay, [:pointer, :int], :pointer
attach_function :XDefaultScreenOfDisplay, [:pointer], :pointer
attach_function :XEventMaskOfScreen, [:pointer], :long
attach_function :XScreenNumberOfScreen, [:pointer], :int

attach_function :XSetErrorHandler, [:pointer], :pointer
attach_function :XSetIOErrorHandler, [:pointer], :pointer

attach_function :XListPixmapFormats, [:pointer, :pointer], :pointer
attach_function :XListDepths, [:pointer, :int, :pointer], :pointer

# ICCCM routines for things that don't require special include files
attach_function :XReconfigureWMWindow, [:pointer, :Window, :int, :uint, :pointer], :Status
attach_function :XGetWMProtocols, [:pointer, :Window, :pointer, :pointer], :Status
attach_function :XSetWMProtocols, [:pointer, :Window, :pointer, :int], :Status
attach_function :XIconifyWindow, [:pointer, :Window, :int], :Status
attach_function :XWithdrawWindow, [:pointer, :Window, :int], :Status
attach_function :XGetCommand, [:pointer, :Window, :pointer, :pointer], :Status
attach_function :XGetWMColormapWindows, [:pointer, :Window, :pointer, :pointer], :Status
attach_function :XSetWMColormapWindows, [:pointer, :Window, :pointer, :int], :Status
attach_function :XFreeStringList, [:pointer], :void
attach_function :XSetTransientForHint, [:pointer, :Window, :Window], :int

# The following are given in alphabetical order
attach_function :XActivateScreenSaver, [:pointer], :int
attach_function :XAddHost, [:pointer, :pointer], :int
attach_function :XAddHosts, [:pointer, :pointer, :int], :int
attach_function :XAddToExtensionList, [:pointer, :pointer], :int
attach_function :XAddToSaveSet, [:pointer, :Window], :int
attach_function :XAllocColor, [:pointer, :Colormap, :pointer], :Status
attach_function :XAllocColorCells, [:pointer, :Colormap, :Bool, :pointer, :uint, :pointer, :uint], :Status
attach_function :XAllocColorPlanes, [:pointer, :Colormap,:Bool, :pointer, :int, :int, :int, :int, :pointer, :pointer, :pointer], :Status
attach_function :XAllocNamedColor, [:pointer, :Colormap, :string, :pointer, :pointer], :Status
attach_function :XAllowEvents, [:pointer, :int, :Time], :int
attach_function :XAutoRepeatOff, [:pointer], :int
attach_function :XAutoRepeatOn, [:pointer], :int
attach_function :XBell, [:pointer, :int], :int
attach_function :XBitmapBitOrder, [:pointer], :int
attach_function :XBitmapPad, [:pointer], :int
attach_function :XBitmapUnit, [:pointer], :int
attach_function :XCellsOfScreen, [:pointer], :int
attach_function :XChangeActivePointerGrab, [:pointer, :uint, :Cursor, :Time], :int
attach_function :XChangeGC, [:pointer, :GC, :ulong, :pointer], :int
attach_function :XChangeKeyboardControl, [:pointer, :ulong, :pointer], :int
attach_function :XChangePointerControl, [:pointer, :Bool, :Bool, :int, :int, :int], :int
attach_function :XChangeProperty, [:pointer, :Window, :Atom, :Atom, :int, :int, :pointer, :int], :int
attach_function :XChangeSaveSet, [:pointer, :Window, :int], :int
attach_function :XChangeWindowAttributes, [:pointer, :Window, :ulong, :pointer], :int
attach_function :XCheckIfEvent, [:pointer, :pointer, :pointer, :pointer], :Bool
attach_function :XCheckMaskEvent, [:pointer, :long, :pointer], :Bool
attach_function :XCheckTypedEvent, [:pointer, :int, :pointer], :Bool
attach_function :XCheckTypedWindowEvent, [:pointer, :Window, :int, :pointer], :Bool
attach_function :XCheckWindowEvent, [:pointer, :Window, :long, :pointer], :Bool
attach_function :XCirculateSubwindows, [:pointer, :Window, :int], :int
attach_function :XCirculateSubwindowsDown, [:pointer, :Window], :int
attach_function :XCirculateSubwindowsUp, [:pointer, :Window], :int
attach_function :XClearArea, [:pointer, :Window, :int, :int, :uint, :uint, :Bool], :int
attach_function :XClearWindow, [:pointer, :Window], :int
attach_function :XCloseDisplay, [:pointer], :int
attach_function :XConfigureWindow, [:pointer, :Window, :uint, :pointer], :int
attach_function :XConnectionNumber, [:pointer], :int
attach_function :XConvertSelection, [:pointer, :Atom, :Atom, :Atom, :Window, :Time], :int
attach_function :XCopyArea, [:pointer, :Drawable, :Drawable, :GC, :int, :int, :uint, :uint, :int, :int], :int
attach_function :XCopyGC, [:pointer, :GC, :ulong, :GC], :int
attach_function :XCopyPlane, [:pointer, :Drawable, :Drawable, :GC, :int, :int, :uint, :uint, :int, :int, :ulong], :int
attach_function :XDefaultDepth, [:pointer, :int], :int
attach_function :XDefaultDepthOfScreen, [:pointer], :int
attach_function :XDefaultScreen, [:pointer], :int
attach_function :XDefineCursor, [:pointer, :Window, :Cursor], :int
attach_function :XDeleteProperty, [:pointer, :Window, :Atom], :int
attach_function :XDestroyWindow, [:pointer, :Window], :int
attach_function :XDestroySubwindows, [:pointer, :Window], :int
attach_function :XDoesBackingStore, [:pointer], :int
attach_function :XDoesSaveUnders, [:pointer], :Bool
attach_function :XDisableAccessControl, [:pointer], :int
attach_function :XDisplayCells, [:pointer, :int], :int
attach_function :XDisplayHeight, [:pointer, :int], :int
attach_function :XDisplayHeightMM, [:pointer, :int], :int
attach_function :XDisplayKeycodes, [:pointer, :pointer, :pointer], :int
attach_function :XDisplayPlanes, [:pointer, :int], :int
attach_function :XDisplayWidth, [:pointer, :int], :int
attach_function :XDisplayWidthMM, [:pointer, :int], :int
attach_function :XDrawArc, [:pointer, :Drawable, :GC, :int, :int, :uint, :uint, :int, :int], :int
attach_function :XDrawArcs, [:pointer, :Drawable, :GC, :pointer, :int], :int
attach_function :XDrawImageString, [:pointer, :Drawable, :GC, :int, :int, :pointer, :int], :int
attach_function :XDrawImageString16, [:pointer, :Drawable, :GC, :int, :int, :pointer, :int], :int
attach_function :XDrawLine, [:pointer, :Drawable, :GC, :int, :int, :int, :int], :int
attach_function :XDrawLines, [:pointer, :Drawable, :GC, :pointer, :int, :int], :int
attach_function :XDrawPoint, [:pointer, :Drawable, :GC, :int, :int], :int
attach_function :XDrawPoints, [:pointer, :Drawable, :GC, :pointer, :int, :int], :int
attach_function :XDrawRectangle, [:pointer, :Drawable, :GC, :int, :int, :uint, :uint], :int
attach_function :XDrawRectangles, [:pointer, :Drawable, :GC, :pointer, :int], :int
attach_function :XDrawSegments, [:pointer, :Drawable, :GC, :pointer, :int], :int
attach_function :XDrawString, [:pointer, :Drawable, :GC, :int, :int, :pointer, :int], :int
attach_function :XDrawString16, [:pointer, :Drawable, :GC, :int, :int, :pointer, :int], :int
attach_function :XDrawText, [:pointer, :Drawable, :GC, :int, :int, :pointer, :int], :int
attach_function :XDrawText16, [:pointer, :Drawable, :GC, :int, :int, :pointer, :int], :int
attach_function :XEnableAccessControl, [:pointer], :int
attach_function :XEventsQueued, [:pointer, :int], :int
attach_function :XFetchName, [:pointer, :Window, :pointer], :Status
attach_function :XFillArc, [:pointer, :Drawable, :GC, :int, :int, :uint, :uint, :int, :int], :int
attach_function :XFillArcs, [:pointer, :Drawable, :GC, :pointer, :int], :int
attach_function :XFillPolygon, [:pointer, :Drawable, :GC, :pointer, :int, :int, :int], :int
attach_function :XFillRectangle, [:pointer, :Drawable, :GC, :int, :int, :uint, :uint], :int
attach_function :XFillRectangles, [:pointer, :Drawable, :GC, :pointer, :int], :int
attach_function :XFlush, [:pointer], :int
attach_function :XForceScreenSaver, [:pointer, :int], :int
attach_function :XFree, [:pointer], :int
attach_function :XFreeColormap, [:pointer, :Colormap], :int
attach_function :XFreeColors, [:pointer, :Colormap, :pointer, :int, :ulong], :int
attach_function :XFreeCursor, [:pointer, :Cursor], :int
attach_function :XFreeExtensionList, [:pointer], :int
attach_function :XFreeFont, [:pointer, :pointer], :int
attach_function :XFreeFontInfo, [:pointer, :pointer, :int], :int
attach_function :XFreeFontNames, [:pointer], :int
attach_function :XFreeFontPath, [:pointer], :int
attach_function :XFreeGC, [:pointer, :GC], :int
attach_function :XFreeModifiermap, [:pointer], :int
attach_function :XFreePixmap, [:pointer, :Pixmap], :int
attach_function :XGeometry, [:pointer, :int, :pointer, :pointer, :uint, :uint, :uint, :int, :int, :pointer, :pointer, :pointer, :pointer], :int
attach_function :XGetErrorDatabaseText, [:pointer, :string, :string, :string, :pointer, :int], :int
attach_function :XGetErrorText, [:pointer, :int, :pointer, :int], :int
attach_function :XGetFontProperty, [:pointer, :Atom, :ulong], :Bool
attach_function :XGetGCValues, [:pointer, :GC, :ulong, :pointer], :Status
attach_function :XGetGeometry, [:pointer, :Drawable, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], :Status
attach_function :XGetIconName, [:pointer, :Window, :pointer], :Status
attach_function :XGetInputFocus, [:pointer, :pointer, :pointer], :int
attach_function :XGetKeyboardControl, [:pointer, :pointer], :int
attach_function :XGetPointerControl, [:pointer, :pointer, :pointer, :pointer], :int
attach_function :XGetPointerMapping, [:pointer, :pointer, :int], :int
attach_function :XGetScreenSaver, [:pointer, :pointer, :pointer, :pointer, :pointer], :int
attach_function :XGetTransientForHint, [:pointer, :Window, :pointer], :Status
attach_function :XGetWindowProperty, [:pointer, :Window, :Atom, :long, :long, :Bool, :Atom, :pointer, :pointer, :pointer, :pointer, :pointer], :int
attach_function :XGetWindowAttributes, [:pointer, :Window, :pointer], :Status
attach_function :XGrabButton, [:pointer, :uint, :uint, :Window, :Bool, :uint, :int, :int, :Window, :Cursor], :int
attach_function :XGrabKey, [:pointer, :int, :uint, :Window, :Bool, :int, :int], :int
attach_function :XGrabKeyboard, [:pointer, :Window, :Bool, :int, :int, :Time], :int
attach_function :XGrabPointer, [:pointer, :Window, :Bool, :uint, :int, :int, :Window, :Cursor, :Time], :int
attach_function :XGrabServer, [:pointer], :int
attach_function :XHeightOfScreen, [:pointer], :int
attach_function :XIfEvent, [:pointer, :pointer, :pointer, :pointer], :int
attach_function :XImageByteOrder, [:pointer], :int
attach_function :XInstallColormap, [:pointer, :Colormap], :int
attach_function :XKeysymToKeycode, [:pointer, :KeySym], :KeyCode
attach_function :XKillClient, [:pointer, :XID], :int
attach_function :XLookupColor, [:pointer, :Colormap, :string, :pointer, :pointer], :Status
attach_function :XLowerWindow, [:pointer, :Window], :int
attach_function :XMapRaised, [:pointer, :Window], :int
attach_function :XMapSubwindows, [:pointer, :Window], :int
attach_function :XMapWindow, [:pointer, :Window], :int
attach_function :XMaskEvent, [:pointer, :long, :pointer], :int
attach_function :XMaxCmapsOfScreen, [:pointer], :int
attach_function :XMinCmapsOfScreen, [:pointer], :int
attach_function :XMoveResizeWindow, [:pointer, :Window, :int, :int, :uint, :uint], :int
attach_function :XMoveWindow, [:pointer, :Window, :int, :int], :int
attach_function :XNextEvent, [:pointer, :pointer], :int
attach_function :XNoOp, [:pointer], :int
attach_function :XParseColor, [:pointer, :Colormap, :string, :pointer], :Status
attach_function :XParseGeometry, [:string, :pointer, :pointer, :pointer, :pointer], :int
attach_function :XPeekEvent, [:pointer, :pointer], :int
attach_function :XPeekIfEvent, [:pointer, :pointer, :pointer, :pointer], :int
attach_function :XPending, [:pointer], :int
attach_function :XPlanesOfScreen, [:pointer], :int
attach_function :XProtocolRevision, [:pointer], :int
attach_function :XProtocolVersion, [:pointer], :int
attach_function :XPutBackEvent, [:pointer, :pointer], :int
attach_function :XPutImage, [:pointer, :Drawable, :GC, :pointer, :int, :int, :int, :int, :uint, :uint], :int
attach_function :XQLength, [:pointer], :int
attach_function :XQueryBestCursor, [:pointer, :Drawable, :uint, :uint, :pointer, :pointer], :int
attach_function :XQueryBestSize, [:pointer, :int, :Drawable, :uint, :uint, :pointer, :pointer], :int
attach_function :XQueryBestStipple, [:pointer, :Drawable, :uint, :uint, :pointer, :pointer], :int
attach_function :XQueryBestTile, [:pointer, :Drawable, :uint, :uint, :pointer, :pointer], :int
attach_function :XQueryColor, [:pointer, :Colormap, :pointer], :int
attach_function :XQueryColors, [:pointer, :Colormap, :pointer, :int], :int
attach_function :XQueryExtension, [:pointer, :string, :pointer, :pointer, :pointer], :Bool
attach_function :XQueryKeymap, [:pointer, :pointer], :int
attach_function :XQueryPointer, [:pointer, :Window, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], :Bool
attach_function :XQueryTextExtents, [:pointer, :XID, :string, :int, :pointer, :pointer, :pointer, :pointer], :int
attach_function :XQueryTextExtents16, [:pointer, :XID, :pointer, :int, :pointer, :pointer, :pointer, :pointer], :int
attach_function :XQueryTree, [:pointer, :Window, :pointer, :pointer, :pointer, :pointer], :Status
attach_function :XRaiseWindow, [:pointer, :Window], :int
attach_function :XReadBitmapFile, [:pointer, :Drawable, :string, :pointer, :pointer, :pointer, :pointer, :pointer], :int
attach_function :XReadBitmapFileData, [:string, :pointer, :pointer, :pointer, :pointer, :pointer], :int
attach_function :XRebindKeysym, [:pointer, :KeySym, :pointer, :int, :string, :int], :int
attach_function :XRecolorCursor, [:pointer, :Cursor, :pointer, :pointer], :int
attach_function :XRefreshKeyboardMapping, [:pointer], :int
attach_function :XRemoveFromSaveSet, [:pointer, :Window], :int
attach_function :XRemoveHost, [:pointer, :pointer], :int
attach_function :XRemoveHosts, [:pointer, :pointer, :int], :int
attach_function :XReparentWindow, [:pointer, :Window, :Window, :int, :int], :int
attach_function :XResetScreenSaver, [:pointer], :int
attach_function :XResizeWindow, [:pointer, :Window, :uint, :uint], :int
attach_function :XRestackWindows, [:pointer, :pointer, :int], :int
attach_function :XRotateBuffers, [:pointer, :int], :int
attach_function :XRotateWindowProperties, [:pointer, :Window, :pointer, :int, :int], :int
attach_function :XScreenCount, [:pointer], :int
attach_function :XSelectInput, [:pointer, :Window, :long], :int
attach_function :XSendEvent, [:pointer, :Window, :Bool, :long, :pointer], :Status
attach_function :XSetAccessControl, [:pointer, :int], :int
attach_function :XSetArcMode, [:pointer, :GC, :int], :int
attach_function :XSetBackground, [:pointer, :GC, :ulong], :int
attach_function :XSetClipMask, [:pointer, :GC, :Pixmap], :int
attach_function :XSetClipOrigin, [:pointer, :GC, :int, :int], :int
attach_function :XSetClipRectangles, [:pointer, :GC, :int, :int, :pointer, :int, :int], :int
attach_function :XSetCloseDownMode, [:pointer, :int], :int
attach_function :XSetCommand, [:pointer, :Window, :pointer, :int], :int
attach_function :XSetDashes, [:pointer, :GC, :int, :pointer, :int], :int
attach_function :XSetFillRule, [:pointer, :GC, :int], :int
attach_function :XSetFillStyle, [:pointer, :GC, :int], :int
attach_function :XSetFont, [:pointer, :GC, :Font], :int
attach_function :XSetFontPath, [:pointer, :pointer, :int], :int
attach_function :XSetForeground, [:pointer, :GC, :ulong], :int
attach_function :XSetFunction, [:pointer, :GC, :int], :int
attach_function :XSetGraphicsExposures, [:pointer, :GC, :Bool], :int
attach_function :XSetIconName, [:pointer, :Window, :string], :int
attach_function :XSetInputFocus, [:pointer, :Window, :int, :Time], :int
attach_function :XSetLineAttributes, [:pointer, :GC, :uint, :int, :int, :int], :int
attach_function :XSetModifierMapping, [:pointer, :pointer], :int
attach_function :XSetPlaneMask, [:pointer, :GC, :ulong], :int
attach_function :XSetPointerMapping, [:pointer, :pointer, :int], :int
attach_function :XSetScreenSaver, [:pointer, :int, :int, :int, :int], :int
attach_function :XSetSelectionOwner, [:pointer, :Atom, :Window, :Time], :int
attach_function :XSetState, [:pointer, :GC, :ulong, :ulong, :int, :ulong], :int
attach_function :XSetStipple, [:pointer, :GC, :Pixmap], :int
attach_function :XSetSubwindowMode, [:pointer, :GC, :int], :int
attach_function :XSetTSOrigin, [:pointer, :GC, :int, :int], :int
attach_function :XSetTile, [:pointer, :GC, :Pixmap], :int
attach_function :XSetWindowBackground, [:pointer, :Window, :ulong], :int
attach_function :XSetWindowBackgroundPixmap, [:pointer, :Window, :Pixmap], :int
attach_function :XSetWindowBorder, [:pointer, :Window, :ulong], :int
attach_function :XSetWindowBorderPixmap, [:pointer, :Window, :Pixmap], :int
attach_function :XSetWindowBorderWidth, [:pointer, :Window, :uint], :int
attach_function :XSetWindowColormap, [:pointer, :Window, :Colormap], :int
attach_function :XStoreBuffer, [:pointer, :pointer, :int, :int], :int
attach_function :XStoreBytes, [:pointer, :pointer, :int], :int
attach_function :XStoreColor, [:pointer, :Colormap, :pointer], :int
attach_function :XStoreColors, [:pointer, :Colormap, :pointer, :int], :int
attach_function :XStoreName, [:pointer, :Window, :string], :int
attach_function :XStoreNamedColor, [:pointer, :Colormap, :string, :ulong, :int], :int
attach_function :XSync, [:pointer, :Bool], :int
attach_function :XTextExtents, [:pointer, :string, :int, :pointer, :pointer, :pointer, :pointer], :int
attach_function :XTextExtents16, [:pointer, :pointer, :int, :pointer, :pointer, :pointer, :pointer], :int
attach_function :XTextWidth, [:pointer, :string, :int], :int
attach_function :XTextWidth16, [:pointer, :pointer, :int], :int
attach_function :XTranslateCoordinates, [:pointer, :Window, :Window, :int, :int, :pointer, :pointer, :pointer], :Bool
attach_function :XUndefineCursor, [:pointer, :Window], :int
attach_function :XUngrabButton, [:pointer, :uint, :uint, :Window], :int
attach_function :XUngrabKey, [:pointer, :int, :uint, :Window], :int
attach_function :XUngrabKeyboard, [:pointer, :Time], :int
attach_function :XUngrabPointer, [:pointer, :Time], :int
attach_function :XUngrabServer, [:pointer], :int
attach_function :XUninstallColormap, [:pointer, :Colormap], :int
attach_function :XUnloadFont, [:pointer, :Font], :int
attach_function :XUnmapSubwindows, [:pointer, :Window], :int
attach_function :XUnmapWindow, [:pointer, :Window], :int
attach_function :XVendorRelease, [:pointer], :int
attach_function :XWarpPointer, [:pointer, :Window, :Window, :int, :int, :uint, :uint, :int, :int], :int
attach_function :XWidthMMOfScreen, [:pointer], :int
attach_function :XWindowEvent, [:pointer, :Window, :long, :pointer], :int
attach_function :XWriteBitmapFile, [:pointer, :string, :Pixmap, :uint, :uint, :int, :int], :int

attach_function :XSupportsLocale, [], :Bool
attach_function :XSetLocaleModifiers, [:pointer], :int

# XXX: XOM and XOC, XIC, XIM, what the fuck.

attach_function :XFilterEvent, [:pointer, :Window], :Bool

attach_function :XInternalConnectionNumbers, [:pointer, :pointer, :pointer], :Status
attach_function :XProcessInternalConnection, [:pointer, :int], :void
attach_function :XAddConnectionWatch, [:pointer, :pointer, :pointer], :Status
attach_function :XRemoveConnectionWatch, [:pointer, :pointer, :pointer], :void
attach_function :XSetAuthorization, [:string, :int, :pointer, :int], :void

attach_function :XGetEventData, [:pointer, :pointer], :Bool
attach_function :XFreeEventData, [:pointer, :pointer], :void

end; end
