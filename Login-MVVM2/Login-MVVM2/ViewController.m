//
//  ViewController.m
//  Login-MVVM
//
//  Created by Apple on 2018/4/1.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "ViewController.h"
#import "SignInViewModel.h"

//login  rac + mvvm -- 使用RACCommand 封装网络请求
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextEdit;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextEdit;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (strong, nonatomic) SignInViewModel *signInViewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signInViewModel = [SignInViewModel new];
      //bingdata
    RAC(self.signInViewModel,userName) = self.userNameTextEdit.rac_textSignal;
    RAC(self.signInViewModel,password) = self.pwdTextEdit.rac_textSignal;

    // 也可以双向绑定
//    RAC(self,statusLabel) = RACObserve(self.loginViewModel, statusMsg);

    //
    self.signInButton.rac_command = self.signInViewModel.loginCommand;
//    注意: 当button的rac_command已经绑定了某个command，而这个command又是以第二种方式初始化，那么你就不能动态改变button的enable，如:
    //    RAC(self.button, enable) = someSignal;

    //订阅信号，执行相关操作，executionSignals
    @weakify(self)
    [[self.signInViewModel.loginCommand executionSignals] subscribeNext:^(RACSignal *x) {
        @strongify(self)
        //x 是一个 RACSignal
        self.activityView.hidden = NO;
        
        [x subscribeNext:^(id  _Nullable x) {
            
            self.activityView.hidden = YES;
            
            NSLog(@"%@",x);
        }];
        
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
