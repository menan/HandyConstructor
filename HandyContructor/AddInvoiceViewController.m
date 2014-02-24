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
    NSMutableArray *mutArray;
    NSMutableArray *mutArray2;
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
    mutArray = [[NSMutableArray alloc] init];
    mutArray2 = [[NSMutableArray alloc] init];
    
    
    
    sections = 4;
    
    
    [self.tableView reloadData];
    tax = [[[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] contentView] subviews] objectAtIndex:1];
    _lblService = [[[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]] contentView] subviews] objectAtIndex:1];
    if ([[self dictionaryFromPlist] objectForKey:@"tax"])
        tax.text = [[self dictionaryFromPlist] objectForKey:@"tax"];
    
    if (objectService >= 0) {
        
        sections += [[[view.data objectAtIndex:objectService] objectForKey:@"units"] count] - 1;
        [self.tableView reloadData];
        
        self.title = @"Edit Invoice";
        //        [self addUnitSection:[[[view.data objectAtIndex:objectService] objectForKey:@"units"] count] - 1 withAnimation:NO];
        
        service = [[view.data objectAtIndex:objectService] objectForKey:@"service"];
        _lblService.text = [[[view.data objectAtIndex:objectService] objectForKey:@"service"] objectForKey:@"name"];
        for (int i = 2;i < sections - 1; i++) {
            width = [[[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]] contentView] subviews] objectAtIndex:1];
            height = [[[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:i]] contentView] subviews] objectAtIndex:1];
            sqft = [[[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:i]] contentView] subviews] objectAtIndex:1];
            
            height.text = [[[[view.data objectAtIndex:objectService] objectForKey:@"units"] objectAtIndex:i - 2 ] objectForKey:@"length"];
            width.text = [[[[view.data objectAtIndex:objectService] objectForKey:@"units"] objectAtIndex:i - 2 ] objectForKey:@"width"];
            sqft.text = [[[[view.data objectAtIndex:objectService] objectForKey:@"units"] objectAtIndex:i - 2 ] objectForKey:@"sqft"];
            
            
        }
        
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
    UITextField *text = sender;
    
    width = (UITextField *)[self.tableView viewWithTag:6];
    height = (UITextField *)[self.tableView viewWithTag:5];
    sqft = (UITextField *)[self.tableView viewWithTag:7];
    
    
    NSLog(@"SuperView: %@ width:%@, length: %@, sqft: %@",text.superview.superview.superview, width.text,height.text,sqft.text);
    if (![height.text isEqualToString:@""] || ![width.text isEqualToString:@""]) {
        sqft.enabled = NO;
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
        
        
        NSMutableArray *arrayLength = [[NSMutableArray alloc] init];
        for (int i = 2;i < sections - 1; i++) {
            NSMutableDictionary *scales = [[NSMutableDictionary alloc] init];
            NSLog(@"sec: %d",i);
            if ([self getObjectAtIndex:0 andSection:i] && [self getObjectAtIndex:1 andSection:i] && [self getObjectAtIndex:2 andSection:i]) {
                width = [self getObjectAtIndex:0 andSection:i];
                height = [self getObjectAtIndex:1 andSection:i];
                sqft = [self getObjectAtIndex:2 andSection:i];
//                NSLog(@"section: %d, height: %@",i, height);
//                NSLog(@"subviews: %@",[[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]] contentView] subviews]);
                [scales setObject:height.text forKey:@"length"];
                [scales setObject:width.text forKey:@"width"];


                if ([height.text isEqualToString:@""] && [width.text isEqualToString:@""]) {
                    [scales setObject:sqft.text forKey:@"sqft"];
                }
                
                
                [arrayLength addObject:scales];
            }
        }
        
        [content setObject:arrayLength forKey:@"units"];
        [content setObject:tax.text forKey:@"tax"];
        [content setObject:service forKey:@"service"];
        
        NSLog(@"content:%@",content);
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
    if (indexPath.section == sections - 1) {
        [self addUnitSection:1 withAnimation:YES];
    }
    
    
}

- (void) addUnitSection:(int) times withAnimation:(BOOL) animate{
    for (int i = 0; i < times; i++) {
//        NSLog(@"sections: %d",sections);
        int sec = 2;
        if (sections < 6) {
            
            sections++;
            NSIndexPath *path1 = [NSIndexPath indexPathForRow:0 inSection:sec]; //ALSO TRIED WITH indexPathRow:0
            NSIndexPath *path2 = [NSIndexPath indexPathForRow:1 inSection:sec]; //ALSO TRIED WITH indexPathRow:0
            NSIndexPath *path3 = [NSIndexPath indexPathForRow:2 inSection:sec]; //ALSO TRIED WITH indexPathRow:0
            NSArray *indexArray = [NSArray arrayWithObjects:path1,path2,path3,nil];
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sec];
            
            if (animate) {
                [[self tableView] beginUpdates];
                [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                [[self tableView] insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
                [[self tableView] endUpdates];
            }
            else{
                [[self tableView] beginUpdates];
                [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                [[self tableView] insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
                [[self tableView] endUpdates];
            }
        }
    }
}




#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    else if (indexPath.section >= 2 && indexPath.section < sections-1){
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
                NSLog(@"default occcured tho %d",indexPath.row);
                break;
        }
        
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddNewCell"];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%d",[self indexPathToInt:indexPath]];
    
    
    
//
//    if(![mutArray containsObject:cell])
//        [mutArray addObject:cell];
    
//    if (![mutArray2 containsObject:mutArray])
//        [mutArray2 insertObject:mutArray atIndex:indexPath.section];
    
//    NSLog(@"array: %@",mutArray);
    return cell;
}


- (id) getObjectAtIndex:(int) index andSection:(int) sec
{
//    NSLog(@"obj: %@, i: %d, s = %d", [mutArray objectAtIndex:0], index,sec);
    return [[[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:sec]] contentView] subviews] objectAtIndex:1];
}


@end
