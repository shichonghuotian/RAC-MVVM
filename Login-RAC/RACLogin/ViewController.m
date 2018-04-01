//
//  ViewController.m
//  RACLogin
//
//  Created by Apple on 2018/4/1.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "ViewController.h"
#import "WDummySignInService.h"
//使用rac实现登录
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextEdit;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextEdit;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (strong, nonatomic) WDummySignInService *service;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _service = [[WDummySignInService alloc] init];
    //  使用  @weakify(self) @strongify(self)，解决循环引用
    @weakify(self)
    RACSignal *validUserNameSignal = [self.userNameTextEdit.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self)
        
        return @([self isValidUsername:value]);
    }];
    
    RACSignal *validPwdSignal = [self.pwdTextEdit.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self)
        
        return @([self isValidPassword:value]);
    }];
    
    //根据返回值，设置背景颜色
    RAC(self.userNameTextEdit,backgroundColor) = [validUserNameSignal map:^id _Nullable(id  _Nullable value) {
        
        if([value boolValue] ) {
            return [UIColor yellowColor];
        }else {
            return [UIColor whiteColor];
        }
    }];
    RAC(self.pwdTextEdit,backgroundColor) = [validPwdSignal map:^id _Nullable(id  _Nullable value) {
        
        if([value boolValue] ) {
            return [UIColor yellowColor];
        }else {
            return [UIColor whiteColor];
        }
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validUserNameSignal,validPwdSignal] reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
        
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
    
    RAC(self.signInButton,backgroundColor) = [signUpActiveSignal map:^id _Nullable(id  _Nullable value) {
        if([value boolValue] ) {
            return [UIColor yellowColor];
        }else {
            return [UIColor blueColor];
        }
    }];
    
    
    //设置button点击
    RACSignal *signTouchSignal =[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    
    
    
    [[[signTouchSignal
       doNext:^(id x){
           //next 方法执行前会执行这个，可以设置一些状态
            @strongify(self)
           self.activityView.hidden = NO;
       }] flattenMap:^__kindof RACSignal * _Nullable(__kindof UIControl * _Nullable value) {
            @strongify(self)
          return [self signInSignal];
      }] subscribeNext:^(id  _Nullable x) {
           @strongify(self)
          NSLog(@"Sign in result: %@",x);
           self.activityView.hidden = YES;
          
      }] ;
}

-(RACSignal*)signInSignal {

    @weakify(self)
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        [self.service signInWithUsername:self.userNameTextEdit.text password:self.pwdTextEdit.text complete:^(BOOL success) {
            
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        
        return nil;
        
    }];
}
-(BOOL)isValidUsername:(NSString*)text {
    
    return text.length >3;
}

-(BOOL)isValidPassword:(NSString*)text {
    
    return text.length >3;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
