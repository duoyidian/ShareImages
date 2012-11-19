//
//  ViewController.h
//  ShareImages
//
//  Created by NFJ on 12-11-16.
//  Copyright (c) 2012年 DMC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestDelegate.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ASIHTTPRequestDelegate>

@property (nonatomic,strong) IBOutlet UIImageView *imageView;

-(IBAction)buttonClicked:(id)sender;
- (IBAction)buttonCamera:(id)sender;

@end
