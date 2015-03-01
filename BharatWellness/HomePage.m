//
//  HomePage.m
//  BharatWellness
//
//  Created by Bablu Joshi on 01/03/15.
//  Copyright (c) 2015 BabluJoshi. All rights reserved.
//

#import "HomePage.h"
#import "MEDynamicTransition.h"
#import "UIViewController+ECSlidingViewController.h"
#import "METransitions.h"


@interface HomePage ()
@property (nonatomic, strong) METransitions *transitions;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;
@end

@implementation HomePage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitions.dynamicTransition.slidingViewController = self.slidingViewController;
    dispatch_async(dispatch_get_main_queue(), ^{
        // change index path for different types ..
        // 0- default
        // 1- fold
        // 2- zoom
        // 3- uikit dynamics
        
        NSIndexPath *defaultIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        NSDictionary *transitionData = self.transitions.all[defaultIndexPath.row];
        id<ECSlidingViewControllerDelegate> transition = transitionData[@"transition"];
        if (transition == (id)[NSNull null]) {
            self.slidingViewController.delegate = nil;
        } else {
            self.slidingViewController.delegate = transition;
        }
        NSString *transitionName = transitionData[@"name"];
        if ([transitionName isEqualToString:METransitionNameDynamic]) {
            self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGestureCustom;
            self.slidingViewController.customAnchoredGestures = @[self.dynamicTransitionPanGesture];
            [self.navigationController.view removeGestureRecognizer:self.slidingViewController.panGesture];
            [self.navigationController.view addGestureRecognizer:self.dynamicTransitionPanGesture];
        } else {
            self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
            self.slidingViewController.customAnchoredGestures = @[];
            [self.navigationController.view removeGestureRecognizer:self.dynamicTransitionPanGesture];
            [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
        }

    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([(NSObject *)self.slidingViewController.delegate isKindOfClass:[MEDynamicTransition class]]) {
        MEDynamicTransition *dynamicTransition = (MEDynamicTransition *)self.slidingViewController.delegate;
        if (!self.dynamicTransitionPanGesture) {
            self.dynamicTransitionPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:dynamicTransition action:@selector(handlePanGesture:)];
        }
        
        [self.navigationController.view removeGestureRecognizer:self.slidingViewController.panGesture];
        [self.navigationController.view addGestureRecognizer:self.dynamicTransitionPanGesture];
    } else {
        [self.navigationController.view removeGestureRecognizer:self.dynamicTransitionPanGesture];
        [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    }
}



- (IBAction)MenuButtonAction:(UIBarButtonItem *)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
#pragma mark - Properties

- (METransitions *)transitions {
    if (_transitions) return _transitions;
    
    _transitions = [[METransitions alloc] init];
    
    return _transitions;
}

- (UIPanGestureRecognizer *)dynamicTransitionPanGesture {
    if (_dynamicTransitionPanGesture) return _dynamicTransitionPanGesture;
    
    _dynamicTransitionPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.transitions.dynamicTransition action:@selector(handlePanGesture:)];
    
    return _dynamicTransitionPanGesture;
}

@end
