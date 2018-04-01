//
//  SignInRequestModel.m
//  Login-MVVM2
//
//  Created by Apple on 2018/4/1.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "SignInRequestModel.h"

@implementation SignInRequestModel
//使用raccommand,收到信号之后才会执行
-(instancetype)init {
    self = [super init];
    
    if(self) {
        
        _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            
            return [self signInWithUsername:@"Arthur" password:@"name"];
        }];
        
        
        // 监听命令执行过程，可以加上很多处理的业务逻辑
        [[_requestCommand.executing skip:1] subscribeNext:^(id x) { // 跳过第一步（没有执行这步）
            if ([x boolValue] == YES) {
                NSLog(@"--正在执行");
                // 显示蒙版
            }else { //执行完成
                NSLog(@"执行完成");
                // 取消蒙版
            }
        }];
    }
    
    return self;
}

-(RACSignal *)signInWithUsername:(NSString *)username password:(NSString *)password {
    
    //返回一个信号量
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:[NSString stringWithFormat:@"User %@, password %@, login!",username, password]];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
}
@end
