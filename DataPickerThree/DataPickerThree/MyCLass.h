//
//  MyCLass.h
//  PlistTest
//
//  Created by 钱 斌 on 12-8-10.
//  Copyright (c) 2012年 qianbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCLass : UIViewController
+(NSMutableDictionary*)Modify:(NSString*)getvalue:(NSString*)key;
+(NSMutableDictionary*)Delete:(NSString*)key;

@end
