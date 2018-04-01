//
//  SignInViewModel.m
//  Login-MVVM
//
//  Created by Apple on 2018/4/1.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "SignInViewModel.h"

@implementation SignInViewModel
-(instancetype)init {
    self = [super init];
    
    if(self) {
        _reqeustModel = [SignInRequestModel new];
        @weakify(self)
        RACSignal *validUserNameSignal = [RACObserve(self, userName) map:^id (NSString* value) {
            @strongify(self)
            return @([self isValidUsername:value]);
        }];
        
        RACSignal *validPwdSignal = [RACObserve(self, password) map:^id(NSString*  value) {
             @strongify(self)
            return @([self isValidUsername:value]);
        }];
        
        RACSignal *loginBtnEnalbe = [RACSignal combineLatest:@[validUserNameSignal,validPwdSignal] reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
             
            return @([usernameValid boolValue] && [passwordValid boolValue]);
        }];
        //
     
        
        _loginCommand = [[RACCommand alloc] initWithEnabled:loginBtnEnalbe signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
             @strongify(self)
            //返回执行之后的信号。直接开始执行命令，逻辑更清晰一点
            return [self.reqeustModel.requestCommand execute:nil];
        }];
    }
    
    
    return self;
}

-(BOOL)isValidUsername:(NSString*)text {
    
    return text.length >3;
}

-(BOOL)isValidPassword:(NSString*)text {
    
    return text.length >3;
    
}
@end
