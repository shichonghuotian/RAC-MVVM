//
//  SignInViewModel.h
//  Login-MVVM
//
//  Created by Apple on 2018/4/1.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDummySignInService.h"

@interface SignInViewModel : NSObject
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *statusMsg;
@property (strong, nonatomic) WDummySignInService *service;
@property(nonatomic, strong) RACCommand *loginCommand;

@end
