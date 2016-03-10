//
//  ViewController.m
//  forISSArt
//
//  Created by Admin on 3/9/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"
#import "iResponsibleForTheData.h"

@interface ViewController ()


@property (nonatomic, weak) IBOutlet UITableView *myTableView;

@end

@implementation ViewController
{
    NSArray *dataForTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    iResponsibleForTheData *iWillDownload = [[iResponsibleForTheData alloc] init];
    [iWillDownload requestDataOnURL:[NSURL URLWithString:@"https://www.dropbox.com/s/a1lwxibpgccidoe/linksToDownload.txt?dl=1"]delegate:self];
}




-(void) resultReciver:(NSURL *) destinationPath
{
    NSString *str = [NSString stringWithContentsOfFile:[destinationPath path]
                                              encoding:NSUTF8StringEncoding
                                                 error: nil];
    dataForTableView = [str componentsSeparatedByString:@"\n"];
    if (str == nil)
        NSLog(@"Failed to open file");
    
    NSLog (@"Offset = %@", dataForTableView);
    
    [self.myTableView reloadData];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataForTableView count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableIdentifire = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifire];
    if(cell ==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifire];
    }
    cell.textLabel.text = [dataForTableView objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
