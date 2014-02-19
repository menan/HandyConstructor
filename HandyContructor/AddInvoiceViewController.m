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
    
    NSMutableArray *objects;
    
    NSMutableArray *tableData;
    int sections;
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
    tableData = [[NSMutableArray alloc] init];
    
    
    
    if ([[self dictionaryFromPlist] objectForKey:@"tax"])
        tax.text = [[self dictionaryFromPlist] objectForKey:@"tax"];
    sections = 4;
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
    
    
    sections++;
    
    NSIndexPath *path1 = [NSIndexPath indexPathForRow:0 inSection:3]; //ALSO TRIED WITH indexPathRow:0
    NSIndexPath *path2 = [NSIndexPath indexPathForRow:1 inSection:3]; //ALSO TRIED WITH indexPathRow:0
    NSIndexPath *path3 = [NSIndexPath indexPathForRow:2 inSection:3]; //ALSO TRIED WITH indexPathRow:0
    NSArray *indexArray = [NSArray arrayWithObjects:path1,path2,path3,nil];
    
    [[self tableView] beginUpdates];
    [[self tableView] insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
    [[self tableView] endUpdates];

    [height resignFirstResponder];
    [width resignFirstResponder];
    [tax resignFirstResponder];
    [sqft resignFirstResponder];
}




#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"section: %d",section);
    if (section < 2 || section == sections - 1) {
        return 1;
    }
    else{
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TaxCell"];
    }
    else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceCell"];
    }
    else if (indexPath.section >= 2 && indexPath.section < sections){
        
        switch (indexPath.row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:@"WidthCell"];
                break;
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:@"LengthCell"];
                break;
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:@"SQFTCell"];
                break;
                
            default:
                break;
        }
        
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddNewCell"];
    }
    
    return cell;
}

@end
