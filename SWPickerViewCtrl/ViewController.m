//
//  ViewController.m
//  SWPickerViewCtrl
//
//  Created by iSongWei on 2017/7/27.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "ViewController.h"
#import "SWPickerViewCtrl.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pick1:(id)sender {
    
    SWPickerViewCtrl * pick = [SWPickerViewCtrl pickerViewWithDataArray:@[@"asda",@"sdfds",@"sdfdsfsdf",@"sdfdsf",@"fdsfs"]];
    pick.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    pick.backInfo = ^(NSString * str){
        NSLog(@"%@",str);

    };
    [self presentViewController:pick animated:YES completion:nil];
    
}
- (IBAction)pick2:(id)sender {
    SWPickerViewCtrl * pick = [SWPickerViewCtrl pickerWithPlacePicker];
    pick.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    pick.backInfo = ^(NSString * str){

    };
    [self presentViewController:pick animated:YES completion:nil];
}
- (IBAction)pick3:(id)sender {
    
    SWPickerViewCtrl * pick = [SWPickerViewCtrl pickerWithDataPicker];
    pick.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    pick.backInfo = ^(NSString * str){

    };
    [self presentViewController:pick animated:YES completion:nil];
    
}
@end
