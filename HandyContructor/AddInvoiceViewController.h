//
//  AddInvoiceViewController.h
//  HandyContructor
//
//  Created by Menan Vadivel on 2/15/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddInvoiceViewController : UITableViewController
- (void) setSender:(id) sender andObject:(int) obj;
- (void) setService: (NSMutableDictionary *) s;
@end
