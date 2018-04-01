//
//  WDummySignInService.h
//  RACLogin
//
//  Created by Apple on 2018/4/1.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef void (^WSignInResponse)(BOOL);

@interface WDummySignInService : NSObject
//简单的模拟一个网络请求
-(void)signInWithUsername:(NSString*)username password:(NSString*)password complete:(WSignInResponse)completeBlock;

@end
