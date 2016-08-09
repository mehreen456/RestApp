//
//  ItemDescriptionViewController.m
//  Kababjee'sApp
//
//  Created by Amerald on 10/07/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "ItemDescriptionViewController.h"

@interface ItemDescriptionViewController ()
{
    NSUInteger tp;
    NSInteger value;
}
@end

@implementation ItemDescriptionViewController
@synthesize ItemImage,ItemName,Name,ItemPrice,Price,imageUrl,Quantity,TotalPrice,ItemID,values;

- (void)viewDidLoad {
    
    value=1;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    tp=[Price integerValue];
    self.ItemName.text=Name;
    self.ItemPrice.text=[self.ItemPrice.text stringByAppendingString:Price];
    self.TotalPrice.text=self.ItemPrice.text;
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@" "];
    __weak UIImageView *weakimage = self.ItemImage;
    [self.ItemImage setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakimage.image=image;
                                   } failure:nil];
    
    
    [super viewDidLoad];
}


#pragma mark - My Methods

- (IBAction)AddToBasketButton:(UIButton *)sender {
    
    BOOL find=NO;
    BasketItems++;
    btp=tp+btp;
    TPrice=[NSString stringWithFormat:@"%02lu", (unsigned long)btp];
    for (int d=0; d<ItemsOrder.count; d++) {
        
        NSString * DishName=[[ItemsOrder objectAtIndex:d]valueForKey:@"item_name"];
        if ([DishName isEqualToString:Name]) {
        NSInteger oldq=[[[ItemsOrder objectAtIndex:d]valueForKey:@"quantity" ]integerValue];
            NSInteger newq=oldq + value;
            [[ItemsOrder objectAtIndex:d] setValue:[NSString stringWithFormat:@"%ld", (long)newq] forKey:@"quantity"];
            find=YES;
            break;
        }
        
    }
    if(!find)
    {
           NSMutableDictionary *order=[NSMutableDictionary dictionaryWithObjectsAndKeys:Name,@"item_name",Price, @"item_price",self.Quantity.text,@"quantity",ItemID,@"menu_id", @"d6e8a59c-9518-4998-a12a-9c97e50cebcb ",@"uuid",  nil];
        [ItemsOrder addObject:order];
    }
 

      }

- (IBAction)DecButton:(id)sender {
   
    value++;
    [self valueChanged];
}

- (IBAction)IncButton:(id)sender {
    
    if(value>1)
    {
    value--;
    [self valueChanged];
    }
}

-(void)valueChanged
{
    self.Quantity.text = [NSString stringWithFormat:@"%02lu", (unsigned long)value];
    tp= [Price integerValue];
    tp= tp *value;
    self.TotalPrice.text= [@"Rs " stringByAppendingString:[NSString stringWithFormat:@"%02lu", (unsigned long)tp]];
}
@end
