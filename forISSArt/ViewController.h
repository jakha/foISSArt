//
//  ViewController.h
//  forISSArt
//
//  Created by Admin on 3/9/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
//@property (nonatomic, strong) NSURL * destinationPath;

-(void) resultReciver:(NSURL *) destinationPath;


@end

