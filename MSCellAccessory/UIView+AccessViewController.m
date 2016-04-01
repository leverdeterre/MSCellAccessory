//
//  UIView+AccessViewController.m
//  MSCellAccessory
//
//  Created by SHIM MIN SEOK on 13. 7. 22..
//  Copyright (c) 2013 SHIM MIN SEOK. All rights reserved.
//

#import "UIView+AccessViewController.h"

@implementation UIResponder (AccessViewController)

- (UITableView *)ms_firstTableViewHierarchyFromView:(UIView *)view
{
    UIView *superView = view;
    while (superView.superview) {
        if ([superView.superview isKindOfClass:UITableView.class]) {
            return (UITableView *)superView.superview;
        }
        superView = superView.superview;
    }
    
    return nil;
}

- (UITableViewCell *)ms_firstTableViewCellInHierarchyFromView:(UIView *)view
{
    UIView *superView = view;
    while (superView.superview) {
        if ([superView.superview isKindOfClass:UITableViewCell.class]) {
            return (UITableViewCell *)superView.superview;
        }
        superView = superView.superview;
    }
    
    return nil;
}

- (UIViewController *)ms_firstAvailableViewController
{
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self ms_traverseResponderChainForViewControllerRespondingToSelector:NULL];
}

- (UIViewController *)ms_firstAvailableViewControllerRespondingToSelector:(SEL)selector
{
    return [self ms_traverseResponderChainForViewControllerRespondingToSelector:selector];
}

#pragma mark - Private

- (UIViewController *)ms_traverseResponderChainForViewControllerRespondingToSelector:(SEL)selector
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:UIViewController.class]) {
        UIViewController *viewController = (UIViewController *)nextResponder;
        if (NULL == selector) {
            return viewController;
            
        } else {
            if([viewController respondsToSelector:selector]){
                return viewController;
                
            } else if ([viewController.parentViewController respondsToSelector:selector]){
                return viewController.parentViewController;
            }
        }
    }
    
    return [nextResponder ms_traverseResponderChainForViewControllerRespondingToSelector:selector];
}

@end
