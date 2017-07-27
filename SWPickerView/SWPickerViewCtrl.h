//
//  SWPickerViewCtrl.h
//  Bumblebee
//
//  Created by 张松伟 on 2016/10/10.
//  Copyright © 2016年 zhukeke. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface SWPickerViewCtrl : UIViewController



@property (nonatomic,copy) void(^backInfo)(NSString *);


+(instancetype)pickerViewWithDataArray:(NSArray *)dataArray;

+(instancetype)pickerWithDataPicker;

+(instancetype)pickerWithPlacePicker;

@end
