//
//  LoginViewController.m
//  MailByInVision
//
//  Created by Michal Kalis on 28/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "LoginViewController.h"
#import "DemoUserService.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Login";
    
    
}

#pragma mark - Actions

- (IBAction)login:(id)sender {
    [DemoUserService saveUserWithEmail:self.emailTextField.text];
    [[NSNotificationCenter defaultCenter] postNotificationName:DidAuthoriseNotification object:nil];
}

@end