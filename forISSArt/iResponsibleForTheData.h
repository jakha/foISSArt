//
//  iResponsibleForTheData.h
//  forISSArt
//
//  Created by Admin on 3/9/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface iResponsibleForTheData : NSURLSessionDownloadTask

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSURL * destinationPath;
@property (nonatomic) NSInteger progress;

-(void) requestDataOnURL:(NSURL *) URL delegate:(UIViewController *) controller;

@end
