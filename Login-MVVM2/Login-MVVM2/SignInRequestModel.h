//
//  SignInRequestModel.h
//  Login-MVVM2
//
//  Created by Apple on 2018/4/1.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

//使用RACCommand封装网络请求
@interface SignInRequestModel : NSObject
@property(nonatomic, strong, readonly)RACCommand *requestCommand;

@end
