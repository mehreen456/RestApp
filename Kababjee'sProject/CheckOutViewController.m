//
//  CheckOutViewController.m
//  Kababjee'sApp
//
//  Created by Amerald on 19/07/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "CheckOutViewController.h"

@interface CheckOutViewController ()
{
    int key;
    NSData *kj;
    NSString *name,*address,*time,*num;
    NSNumber *contact;
    NSDictionary *jsonDictionary;
    CGRect oldFrame ;
    CGSize kbSize;
    CGPoint kbposi;
}

@end

@implementation CheckOutViewController
@synthesize customview;
@synthesize NameField = _NameField;
@synthesize ContactField = _ContactField;
@synthesize AddressField = _AddressField;

- (void)viewDidLoad
{
    key=1;
    [super viewDidLoad];
    oldFrame.origin.y= self.view.frame.origin.y;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

    _NameField.delegate = self;
    _ContactField.delegate=self;
    _AddressField.delegate=self;
}

#pragma mark - My Methods

-(void) PostData
{
    NSURL *URL = [NSURL URLWithString:@"http://178.62.30.18:3002/api/v1/orders"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"d6e8a59c-9518-4998-a12a-9c97e50cebcb" forHTTPHeaderField:@"Authorization"];
    
    jsonDictionary =@{@"name": name,
                      @"phone":num,
                      @"address":address,
                      @"order_total":TPrice,
                      @"order_time": time,
                      @"device_os": @2,
                      @"order_detail": ItemsOrder
                      };

    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                       options:NSJSONWritingPrettyPrinted error:&error];
   
    [request setHTTPBody:jsonData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (error) {
                                          NSLog(@"Error ... ");
                                          return;
                                      }
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                      }
                                      
                                      NSString* body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      NSLog(@"Response Body:\n%@\n", body);
                                  }];
    [task resume];
    
  
}
-(NSString *) time
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    return [dateFormatter stringFromDate:now];
    

}

- (IBAction)ProceedButton:(id)sender {
   
    name=self.NameField.text;
    num=self.ContactField.text;
    address=self.AddressField.text;
    time=[self time];
    
    [self PostData];
          
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.NameField)
            [self.ContactField becomeFirstResponder];
  
    else if (textField == self.ContactField)
           [self.AddressField becomeFirstResponder];
    
 
    else
    {
      [textField resignFirstResponder];
    }

    return YES;
}

- (void)keyboardWillShow:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect newFrame = [self.view frame];
         newFrame.origin.y -= 30;
         [self.view setFrame:newFrame];
     
     }completion:^(BOOL finished)
     {
         
     }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect newFrame = [self.view frame];
         newFrame.origin.y = oldFrame.origin.y;
         [self.view setFrame:newFrame];
         
     }completion:^(BOOL finished)
     {
         
     }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

