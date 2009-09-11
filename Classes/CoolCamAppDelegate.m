//
//  CoolCamAppDelegate.m
//  CoolCam
//
//  Created by Тен Тач on 9/4/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Constants.h"
#import "CoolCamAppDelegate.h"
#import "ImageProcessor.h"
#import <stdlib.h>





@implementation CoolCamAppDelegate

@synthesize window;
@synthesize applicationState;


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	UINavigationItem *ipcNavBarTopItem;
	
	// add done button to right side of nav bar
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
																   style:UIBarButtonItemStylePlain 
																  target:self 
																  action:@selector(saveImages:)];
	
	UINavigationBar *bar = navigationController.navigationBar;
	[bar setHidden:YES];
	ipcNavBarTopItem = bar.topItem;
	ipcNavBarTopItem.title = @"Pick Images";
	ipcNavBarTopItem.rightBarButtonItem = doneButton;
}




- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	// state restoration
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:kState];
	applicationState = [[NSMutableString alloc] initWithContentsOfFile:filePath];
	if( applicationState = nil )
	{ // handle this situation
	}
	
	
    // Create window
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	
	// Set up the image picker controller and add it to the view
	imagePickerController = [[UIImagePickerController alloc] init];
	imagePickerController.delegate = self;
	//imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
	imagePickerController.allowsImageEditing = YES;
	imagePickerController.toolbarHidden = YES;
	
	
	
	[window addSubview:imagePickerController.view];
	
	// Set up the image view and add it to the view but make it hidden
	imageView = [[UIImageView alloc] initWithFrame:[window bounds]];
	imageView.hidden = YES;
	[window addSubview:imageView];
	
    [window makeKeyAndVisible];
}

-(void) applicationWillResignActive: (UIApplication *) application
{
	// saving state
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:kState];
	[applicationState writeToFile: filePath atomically:YES encoding: NSASCIIStringEncoding error: nil];
	// instead of nil, maybe interested to see error object
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
	int a = 1;
	a = a + 1;
}


-(void) applicationWillTerminate: (UIApplication *) application
{
	int a = 1;
	a = a + 1;
	
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
 
void transform(unsigned char *rawData, int count, int i)
{
	int change = 50; 
	
	rawData[i] = rawData[i] + change;
	rawData[i+1] = rawData[i+1] + change;
	rawData[i+2] = rawData[i+2] + change;
	rawData[i+3] = rawData[i+3] + change;

}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	// Dismiss the image selection, hide the picker and show the image view with the picked image
	[picker dismissModalViewControllerAnimated:YES];
	imagePickerController.view.hidden = YES;
	
	int a = 1;
	    a = a + 1;
	    
	
	CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
												 bitsPerComponent, bytesPerRow, colorSpace,
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
	
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);	
	
	
	srand(10);
	
	// aide Dani
	
	

	
	
	
	int byteIndex = 0;
	int count = width * height;
    for (int ii = 0 ; ii < count ; ii++)
    {
		//CGFloat red   = rawData[byteIndex];
        //CGFloat green = rawData[byteIndex + 1];
        //CGFloat blue  = rawData[byteIndex + 2];
        //CGFloat alpha = rawData[byteIndex + 3];
		
		transform( rawData , count, byteIndex );
		
		
		//rawData[byteIndex] = red + transform(rawData,count,ii);
		//rawData[byteIndex + 1] = green + transform(rawData,count,ii);
		//rawData[byteIndex + 2] = blue - transform(rawData,count,ii);
		//rawData[byteIndex + 3] = transform(rawData,count,ii);
		
		byteIndex += 4;
	}

	
	CGContextRef context1 = CGBitmapContextCreate(rawData, width, height,
												 bitsPerComponent, bytesPerRow, colorSpace,
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	
	CGImageRef newImage = CGBitmapContextCreateImage(context1);
	
	imageView.image = [UIImage imageWithCGImage:newImage];
	
	
	
	
	
	
	
	
	
	
	
	
	
	//CGImageRef cgImage = image.CGImage;
	//ImageProcessor * imgproc = [[ImageProcessor alloc] init];
	
	//[imgproc process: image.CGImage]
	
	//CGImageRef cgImageNew = ManipulateImagePixelData(cgImage);
	
	
	//imageView.image = [ UIImage imageWithCGImage:  [imgproc process: image.CGImage]  ];
	
	//int width =image.size.width;
	//int height = image.size.height;
	//unsigned char* pixelData = getRGBAsFromImage( image ); 
	//pixelData = malloc(width * height);
	
	/*
	CGContextRef context = CGBitmapContextCreate ( pixelData,  
												  width,            
												  height,            
												  8,           
												  width,            
												  NULL,            
												  kCGImageAlphaOnly); 
	
	//CGContextDrawImage( context, CGRectMake(0, 0, width, height), image.CGImage );
	
	
	
	CGImageRef newImageRef = CGBitmapContextCreateImage(context);
	
	imageView.image = [UIImage imageWithCGImage: newImageRef ];
	*/
	 
	 
	 
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

