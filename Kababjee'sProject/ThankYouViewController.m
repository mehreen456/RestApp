//
//  ThankYouViewController.m
//  Kababjee'sApp
//
//  Created by Amerald on 23/07/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "ThankYouViewController.h"

@interface ThankYouViewController ()

@end

@implementation ThankYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBarHidden=YES;
    [self performSelector:@selector(goToNextView) withObject:nil afterDelay:8];
    BasketItems=0;
    TPrice=0;
    
}

 - (void)goToNextView {
 [self performSegueWithIdentifier:@"GoToMain" sender:self];
 }
 
 


@end
