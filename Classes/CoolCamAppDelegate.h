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
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
- (void)applicationDidFinishLaunching:(UIApplication *)application;
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo;
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
@end

