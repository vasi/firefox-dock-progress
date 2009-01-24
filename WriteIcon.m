#import <Cocoa/Cocoa.h>

int main(void) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSApplicationLoad();
	
	NSImage *img = [[NSImage alloc] initWithSize: NSMakeSize(128, 128)];
	
	NSImage *gradient = [[NSImage alloc]
		initByReferencingFile: @"images/MiniProgressGradient.png"];
	NSRect bar = NSMakeRect(0, 20, 127, 24);
	
	[img lockFocus];
	
	[[NSColor whiteColor] set];
	[NSBezierPath fillRect: bar];
	
	NSRect done = bar;
	done.size.width = 85;
	NSRect gradRect = NSZeroRect;
	gradRect.size = [gradient size];
	[gradient drawInRect: done fromRect: gradRect operation: NSCompositeCopy
		fraction: 1.0];
	
	[[NSColor blackColor] set];
	[NSBezierPath strokeRect: bar];
	
	[img unlockFocus];
	
	
	NSBitmapImageRep *rep = [NSBitmapImageRep imageRepWithData:
		[img TIFFRepresentation]];
	NSData *data = [rep representationUsingType: NSPNGFileType properties: nil];
	[data writeToFile: @"icon.png" atomically: YES];
	
	return 0;
}
