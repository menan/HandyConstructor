//
//  AddInvoiceViewController.m
//  HandyContructor
//
//  Created by Menan Vadivel on 2/15/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "AddInvoiceViewController.h"
#import "SecondViewController.h"
#import "FirstViewController.h"

@interface AddInvoiceViewController (){
    SecondViewController* view;
    FirstViewController *servicesView;
    int objectService;
    __weak IBOutlet UITextField *height;
    __weak IBOutlet UITextField *width;
    __weak IBOutlet UITextField *tax;
    __weak IBOutlet UITextField *sqft;
    
    NSMutableDictionary *service;
}
@property (weak, nonatomic) IBOutlet UILabel *lblService;

@end

@implementation AddInvoiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    service = [[NSMutableDictionary alloc] init];
    if ([[self dictionaryFromPlist] objectForKey:@"tax"])
        tax.text = [[self dictionaryFromPlist] objectForKey:@"tax"];
    
    if (objectService >= 0) {
        self.title = @"Edit Invoice";
        height.text = [[view.data objectAtIndex:objectService] objectForKey:@"length"];
        width.text = [[view.data objectAtIndex:objectService] objectForKey:@"width"];
        service = [[view.data objectAtIndex:objectService] objectForKey:@"service"];
        _lblService.text = [[[view.data objectAtIndex:objectService] objectForKey:@"service"] objectForKey:@"name"];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setSender:(SecondViewController *) sender andObject:(int) obj {
    view = sender;
    objectService = obj;
}


- (void) setService: (NSMutableDictionary *) s{
    service = s;
    _lblService.text = [service objectForKey:@"name"];
}

- (IBAction) clearText: (id) sender{
    height.text = @"";
    width.text = @"";
}

- (IBAction)calculateUnit:(id)sender{
    sqft.enabled = NO;
    if (![height.text isEqualToString:@""] || ![height.text isEqualToString:@""]) {
        sqft.text = [NSString stringWithFormat:@"%2.0f",[height.text floatValue] * [width.text floatValue]];
    }
}

- (IBAction)cancelTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (IBAction)saveTapped:(id)sender{
    NSLog(@"service: %@",[service objectForKey:@"name"]);
    if ([service objectForKey:@"name"] == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Saving" message:@"Please select a service." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }
    else{
        
        if (objectService >= 0) {
            [view.data removeObjectAtIndex:objectService];
        }
        NSMutableDictionary *content = [[NSMutableDictionary alloc] init];
        [content setObject:height.text forKey:@"length"];
        [content setObject:width.text forKey:@"width"];
        [content setObject:tax.text forKey:@"tax"];
        [content setObject:service forKey:@"service"];
        
        if ([height.text isEqualToString:@""] && [width.text isEqualToString:@""]) {
            [content setObject:sqft.text forKey:@"sqft"];
        }
        
        [self writeDictionaryToPlist:[[NSMutableDictionary alloc] initWithObjectsAndKeys:tax.text,@"tax", nil]];
        
        [view.data addObject:content];
        [view.table reloadData];
        [self dismissViewControllerAnimated:YES completion:Nil];
    }
}

- (NSMutableDictionary*)dictionaryFromPlist {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    NSMutableDictionary* propertyListValues = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    return propertyListValues;
}

- (BOOL)writeDictionaryToPlist:(NSMutableDictionary*)plistDict{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    BOOL result = [plistDict writeToFile:path atomically:YES];
    return result;
}
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray addObject:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:1]];
    
//    [mainArray insertObject:@"new row" atIndex:indexPath.row+1];
    
//    [[self tableView] beginUpdates];
//    [[self tableView] insertRowsAtIndexPaths:(NSArray *)tempArray withRowAnimation:UITableViewRowAnimationFade];
//    [[self tableView] endUpdates];
//    
    [height resignFirstResponder];
    [width resignFirstResponder];
    [tax resignFirstResponder];
    [sqft resignFirstResponder];
}

@end
