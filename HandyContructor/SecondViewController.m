//
//  SecondViewController.m
//  HandyContructor
//
//  Created by Menan Vadivel on 2/15/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "SecondViewController.h"
#import "AddInvoiceViewController.h"

@interface SecondViewController (){
    
    BOOL editing;
    int selectedRow;
}

#define COST_M_LABEL_TAG 1
#define COST_L_LABEL_TAG 2
#define COST_TOTAL_LABEL_TAG 3
#define SERVICE_LABEL_TAG 4
#define MATERIAL_LABEL_TAG 5
#define LABOUR_LABEL_TAG 6
#define TOTAL_UNIT_LABEL_TAG 7
#define TOTAL_UNIT_NUM_LABEL_TAG 8
#define SUBTOTAL_LABEL_TAG 9
#define TAX_TAG 10
#define TAX_LABEL_TAG 11
#define TOTAL_LABEL_TAG 12

@end

@implementation SecondViewController

@synthesize data,table;
- (void)viewDidLoad
{
    data = [[NSMutableArray alloc] init];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    selectedRow = -1;
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleEditmode:(id)sender {
    UIBarButtonItem *item = sender;
    if ([item.title isEqualToString:@"Edit"]) {
        editing = YES;
        item.title = @"Done";
    }
    else{
        editing = NO;
        item.title = @"Edit";
    }
}


#pragma table view stuff

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"data: %@",data);
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editing) {
        selectedRow = indexPath.row;
        [self performSegueWithIdentifier:@"edit" sender:self];
    }
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedRow = -1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    UILabel *materialCost, *labourCost, *totalCost, *serviceName, *labour, *material, *lblTotalUnitNumber, *totalUnit, *lblSubtotalNumber, *lblSubtotal, *lblTax, *tax, *lblTotal, *totalNumber;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
        
        cell.contentView.frame = CGRectMake(cell.frame.origin.x, 0, table.frame.size.width, 180);

        serviceName = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 0.0, 200.0, 15.0)];
        serviceName.tag = SERVICE_LABEL_TAG;
        serviceName.font = [UIFont boldSystemFontOfSize:18.0];
        serviceName.textColor = [UIColor blackColor];
        serviceName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:serviceName];
        
        
        
        
        
        
        
        material = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 20.0, 120.0, 15.0)];
        material.tag = MATERIAL_LABEL_TAG;
        material.font = [UIFont systemFontOfSize:16.0];
        material.text = @"Material Cost";
        material.textColor = [UIColor blackColor];
        material.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:material];
        
        
        materialCost = [[UILabel alloc] initWithFrame:CGRectMake(210.0, 20.0, 100.0, 15.0)];
        materialCost.tag = COST_M_LABEL_TAG;
        materialCost.font = [UIFont systemFontOfSize:16.0];
        materialCost.textAlignment = NSTextAlignmentRight;
        materialCost.textColor = [UIColor blackColor];
        materialCost.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:materialCost];
        
        
        
        
        
        labour = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 40.0, 120.0, 15.0)];
        labour.tag = LABOUR_LABEL_TAG;
        labour.font = [UIFont systemFontOfSize:16.0];
        labour.text = @"Labour Cost";
        labour.textColor = [UIColor blackColor];
        labour.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:labour];
        
        
        
        labourCost = [[UILabel alloc] initWithFrame:CGRectMake(210.0, 40.0, 100.0, 15.0)];
        labourCost.tag = COST_L_LABEL_TAG;
        labourCost.font = [UIFont systemFontOfSize:16.0];
        labourCost.textAlignment = NSTextAlignmentRight;
        labourCost.textColor = [UIColor blackColor];
        labourCost.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:labourCost];
        
        
        
        
        
        
        
        
        
        
        UILabel* lblTotalUnit = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 65.0, 200.0, 15.0)];
        lblTotalUnit.font = [UIFont systemFontOfSize:16.0];
        lblTotalUnit.text = @"Total Unit Cost";
        lblTotalUnit.textColor = [UIColor blackColor];
        lblTotalUnit.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:lblTotalUnit];
        
        
        totalCost = [[UILabel alloc] initWithFrame:CGRectMake(210.0, 65.0, 100.0, 15.0)];
        totalCost.tag = COST_TOTAL_LABEL_TAG;
        totalCost.font = [UIFont boldSystemFontOfSize:16.0];
        totalCost.textAlignment = NSTextAlignmentRight;
        totalCost.textColor = [UIColor blackColor];
        totalCost.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:totalCost];
        
        
        
        
        
        lblTotalUnitNumber = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 90.0, 200.0, 15.0)];
        lblTotalUnitNumber.tag = TOTAL_UNIT_NUM_LABEL_TAG;
        lblTotalUnitNumber.font = [UIFont systemFontOfSize:16.0];
        lblTotalUnitNumber.textColor = [UIColor blackColor];
        lblTotalUnitNumber.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:lblTotalUnitNumber];
        
        totalUnit = [[UILabel alloc] initWithFrame:CGRectMake(210.0, 90.0, 100.0, 15.0)];
        totalUnit.tag = TOTAL_UNIT_LABEL_TAG;
        totalUnit.font = [UIFont systemFontOfSize:16.0];
        totalUnit.textAlignment = NSTextAlignmentRight;
        totalUnit.textColor = [UIColor blackColor];
        totalUnit.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:totalUnit];
        
        
        
        
        lblSubtotal = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 110.0, 120.0, 15.0)];
        lblSubtotal.font = [UIFont systemFontOfSize:16.0];
        lblSubtotal.text = @"Subtotal";
        lblSubtotal.textColor = [UIColor blackColor];
        lblSubtotal.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:lblSubtotal];
        
        
        lblSubtotalNumber = [[UILabel alloc] initWithFrame:CGRectMake(130.0, 110.0, 180.0, 15.0)];
        lblSubtotalNumber.tag = SUBTOTAL_LABEL_TAG;
        lblSubtotalNumber.font = [UIFont systemFontOfSize:16.0];
        lblSubtotalNumber.textAlignment = NSTextAlignmentRight;
        lblSubtotalNumber.textColor = [UIColor blackColor];
        lblSubtotalNumber.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:lblSubtotalNumber];
        
        
        
        
        
        
        lblTax = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 130.0, 120.0, 15.0)];
        lblTax.font = [UIFont systemFontOfSize:16.0];
        lblTax.tag = TAX_LABEL_TAG;
        lblTax.text = @"Tax";
        lblTax.textColor = [UIColor blackColor];
        lblTax.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:lblTax];
        
        
        tax = [[UILabel alloc] initWithFrame:CGRectMake(130.0, 130.0, 180.0, 15.0)];
        tax.tag = TAX_TAG;
        tax.font = [UIFont systemFontOfSize:16.0];
        tax.textAlignment = NSTextAlignmentRight;
        tax.textColor = [UIColor blackColor];
        tax.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:tax];
        
        
        
        
        
        lblTotal = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 155.0, 120.0, 15.0)];
        lblTotal.font = [UIFont boldSystemFontOfSize:16.0];
        lblTotal.text = @"Total";
        lblTotal.textColor = [UIColor blackColor];
        lblTotal.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:lblTotal];
        
        
        totalNumber = [[UILabel alloc] initWithFrame:CGRectMake(130.0, 155.0, 180.0, 15.0)];
        totalNumber.tag = TOTAL_LABEL_TAG;
        totalNumber.font = [UIFont boldSystemFontOfSize:16.0];
        totalNumber.textAlignment = NSTextAlignmentRight;
        totalNumber.textColor = [UIColor blackColor];
        totalNumber.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:totalNumber];
        
        NSLog(@"cell frame: %f", cell.contentView.frame.origin.y);
        
        
        
    } else {
        materialCost = (UILabel *)[cell.contentView viewWithTag:COST_M_LABEL_TAG];
        totalCost = (UILabel *)[cell.contentView viewWithTag:COST_M_LABEL_TAG];
        totalCost = (UILabel *)[cell.contentView viewWithTag:COST_TOTAL_LABEL_TAG];
        lblTotalUnitNumber = (UILabel *)[cell.contentView viewWithTag:TOTAL_UNIT_NUM_LABEL_TAG];
        totalUnit = (UILabel *)[cell.contentView viewWithTag:TOTAL_UNIT_LABEL_TAG];
        lblSubtotalNumber = (UILabel *)[cell.contentView viewWithTag:SUBTOTAL_LABEL_TAG];
        lblTax = (UILabel *)[cell.contentView viewWithTag:TAX_LABEL_TAG];
        tax = (UILabel *)[cell.contentView viewWithTag:TAX_TAG];
        totalNumber = (UILabel *)[cell.contentView viewWithTag:TOTAL_LABEL_TAG];
        
    }
    NSDictionary* obj = [data objectAtIndex:indexPath.row];
    
    NSNumber* costM = [NSNumber numberWithFloat:[[[obj objectForKey:@"service"] objectForKey:@"costM"] floatValue]];
    NSNumber* costL = [NSNumber numberWithFloat:[[[obj objectForKey:@"service"] objectForKey:@"costL"] floatValue]];
