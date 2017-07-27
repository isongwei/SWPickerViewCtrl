//
//  SWPickerViewCtrl.m
//  Bumblebee
//
//  Created by 张松伟 on 2016/10/10.
//  Copyright © 2016年 zhukeke. All rights reserved.
//

#import "SWPickerViewCtrl.h"
#import "UIColor+Extension.h"

#define DeviceHeight [[UIScreen mainScreen]bounds].size.height
#define DeviceWidth [[UIScreen mainScreen]bounds].size.width


@interface SWPickerViewCtrl ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger _provinceIndex;   // 省份选择 记录
    NSInteger _cityIndex;       // 市选择 记录
//    NSInteger _districtIndex;   // 区选择 记录
}

@property (nonatomic,strong) NSString * selProvince;
@property (nonatomic,strong) NSArray * provinceArr;
@property (nonatomic,strong) NSArray * cityArr;
@property (nonatomic,strong) NSDictionary * placeDic;

#pragma mark - ==============================

@property (strong, nonatomic)  UIPickerView *pickerView;

@property (nonatomic,strong)NSArray * dataArray;//展示

@property (nonatomic,strong) NSString * selString;

@property (nonatomic,strong) UIDatePicker * datePicker;











@end

@implementation SWPickerViewCtrl



- (void)viewDidLoad {
    [super viewDidLoad];

}



+(instancetype)pickerViewWithDataArray:(NSArray *)dataArray{
    
    SWPickerViewCtrl * dd = [[SWPickerViewCtrl alloc]init];
    [dd createUIWithDataArray:dataArray];
    return dd;
    
}


-(void)createUIWithDataArray:(NSArray *)dataArray{
    

    
    self.view.backgroundColor = [UIColor clearColor];
    
    //返回
    UIButton * BGBTN = [UIButton buttonWithType:(UIButtonTypeCustom)];
    BGBTN.frame = self.view.bounds;
//    BGBTN.alpha = 0.35;
    BGBTN.backgroundColor =[UIColor clearColor];
    [BGBTN addTarget:self action:@selector(removed) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:BGBTN];
    
    
    UIView * whiteLine = [[UIView alloc]initWithFrame:(CGRectMake(0, DeviceHeight-185, DeviceWidth, 34))];
    whiteLine.backgroundColor  =[UIColor whiteColor];
    [self.view addSubview:whiteLine];
    

    whiteLine.layer.shadowColor = [UIColor grayColor].CGColor;
    whiteLine.layer.shadowOffset = CGSizeMake(0, -1);
    whiteLine.layer.shadowOpacity = 0.8;
    whiteLine.layer.shadowRadius = 1;
    
    
    
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(DeviceWidth-66, 0, 60, 35);
    [button setTitleColor:[UIColor colorWithHexString:@"007aff"] forState:(UIControlStateNormal)];
    [button setTitle:@"完成" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(removed) forControlEvents:(UIControlEventTouchUpInside)];
    [whiteLine addSubview:button];
    
    
    
    // 初始化pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, DeviceHeight-150, DeviceWidth , 150)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.pickerView.showsSelectionIndicator=YES;
    [self.view addSubview:self.pickerView];
    
    //指定数据源和委托
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    if (dataArray.count) {
        _selString = dataArray[0];
        _dataArray = dataArray;
    }else{
        _selString = [NSString stringWithFormat:@"%@ %@",self.provinceArr[0],self.cityArr[0][@"市县"][_cityIndex]];
        _provinceIndex = _cityIndex = 0;
        [self.pickerView selectRow:_provinceIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:_cityIndex inComponent:1 animated:YES];
        
    }
    

    

    
}
#pragma mark pickerView Method
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_dataArray.count) {
        return 1;
    }
    return 2;
}
// 每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_dataArray.count) {
        return _dataArray.count;
    }
    
    if(component == 0){
        return self.provinceArr.count;
    }
    else if (component == 1){
        return [self.cityArr[_provinceIndex][@"市县"] count];
    }
    return 0;
}
//判断是哪个pickerview，返回相应的title
// 返回每一行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (_dataArray.count) {
        return _dataArray[row];
    }
    
    if(component == 0){
        return self.provinceArr[row];
    }
    else if (component == 1){
        return self.cityArr[_provinceIndex][@"市县"][row];
    }
    return @"";
}

