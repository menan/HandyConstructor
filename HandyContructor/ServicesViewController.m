//
//  ServicesViewController.m
//  HandyContructor
//
//  Created by Menan Vadivel on 2/15/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "ServicesViewController.h"
#import "AddInvoiceViewController.h"

@interface ServicesViewController (){
    NSMutableArray *data;
}

#define COST_M_LABEL_TAG 1
#define COST_L_LABEL_TAG 2
#define COST_TOTAL_LABEL_TAG 3
#define SERVICE_LABEL_TAG 4
#define MATERIAL_LABEL_TAG 5
#define LABOUR_LABEL_TAG 6
@end

@implementation ServicesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    data = [[NSMutableArray alloc] initWithArray:[self dictionaryFromPlist] copyItems:YES];
}


- (NSMutableArray*)dictionaryFromPlist {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"service.plist"];
    
    NSMutableArray* propertyListValues = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSLog(@"loaded strings were: %@",propertyListValues);
    return propertyListValues;
}

- (BOOL)writeDictionaryToPlist:(NSMutableArray*)plistDict{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"service.plist"];
    BOOL result = [plistDict writeToFile:path atomically:YES];
    return result;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    UILabel *materialCost, *labourCost, *totalCost, *serviceName, *labour, *material;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        
        
        totalCost = [[UILabel alloc] initWithFrame:CGRectMake(210.0, 0.0, 100.0, 15.0)];
        totalCost.tag = COST_TOTAL_LABEL_TAG;
        totalCost.font = [UIFont boldSystemFontOfSize:16.0];
        totalCost.textAlignment = NSTextAlignmentRight;
        totalCost.textColor = [UIColor blackColor];
        totalCost.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:totalCost];
        
        serviceName = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 0.0, 120.0, 15.0)];
        serviceName.tag = SERVICE_LABEL_TAG;
        serviceName.font = [UIFont boldSystemFontOfSize:16.0];
        serviceName.textColor = [UIColor blackColor];
        serviceName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:serviceName];
        
        materialCost = [[UILabel alloc] initWithFrame:CGRectMake(210.0, 20.0, 100.0, 15.0)];
        materialCost.tag = COST_M_LABEL_TAG;
        materialCost.font = [UIFont systemFontOfSize:14.0];
        materialCost.textAlignment = NSTextAlignmentRight;
        materialCost.textColor = [UIColor blackColor];
        materialCost.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:materialCost];
        
        material = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 20.0, 120.0, 15.0)];
        material.tag = MATERIAL_LABEL_TAG;
        material.font = [UIFont systemFontOfSize:14.0];
        material.text = @"Material Cost";
        material.textColor = [UIColor blackColor];
        material.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:material];
        
        labour = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 37.0, 120.0, 15.0)];
        labour.tag = LABOUR_LABEL_TAG;
        labour.font = [UIFont systemFontOfSize:14.0];
        labour.text = @"Labour Cost";
        labour.textColor = [UIColor blackColor];
        labour.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:labour];
        
        labourCost = [[UILabel alloc] initWithFrame:CGRectMake(210.0, 37.0, 100.0, 15.0)];
        labourCost.tag = COST_L_LABEL_TAG;
        labourCost.font = [UIFont systemFontOfSize:14.0];
        labourCost.textAlignment = NSTextAlignmentRight;
        labourCost.textColor = [UIColor blackColor];
        labourCost.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:labourCost];
        
    } else {
        materialCost = (UILabel *)[cell.contentView viewWithTag:COST_M_LABEL_TAG];
        labourCost = (UILabel *)[cell.contentView viewWithTag:COST_L_LABEL_TAG];
        totalCost = (UILabel *)[cell.contentView viewWithTag:COST_TOTAL_LABEL_TAG];
    }
    NSDictionary* obj = [data objectAtIndex:indexPath.row];
    
    NSNumber* costM = [NSNumber numberWithFloat:[[obj objectForKey:@"costM"] floatValue]];
    NSNumber* costL = [NSNumber numberWithFloat:[[obj objectForKey:@"costL"] floatValue]];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSNumber* total;
    if ([[obj objectForKey:@"costT"] isEqualToString:@""] || [obj objectForKey:@"costT"] == nil) {
        total = [NSNumber numberWithFloat:costM.floatValue + costL.floatValue];
    }
    else{
        total = [NSNumber numberWithFloat:[[obj objectForKey:@"costT"] floatValue]];
    }
    materialCost.text = [formatter stringFromNumber:costM];
    labourCost.text = [formatter stringFromNumber:costL];
    totalCost.text = [formatter stringFromNumber:total];
    serviceName.text = [obj objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddInvoiceViewController* view = [self.navigationController.viewControllers objectAtIndex:0];
    [view setService:[data objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

 

@end
