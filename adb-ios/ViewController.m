//
//  ViewController.m
//  adb-ios
//
//  Created by Li Zonghai on 9/28/15.
//  Copyright (c) 2015 Li Zonghai. All rights reserved.
//

#import "ViewController.h"
#import "adb/AdbClient.h"


//#define IP  "192.168.214.104:26101"
//#define IP  "100.77.59.194:26101"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *IPTextField;
@property(strong) AdbClient *adb;

@end

@implementation ViewController
@synthesize adb = _adb;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _adb = [[AdbClient alloc] initWithVerbose:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) list:(id)sender
{
    [_adb devices:^(BOOL succ, NSString *result1) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result1 waitUntilDone:YES];
    }];
}


-(IBAction)connectBtn:(id)sender
{
    
    NSString *port = @":26101";
    [_adb connect:[_IPTextField.text stringByAppendingString:port] didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
    usleep(10000000);
    
    NSString *apkPath = [[NSBundle mainBundle] pathForResource:@"test_file" ofType:@"tpk"];
    [_adb installApk:apkPath flags:ADBInstallFlag_Replace didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
    
    usleep(10000000);
    NSString *apkPath2 = [[NSBundle mainBundle] pathForResource:@"zotcare2" ofType:@"tpk"];
    [_adb installApk:apkPath2 flags:ADBInstallFlag_Replace didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
    
    usleep(10000000);
    NSString *apkPath3 = [[NSBundle mainBundle] pathForResource:@"third_app" ofType:@"tpk"];
    [_adb installApk:apkPath3 flags:ADBInstallFlag_Replace didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
     
}

-(IBAction)installApkBtn:(id)sender
{
    NSString *apkPath = [[NSBundle mainBundle] pathForResource:@"test_file" ofType:@"tpk"];
    [_adb installApk:apkPath flags:ADBInstallFlag_Replace didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}


-(IBAction)uninstallApkBtn:(id)sender
{
    [_adb uninstallApk:@"jackpal.androidterm" didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}


-(IBAction)startApk:(id)sender
{
    [_adb shell:@"am start jackpal.androidterm/.Term" didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}


-(IBAction)disconnect:(id)sender
{
    
    [_adb disconnect:_IPTextField.text didResponse:^(BOOL succ, NSString *result) {
        
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}


-(IBAction)ps:(id)sender
{
    [_adb shell:@"pm list packages" didResponse:^(BOOL succ, NSString *result) {
        
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}

@end
