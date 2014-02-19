//
//  SecondViewController.h
//  HandyContructor
//
//  Created by Menan Vadivel on 2/15/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (atomic,retain) NSMutableArray *data;
@property (weak) IBOutlet UITableView *table;

@end
