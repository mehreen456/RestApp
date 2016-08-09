//
//  BasketViewController.h
//  Kababjee'sApp
//
//  Created by Amerald on 15/07/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"
#import "OrderCell.h"
#import "CheckOutViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"

@interface BasketViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIButton *Button;
@property (strong, nonatomic) IBOutlet UITableView *OrderTable;
@property (strong, nonatomic) IBOutlet UILabel *AmountLabel1;
@property (strong, nonatomic) IBOutlet UILabel *AmountLabel2;

- (IBAction)MyButton:(id)sender;
- (void)OrderRemove :(UIButton *) sender;

@property (strong, nonatomic) IBOutlet UIView *PriceView;
- (IBAction)CheckOutButton:(id)sender;

@end
