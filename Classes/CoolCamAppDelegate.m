//
//  CoolCamAppDelegate.m
//  CoolCam
//
//  Created by Тен Тач on 9/4/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "CoolCamAppDelegate.h"
#import "ImageProcessor.h"


@implementation CoolCamAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // Create window
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	
	// Set up the image picker controller and add it to the view
	imagePickerController = [[UIImagePickerController alloc] init];
	imagePickerController.delegate = self;
	//imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
	[window addSubview:imagePickerController.view];
	
	// Set up the image view and add it to the view but make it hidden
	imageView = [[UIImageView alloc] initWithFrame:[window bounds]];
	imageView.hidden = YES;
	[window addSubview:imageView];
	
    [window makeKeyAndVisible];
}

- (void)dealloc
{
	[imagePickerController release];
	[imageView release];
    [window release];
	[super dealloc];
}





/*
CGImageRef ManipulateImagePixelData(CGImageRef inImage)
{
	return inImage;
}
*/
 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	// Dismiss the image selection, hide the picker and show the image view with the picked image
	[picker dismissModalViewControllerAnimated:YES];
	imagePickerController.view.hidden = YES;
	
	//CGImageRef cgImage = image.CGImage;
	//ImageProcessor * imgproc = [[ImageProcessor alloc] init];
	
	//[imgproc process: image.CGImage]
	
	//CGImageRef cgImageNew = ManipulateImagePixelData(cgImage);
	
	
	//imageView.image = [ UIImage imageWithCGImage:  [imgproc process: image.CGImage]  ];
	
	int width =image.size.width;
	int height = image.size.height;
	unsigned char* pixelData; 
	pixelData = malloc(width * height);
	
	
	CGContextRef context = CGBitmapContextCreate ( pixelData,  
												  width,            
												  height,            
												  8,           
												  width,            
												  NULL,            
												  kCGImageAlphaOnly ); 
	
	CGContextDrawImage( context, CGRectMake(0, 0, width, height), image.CGImage );
	
	
	
	imageView.image = image;
	
	//[imgproc release];
	
	
	
	imageView.hidden = NO;
	[window bringSubviewToFront:imageView];
	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	// Dismiss the image selection and close the program
	[picker dismissModalViewControllerAnimated:YES];
	exit(0);
}

@end
