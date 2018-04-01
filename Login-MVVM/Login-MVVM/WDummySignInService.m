//
//  WDummySignInService.m
//  RACLogin
//
//  Created by Apple on 2018/4/1.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "WDummySignInService.h"

@implementation WDummySignInService

-(void)signInWithUsername:(NSString*)username password:(NSString*)password complete:(WSignInResponse)completeBlock {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(completeBlock) {
            completeBlock(YES);
        }
        
        
    });
    
   
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
