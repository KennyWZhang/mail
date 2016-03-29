//
//  LoginViewController.m
//  MailByInVision
//
//  Created by Michal Kalis on 28/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "LoginViewController.h"
#import "DemoUserService.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.scrollView addGestureRecognizer:recognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Actions

- (IBAction)login:(id)sender {
    [self login];
}

- (void)login {
    [DemoUserService saveUserWithEmail:self.emailTextField.text];
    [[NSNotificationCenter defaultCenter] postNotificationName:DidAuthoriseNotification object:nil];
}

- (void)hideKeyboard:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

#pragma mark - Notification

- (void)keyboardWillShowOrHide:(NSNotification *)notification {
    CGRect endValue = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat durationValue = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger curveValue = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect endRect = [self.view convertRect:endValue fromView:self.view.window];
    
    CGFloat keyboardOverlap = CGRectGetMaxY(self.view.frame) - CGRectGetMinY(endRect);
    
    self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top, self.scrollView.contentInset.left, keyboardOverlap, self.scrollView.contentInset.right);
    self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
    
    [UIView animateWithDuration:durationValue delay:0 options:curveValue animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField) {
        [self.emailTextField resignFirstResponder];
        [self login];
    }
    
    return YES;
}

@end