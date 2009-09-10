//
//  ImageProcessor.m
//  CoolCam
//
//  Created by Тен Тач on 9/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageProcessor.h"





CGContextRef CreateARGBBitmapContext (CGImageRef inImage)
{
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
	
	// Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
	
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
	
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateWithName(kCGImageAlphaOnly);
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
	
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL) 
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
	
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits 
    // per component. Regardless of what the source image format is 
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
									 pixelsWide,
									 pixelsHigh,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
	
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
	
    return context;
}






/*
CGImageRef ManipulateImagePixelData(CGImageRef inImage)
{
	return inImage;
	// Create the bitmap context
	//CGContextRef cgctx = CreateARGBBitmapContext(inImage);
	//CGContextRef cgctx = MyCreateBitmapContext(1600,1200);
	if (cgctx == NULL)
	{
		// error creating context
		return;
	}
	
	// Get image width, height. We'll use the entire image.
	size_t w = CGImageGetWidth(inImage);
	size_t h = CGImageGetHeight(inImage);
	CGRect rect = {{0,0},{w,h}};
	
	// Draw the image to the bitmap context. Once we draw, the memory
	// allocated for the context for rendering will then contain the
	// raw image data in the specified color space.
	CGContextDrawImage(cgctx, rect, inImage);
	
	// Now we can get a pointer to the image data associated with the bitmap
	// context. 
	void *data = CGBitmapContextGetData (cgctx);
	if (data != NULL)
	{
		// **** You have a pointer to the image data ****
		// **** Do stuff with the data here ****
	}
	
	//Get a copy of the context in a CGImageRef
	CGImageRef returnImage = CGBitmapContextCreateImage(cgctx);
	
	// When finished, release the context
	CGContextRelease(cgctx);
	// Free image data memory for the context
	if (data)
	{
		free(data);
	}
	
	return returnImage;
}


*/

CGImageRef ManipulateImagePixelData(CGImageRef img)
{
	CFDataRef m_DataRef; 
	m_DataRef = CGDataProviderCopyData(CGImageGetDataProvider(img));
 

	return img;
}


@implementation ImageProcessor
- (CGImageRef) process: (CGImageRef) img {
	return ManipulateImagePixelData(img);
}

@end