#pragma mark 给pickerview设置字体大小和颜色等
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    //可以通过自定义label达到自定义pickerview展示数据的方式
//    UILabel* pickerLabel = (UILabel*)view;
//    if (!pickerLabel){
//        pickerLabel = [[UILabel alloc] init];
//        pickerLabel.adjustsFontSizeToFitWidth = YES;
//        pickerLabel.textAlignment = NSTextAlignmentCenter;
//        [pickerLabel setBackgroundColor:[UIColor lightGrayColor]];
//        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
//    }
//    
//    
//    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];//调用上一个委托方法，获得要展示的title
//    return pickerLabel;
//}
//选中某行后回调的方法，获得选中结果
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (_dataArray.count) {
        self.selString = _dataArray[row];
        return;
    }
    
    if(component == 0){
        _provinceIndex = row;
        _cityIndex = 0;
        [self.pickerView reloadComponent:1];
    }
    else if (component == 1){
        _cityIndex = row;
    }
    [self.pickerView selectRow:_provinceIndex inComponent:0 animated:YES];
    [self.pickerView selectRow:_cityIndex inComponent:1 animated:YES];

    self.selString =[NSString stringWithFormat:@"%@ %@",self.provinceArr[_provinceIndex],self.cityArr[_provinceIndex][@"市县"][_cityIndex]];

}


// 列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    if (_dataArray.count) {
        return self.view.frame.size.width;
    }
    return self.view.frame.size.width/2;

    
}


// 行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 30;
}

-(void)removed{
    
    if (_backInfo) {
        _backInfo(self.selString);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 时间选择器

+(instancetype)pickerWithDataPicker{
    
    
    SWPickerViewCtrl * dd = [[SWPickerViewCtrl alloc]init];
    [dd createDataPicker];
    return dd;
    
}


-(void)createDataPicker{
    
    _selString = @"";
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //返回
    UIButton * BGBTN = [UIButton buttonWithType:(UIButtonTypeCustom)];
    BGBTN.frame = self.view.bounds;
    //    BGBTN.alpha = 0.35;
    BGBTN.backgroundColor =[UIColor clearColor];
    [BGBTN addTarget:self action:@selector(removedDate) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:BGBTN];
    
    
    UIView * whiteLine = [[UIView alloc]initWithFrame:(CGRectMake(0, DeviceHeight-185, DeviceWidth, 34))];
    whiteLine.backgroundColor  =[UIColor whiteColor];
    [self.view addSubview:whiteLine];
    
    
    whiteLine.layer.shadowColor = [UIColor grayColor].CGColor;
    whiteLine.layer.shadowOffset = CGSizeMake(0, -1);
    whiteLine.layer.shadowOpacity = 0.8;
    whiteLine.layer.shadowRadius = 1;
    
    
    
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(DeviceWidth-66, 0, 60, 35);
    [button setTitleColor:[UIColor colorWithHexString:@"007aff"] forState:(UIControlStateNormal)];
    [button setTitle:@"完成" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(removedDate) forControlEvents:(UIControlEventTouchUpInside)];
    [whiteLine addSubview:button];

    
    

    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, DeviceHeight-150, DeviceWidth , 150)];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    //UIDatePicker时间范围限制
    
//    NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:24*60*60*10];
//    _datePicker.maximumDate = maxDate;
//    NSDate *minDate = [NSDate date];
//    _datePicker.minimumDate = minDate;
    
    
//    [self.datePicker setDate:[NSDate date] animated:YES];//设置默认日期
    [self.view addSubview:self.datePicker];
    
    
}

-(void)removedDate{
    
    NSDate *date = self.datePicker.date;
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:date];
    if (dateStr) {
        self.selString = dateStr;
    }
    
    
    if (_backInfo) {
        _backInfo(self.selString);
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - ===============地区联动选择器===============

+(instancetype)pickerWithPlacePicker{
    
    SWPickerViewCtrl * pp = [[SWPickerViewCtrl alloc]init];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city_province.plist" ofType:nil];
    pp.placeDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    
    pp.provinceArr = [pp.placeDic[@"provinceArr"] firstObject][@"省份"];
    pp.cityArr = pp.placeDic[@"cityArr"];
    [pp createUIWithDataArray:nil];
    return pp;
    
}


@end
