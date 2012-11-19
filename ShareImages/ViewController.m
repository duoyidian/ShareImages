//
//  ViewController.m
//  ShareImages
//
//  Created by NFJ on 12-11-16.
//  Copyright (c) 2012年 DMC. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest/ASIHTTPRequest.h"
#import "ASIHTTPRequest/ASIFormDataRequest.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView;

-(IBAction)buttonClicked:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:^{
        ;
    }];
}

- (IBAction)buttonCamera:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:^{
        ;
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        ;
    }];
    imageView.image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
   
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        //震动效果
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); 
        
        NSData* imageData = UIImageJPEGRepresentation(imageView.image,0.8);
        NSString* urlString=@"http://192.168.0.189/php/picupload/upload_pic.php";
        NSURL* url=[NSURL URLWithString:urlString];
        ASIFormDataRequest* request=[ASIFormDataRequest requestWithURL:url];
        [request setData:imageData withFileName:@"test.jpg" andContentType:@"image/jpg" forKey:@"pic"];
        [request addPostValue:@"upload_pic" forKey:@"action"];
        
        [request setTag:101];
        [request setDelegate:self];
        [request startAsynchronous];

        
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==101) {
        NSString* s=[request responseString];
        NSLog(@"string is %@",s);
        if ([s isEqualToString:@"{\"Status\":\"OK\"}"]) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"图片上传成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"图片上传失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];

        }
    }


}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
