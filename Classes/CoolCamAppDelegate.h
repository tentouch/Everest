//
//  CoolCamAppDelegate.h
//  CoolCam
//
//  Created by Тен Тач on 9/4/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoolCamAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UIImagePickerController* imagePickerController;
	UIImageView* imageView;
	NSMutableString *applicationState;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSMutableString *applicationState;
- (void)applicationDidFinishLaunching:(UIApplication *)application;
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo;
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
// use to perform fraceful termination
- (void)applicationWillTerminate:(UIApplication *)application;
// signals interruption
- (void)applicationWillResignActive:(UIApplication *)application;
// use to restore application to state before interruption
- (void)applicationDidBecomeActive:(UIApplication *)application;
@end

