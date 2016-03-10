//
//  iResponsibleForTheData.m
//  forISSArt
//
//  Created by Admin on 3/9/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "iResponsibleForTheData.h"
#import "AppDelegate.h"


@implementation iResponsibleForTheData{
    ViewController *vC;
}

@synthesize downloadTask = _downloadTask;
@synthesize destinationPath = _destinationPath;

-(void) requestDataOnURL:(NSURL *) URL delegate: (UIViewController *) controller
{
    vC = controller;
    self.downloadTask = [[self backgroundSession] downloadTaskWithURL:URL];
    [self.downloadTask resume];
}

//функция создания сессии в фоне, выполняется единожды
- (NSURLSession *)backgroundSession{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.dev.BackgroundDownloadTest.BackgroundSession"];
        [config setAllowsCellularAccess:YES];
        session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    });
    return session;
}

- (void)callCompletionHandlerIfFinished
{
    NSLog(@"call completion handler");
    [[self backgroundSession] getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        NSUInteger count = [dataTasks count] + [uploadTasks count] + [downloadTasks count];
        if (count == 0) {
            NSLog(@"all tasks ended");
            AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
            if (appDel.backgroundSessionCompletionHandler == nil) return;
            
            void (^comletionHandler)() = appDel.backgroundSessionCompletionHandler;
            appDel.backgroundSessionCompletionHandler = nil;
            comletionHandler();
        }
    }];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"did finish downloading");
    NSURL *error;
    // We've successfully finished the download. Let's save the file
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *URLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = URLs[0];

    NSURL *destinationPath = [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
    
    [fileManager removeItemAtURL:destinationPath error:NULL];
    BOOL success = [fileManager copyItemAtURL:location toURL:destinationPath error:&error];
    
    if (success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [vC resultReciver: destinationPath];
        });
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error) {
        NSLog(@"error: %@ - %@", task, error);
    } else {
        NSLog(@"success: %@", task);
    }
    self.downloadTask = nil;
    [self callCompletionHandlerIfFinished];
}

@end
