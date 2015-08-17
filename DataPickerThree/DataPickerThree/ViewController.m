//
//  ViewController.m
//  DataPickerThree
//
//  Created by Jane on 8/15/15.
//  Copyright (c) 2015 Jane. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSDictionary *dict;//用于存储省份-城市的数据
    NSArray *provinceArray;//省份的数组
    NSArray *cityArray;//城市的数组，在接下来的代码中会有根据省份的选择进行数据更新的操作
    UIPickerView *pickerView;
    NSArray *pickerData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
//    //    指定Delegate
//    pickerView.delegate=self;
//    //    显示选中框
//    pickerView.showsSelectionIndicator=YES;
//    [self.view addSubview:pickerView];
//    
//    NSArray *dataArray = [[NSArray alloc]initWithObjects:@"许嵩",@"周杰伦",@"梁静茹",@"许飞",@"凤凰传奇",@"阿杜",@"方大同",@"林俊杰",@"胡夏",@"邱永传", nil];
//    
//    pickerData=dataArray;
    
    //     添加按钮
//    CGRect frame = CGRectMake(120, 250, 80, 40);
//    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    selectButton.frame=frame;
//    [selectButton setTitle:@"SELECT" forState:UIControlStateNormal];
//    
//    [selectButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.view addSubview:selectButton];
     [self initPicker];
    //[self.view addSubview:textField];
}


////返回显示的列数
//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
////返回当前列显示的行数
//-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return [pickerData count];
//}
//
//#pragma mark Picker Delegate Methods
//
////返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
//-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return [pickerData objectAtIndex:row];
//}

//初始化PickerView使用的数据源
-(void)initPicker{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    provinceArray = [data allKeys];
    
    NSInteger selectedProvinceIndex = [pickerView selectedRowInComponent:0];
    NSString *seletedProvince = [provinceArray objectAtIndex:selectedProvinceIndex];
    cityArray = [dict objectForKey:seletedProvince];
    
    NSLog(@"%lu",(unsigned long)[provinceArray count]);
}
//以下3个方法实现PickerView的数据初始化
//确定picker的轮子个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {//省份个数
        return [provinceArray count];
    } else {//市的个数
        return [cityArray count];
    }
}
//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {//选择省份名
        return [provinceArray objectAtIndex:row];
    } else {//选择市名
        return [cityArray objectAtIndex:row];
    }
}

//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSString *seletedProvince = [provinceArray objectAtIndex:row];
        cityArray = [dict objectForKey:seletedProvince];
        
        //重点！更新第二个轮子的数据
        [pickerView reloadComponent:1];
        
        NSInteger selectedCityIndex = [pickerView selectedRowInComponent:1];
        NSString *seletedCity = [cityArray objectAtIndex:selectedCityIndex];
        
        NSString *msg = [NSString stringWithFormat:@"province=%@,city=%@", seletedProvince,seletedCity];
        NSLog(@"%@",msg);
    }
    else {
        NSInteger selectedProvinceIndex = [pickerView selectedRowInComponent:0];
        NSString *seletedProvince = [provinceArray objectAtIndex:selectedProvinceIndex];
        
        NSString *seletedCity = [cityArray objectAtIndex:row];
        NSString *msg = [NSString stringWithFormat:@"province=%@,city=%@", seletedProvince,seletedCity];
        NSLog(@"%@",msg);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
