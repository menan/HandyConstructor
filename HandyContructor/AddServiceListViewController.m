//
//  AddServiceListViewController.m
//  HandyContructor
//
//  Created by Menan Vadivel on 2/15/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "AddServiceListViewController.h"
#import "FirstViewController.h"

@interface AddServiceListViewController (){
    FirstViewController* view;
    int objectService;
    __weak IBOutlet UITextField *serviceName;
    __weak IBOutlet UITextField *materialCost;
    __weak IBOutlet UITextField *labourCost;
    __weak IBOutlet UITextField *totalCost;
}

@end

@implementation AddServiceListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        objectService = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    if (objectService >= 0) {
        self.title = @"Edit Service";
        serviceName.text = [[view.data objectAtIndex:objectService] objectForKey:@"name"];
        materialCost.text = [[view.data objectAtIndex:objectService] objectForKey:@"costM"];
        labourCost.text = [[view.data objectAtIndex:objectService] objectForKey:@"costL"];
        totalCost.text = [[view.data objectAtIndex:objectService] objectForKey:@"costT"];
    }
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setSender:(FirstViewController *) sender andObject:(int) obj {
    view = sender;
    objectService = obj;
}

- (IBAction) clearText: (id) sender{
    materialCost.text = @"";
    labourCost.text = @"";
}

- (IBAction)calculateUnit:(id)sender{
    totalCost.enabled = NO;
    if (![materialCost.text isEqualToString:@""] || ![labourCost.text isEqualToString:@""]) {
        totalCost.text = [NSString stringWithFormat:@"%2.0f",[materialCost.text floatValue] + [labourCost.text floatValue]];
    }
}

- (IBAction)cancelTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}


- (IBAction)saveTapped:(id)sender{
    if (objectService >= 0) {
        [view.data removeObjectAtIndex:objectService];
    }
    NSMutableDictionary *content = [[NSMutableDictionary alloc] init];
    [content setObject:serviceName.text forKey:@"name"];
    [content setObject:materialCost.text forKey:@"costM"];
    [content setObject:labourCost.text forKey:@"costL"];
    [content setObject:totalCost.text forKey:@"costT"];
    [view.data addObject:content];
    BOOL written = [self writeDictionaryToPlist:view.data];
    NSLog(@"data saved: %@, %d", view.data ,written);
    [view.table reloadData];
    [self dismissViewControllerAnimated:YES completion:Nil];
}


- (NSMutableArray*)dictionaryFromPlist {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"service.plist"];
    
    NSMutableArray* propertyListValues = [[NSMutableArray alloc] initWithContentsOfFile:path];
    return propertyListValues;
}

- (BOOL)writeDictionaryToPlist:(NSMutableArray*)plistDict{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"service.plist"];
    BOOL result = [plistDict writeToFile:path atomically:YES];
    return result;
}

@end
