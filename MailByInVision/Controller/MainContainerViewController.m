//
//  MainContentViewController.m
//  MailByInVision
//
//  Created by Michal Kalis on 16/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MainContainerViewController.h"
#import "MenuViewController.h"
#import "MenuDataSource.h"
#import "ContentNavigationController.h"

@interface MainContainerViewController () <UIGestureRecognizerDelegate, MenuButtonDelegate, MenuViewControllerDelegate>

@property (nonatomic, strong) ContentNavigationController *contentNavigationController;
@property (nonatomic, strong) MenuViewController *menuViewController;
@property (nonatomic, assign) BOOL shouldShowMenu;
@property (nonatomic, assign) BOOL isMenuShown;
@property (nonatomic, assign) CGPoint preVelocity;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

@end

@implementation MainContainerViewController

// Constants
const CGFloat SlideDuration = .25;
const CGFloat MinimalContentWidth = 60;
const CGFloat SlidableWidth = 30;

#pragma mark - Default System Code

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - Setup View

- (void)setupView {
    ContentNavigationController *controller = [UIStoryboard storyboardWithName:@"Inbox" bundle:nil].instantiateInitialViewController;
    [self addContentNavigationController:controller];
    
    [self setupGestures];
}

- (void)addContentNavigationController:(ContentNavigationController *)controller {
    if (self.contentNavigationController != nil) {
        [self.contentNavigationController.view removeFromSuperview];
        [self.contentNavigationController removeFromParentViewController];
    }
    
    self.contentNavigationController = controller;
    
    self.contentNavigationController.menuButtonDelegate = self;
    [self.view addSubview:self.contentNavigationController.view];
    [self addChildViewController:self.contentNavigationController];
    [self.contentNavigationController didMoveToParentViewController:self];
}

- (UIView *)getMenuView {
    // Init menu view controller if it doesn't exist yet
    if (self.menuViewController == nil) {
        self.menuViewController = [UIStoryboard storyboardWithName:@"Menu" bundle:nil].instantiateInitialViewController;
        self.menuViewController.delegate = self;
        
        [self.view addSubview:self.menuViewController.view];
        [self addChildViewController:self.menuViewController];
        [self.menuViewController didMoveToParentViewController:self];
        
        self.menuViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    return self.menuViewController.view;
}

#pragma mark - Gesture Recognizers

- (void)setupGestures {
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveContent:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    panRecognizer.delegate = self;
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu:)];
    self.tapRecognizer.enabled = NO;
    
    [self.contentNavigationController.view addGestureRecognizer:panRecognizer];
    [self.contentNavigationController.view addGestureRecognizer:self.tapRecognizer];
}

- (void)moveContent:(UIPanGestureRecognizer *)recognizer {
    [recognizer.view.layer removeAllAnimations];
    
    CGPoint translatedPoint = [recognizer translationInView:self.view];
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    
    switch ([recognizer state]) {
        case UIGestureRecognizerStateBegan: {
            // Allow opening menu only from left side of the screen
            CGPoint point = [recognizer locationInView:self.view];
            if (!self.isMenuShown && point.x > SlidableWidth) {
                recognizer.enabled = NO;
                break;
            }
            
            UIView *childView = nil;
            
            if (velocity.x > 0) {
                childView = [self getMenuView];
            }
            
            // Bring the content view to front
            [self.view sendSubviewToBack:childView];
            [recognizer.view bringSubviewToFront:recognizer.view];
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            // When the pan is over half the width, set flag to finish the pan automatically if needed
            self.shouldShowMenu = fabs(recognizer.view.center.x - self.contentNavigationController.view.frame.size.width / 2) > self.contentNavigationController.view.frame.size.width / 2;
            
            // Allow dragging only in x coordinate and to the left
            recognizer.view.center = CGPointMake(MAX(recognizer.view.center.x + translatedPoint.x, CGRectGetWidth(self.view.frame) / 2), recognizer.view.center.y);
            [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
            
            // For checking change in direction
            if (velocity.x * self.preVelocity.x + velocity.y * self.preVelocity.y > 0) {
                // NSLog(@"same direction");
            }
            else {
                // NSLog(@"opposite direction");
            }
            
            self.preVelocity = velocity;
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            if (!self.shouldShowMenu) {
                [self hideMenu];
            }
            else {
                [self showMenu];
            }
            
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            recognizer.enabled = YES;
        }
            
        default:
            break;
    }
}

- (void)closeMenu:(id)sender {
    CGPoint point = [(UITapGestureRecognizer *)sender locationInView:self.view];
    
    if (point.x > CGRectGetWidth(self.view.frame) - MinimalContentWidth) {
        [self hideMenu];
    }
}

#pragma mark - Delegate Actions

- (void)showMenu {
    UIView *childView = [self getMenuView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:SlideDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.contentNavigationController.view.frame = CGRectMake(self.view.frame.size.width - MinimalContentWidth, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
                     completion:^(BOOL finished) {
                         if (finished) {
                             self.tapRecognizer.enabled = YES;
                             self.isMenuShown = YES;
                         }
                     }];
}

- (void)hideMenu {
    [UIView animateWithDuration:SlideDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.contentNavigationController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
                     completion:^(BOOL finished) {
                         if (finished) {
                             self.tapRecognizer.enabled = NO;
                             self.isMenuShown = NO;
                         }
                     }];
}

#pragma mark - Menu Button Delegate

- (void)toggleMenu {
    if (self.isMenuShown) {
        [self hideMenu];
    }
    else {
        [self showMenu];
    }
}

#pragma mark - Menu View Controller Delegate

- (void)didSelectMenuItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ContentNavigationController *controller = nil;
    
    switch (indexPath.section) {
        case MenuTableSectionMailboxes: {
            switch (indexPath.row) {
                case TableSectionMailboxesInbox:
                    controller = [UIStoryboard storyboardWithName:@"Inbox" bundle:nil].instantiateInitialViewController;
                    break;
                    
                default: {
                    // For demo purposes showing just a dummy controller
                    controller = [UIStoryboard storyboardWithName:@"Other" bundle:nil].instantiateInitialViewController;
                    break;
                }
            }
            break;
        }
            
        default: {
            // For demo purposes showing just a dummy controller
            controller = [UIStoryboard storyboardWithName:@"Other" bundle:nil].instantiateInitialViewController;
            break;
        }
    }
    
    controller.view.frame = CGRectMake(self.view.frame.size.width - MinimalContentWidth, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addContentNavigationController:controller];
    [self hideMenu];
}

@end