//    NSNumber* totalUnitCost = [NSNumber numberWithFloat:costM.floatValue + costL.floatValue];
    
    NSNumber* totalUnitCost;
    if ([[[obj objectForKey:@"service"] objectForKey:@"costT"] isEqualToString:@""] || [[obj objectForKey:@"service"] objectForKey:@"costT"] == nil) {
        totalUnitCost = [NSNumber numberWithFloat:costM.floatValue + costL.floatValue];
    }
    else{
        totalUnitCost = [NSNumber numberWithFloat:[[[obj objectForKey:@"service"] objectForKey:@"costT"] floatValue]];
    }
    
    
    NSString *taxSTR = [obj objectForKey:@"tax"];
    
    float taxAmount = 0,taxSubtotal = 0;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    float width = [[obj objectForKey:@"width"] floatValue];
    float length = [[obj objectForKey:@"length"] floatValue];
    float totalUnitFL = [[obj objectForKey:@"sqft"] floatValue];
    NSString *strSQFT = [NSString stringWithFormat:@"Total Unit (%@)",[obj objectForKey:@"sqft"]];
    if (totalUnitFL == 0) {
        totalUnitFL = length * width;
        strSQFT = [NSString stringWithFormat:@"Total Unit (%@ X %@)",[obj objectForKey:@"width"], [obj objectForKey:@"length"]];
    }
    float subtotal = totalUnitFL * totalUnitCost.floatValue;
    
    if ([taxSTR hasSuffix:@"%"]) {
        taxAmount = [[taxSTR substringToIndex:[taxSTR length] - 1] floatValue]/100;
         taxSubtotal = subtotal * taxAmount;
    }
    else{
        taxAmount = [taxSTR floatValue];
        taxSTR = [formatter stringFromNumber:[NSNumber numberWithFloat:taxAmount]];
        taxSubtotal = taxAmount;
    }
    
    float total = subtotal + taxSubtotal;
    
    NSNumber* subtotalNumber = [NSNumber numberWithFloat:subtotal];
    
    
    materialCost.text = [formatter stringFromNumber:costM];
    labourCost.text = [formatter stringFromNumber:costL];
    totalCost.text = [formatter stringFromNumber:totalUnitCost];
    serviceName.text = [[obj objectForKey:@"service"] objectForKey:@"name"];
    lblTotalUnitNumber.text = strSQFT;
    totalUnit.text = [NSString stringWithFormat:@"%2.0f",totalUnitFL];
    lblSubtotalNumber.text = [formatter stringFromNumber:subtotalNumber];
    lblTax.text = [NSString stringWithFormat:@"Tax (%@)",taxSTR];
    tax.text = [formatter stringFromNumber:[NSNumber numberWithFloat:taxSubtotal]];
    totalNumber.text = [formatter stringFromNumber:[NSNumber numberWithFloat:total]];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddInvoiceViewController *dvc = (AddInvoiceViewController *) [segue.destinationViewController topViewController];
    NSLog(@"selected row: %d",selectedRow);
    [dvc setSender:self andObject:selectedRow];
}



@end
