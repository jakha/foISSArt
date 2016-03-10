//
//  AppDelegate.h
//  forISSArt
//
//  Created by Admin on 3/9/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy, nonatomic) void (^backgroundSessionCompletionHandler)();

@end

