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
@property (weak, nonatomic) IBOutlet UIView *contentView;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)viewDidLayoutSubviews {
    CGRect scrollViewBounds = self.scrollView.bounds;
    CGRect containerViewBounds = self.contentView.bounds;
    
    UIEdgeInsets scrollViewInsets = UIEdgeInsetsZero;
    scrollViewInsets.top = CGRectGetHeight(scrollViewBounds) / 2;
    scrollViewInsets.top -= CGRectGetHeight(containerViewBounds) / 2;
    
    scrollViewInsets.bottom = CGRectGetHeight(scrollViewBounds) / 2;
    scrollViewInsets.bottom -= CGRectGetHeight(scrollViewBounds) / 2;
    scrollViewInsets.bottom += 1;
    
    self.scrollView.contentInset = scrollViewInsets;
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

#pragma mark - Notifications

- (void)keyboardDidShow:(NSNotification *)notification {
    NSDictionary* info = notification.userInfo;
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [self.view convertRect:[[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:self.view.window];
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat topInset = self.scrollView.contentInset.top;
    
    // Find out if keyboard does not overlap the scroll view and if so set correct insets to have ability to still scroll in whole scroll view
    if (CGRectIntersectsRect(keyboardFrame, scrollViewFrame)) {
        CGRect intersection = CGRectIntersection(keyboardFrame, scrollViewFrame);
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(topInset, 0, intersection.size.height, 0.0);
        [UIView animateWithDuration:animationDuration animations:^{
            self.scrollView.contentInset = contentInsets;
            self.scrollView.scrollIndicatorInsets = contentInsets;
        }];
    }
}

- (void)keyboardDidHide:(NSNotification *)notification {
    NSDictionary* info = notification.userInfo;
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGFloat topInset = self.scrollView.contentInset.top;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(topInset, 0, 0, 0);
    [UIView animateWithDuration:animationDuration animations:^{
        self.scrollView.contentInset = insets;
        self.scrollView.scrollIndicatorInsets = insets;
    }];
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