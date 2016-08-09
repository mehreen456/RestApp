//
//  CheckOutViewController.h
//  Kababjee'sApp
//
//  Created by Amerald on 19/07/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"

@interface CheckOutViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *NameField;
@property (strong, nonatomic) IBOutlet UITextField *ContactField;
@property (strong, nonatomic) IBOutlet UITextField *AddressField;
@property(strong,nonatomic) UIView *customview;
-(void) PostData;
-(NSString *) time;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
@property (strong, nonatomic) IBOutlet UIView *textview;

@end