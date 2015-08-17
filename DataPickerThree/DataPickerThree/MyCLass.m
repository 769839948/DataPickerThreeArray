//
//  MyCLass.m
//  PlistTest
//
//  Created by 钱 斌 on 12-8-10.
//  Copyright (c) 2012年 qianbin. All rights reserved.
//

#import "MyCLass.h"

@interface MyCLass ()

@end

@implementation MyCLass

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    //判断是否以创建文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        //此处可以自己写显示plist文件内容
        NSLog(@"文件已存在");
    }
    else
    {
        //如果没有plist文件就自动创建
        NSMutableDictionary *dictplist = [[NSMutableDictionary alloc ] init];
        NSMutableDictionary *dicttxt = [[NSMutableDictionary alloc ] init];
        [dictplist setObject:dicttxt forKey:@"门款"];
        //写入文件
        [dictplist writeToFile:plistPath atomically:YES];
    }
}

//写入数据到plist文件
+(NSMutableDictionary*)Modify:(NSString *)getvalue :(NSString *)key
{
    /*
     注意：此方法更新和写入是共用的
     */
    //获取路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"test.plist"];
    NSMutableDictionary *applist = [[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy];
    NSMutableDictionary *info = [applist objectForKey:@"门款"];
    NSString *name1 = [info objectForKey:key];
    name1 = getvalue;
    [info setValue:name1 forKey:key];
    [applist setValue:info forKey:@"门款"];
    //写入文件
    [applist writeToFile:path atomically:YES];
    
    NSLog(@"key = %@",key);
    NSLog(@"txt = %@",getvalue);

    return applist;
}

//删除一行数据
+(NSMutableDictionary*)Delete:(NSString *)key
{
    //获取路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"test.plist"];
    NSMutableDictionary *applist = [[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy];
    NSMutableDictionary *info = [applist objectForKey:@"门款"]; 
    [info removeObjectForKey:key];
    [applist setValue:info forKey:@"门款"];
    //写入文件
    [applist writeToFile:path atomically:YES];
  
    return applist;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
