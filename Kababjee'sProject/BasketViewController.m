 //
//  BasketViewController.m
//  Kababjee'sApp
//
//  Created by Amerald on 15/07/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "BasketViewController.h"

@interface BasketViewController ()
{
   UIButton *addProject;
   int t,m,j;
   NSInteger Price,totalPrice;
   BOOL deleteIT;
    UILabel *label;
}

@end

@implementation BasketViewController

@synthesize OrderTable,Button,AmountLabel1,AmountLabel2,PriceView;

- (void)viewDidLoad {
    
    j=2, t=1, m=0;
    [super viewDidLoad];
    AmountLabel1.text=[@"Rs. " stringByAppendingString:TPrice];
    AmountLabel2.text=[@"Rs. " stringByAppendingString:TPrice];
    [self AddBorders];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ItemsOrder.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *cell =[tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
        cell=[tableView dequeueReusableCellWithIdentifier:@"myCell"];
    }
    
    cell.Quantity.text=[[ItemsOrder objectAtIndex:indexPath.row]valueForKey:@"quantity" ];
    cell.OrderLabel.text=[@" * " stringByAppendingString:[[ItemsOrder objectAtIndex:indexPath.row]valueForKey:@"item_name" ]];
    Price=[[[ItemsOrder objectAtIndex:indexPath.row]valueForKey:@"item_price" ]integerValue];
    NSInteger oldqun=[[[ItemsOrder objectAtIndex:indexPath.row]valueForKey:@"quantity" ]integerValue];
  
    totalPrice= Price*oldqun;
    cell.OrderPriceLabel.text=[NSString stringWithFormat:@"%ld", (long)totalPrice];
    cell.Quantity.delegate=self;
    
    if (j==1)
        [[cell.contentView viewWithTag:201] setHidden:NO];
    
    if(j==0)
        [[cell.contentView viewWithTag:201] setHidden:YES];
   
    if(j==2)
    {
        addProject = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        addProject.frame = CGRectMake(self.view.frame.size.width-20, cell.OrderPriceLabel.frame.origin.y+5, 15, cell.OrderPriceLabel.frame.size.height-10);
            addProject.backgroundColor=[UIColor clearColor];
        UIImage * buttonImage = [UIImage imageNamed:@"Delete.png"];
        [addProject setBackgroundImage:buttonImage forState:UIControlStateNormal];
            [addProject addTarget:self action:@selector(OrderRemove:) forControlEvents:UIControlEventTouchUpInside];
        addProject.tag=201;
        [cell.contentView addSubview:addProject];
        [[cell.contentView viewWithTag:201] setHidden:YES];
        
      }
  
    return cell;
}


#pragma mark - UITextFieldDelegate

 - (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGPoint origin = textField.frame.origin;
    CGPoint point = [textField.superview convertPoint:origin toView:self.OrderTable];
    NSIndexPath * indexPath = [self.OrderTable indexPathForRowAtPoint:point];
    
        NSInteger newQ=[textField.text integerValue];
     
    [[ItemsOrder objectAtIndex:indexPath.row] setValue:[NSString stringWithFormat:@"%ld", (long)newQ] forKey:@"quantity"];
   
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
if(j==1)
{
    return YES;
}
else
    return NO;
}

#pragma mark - ViewButtons

- (IBAction)MyButton:(id)sender
{
    btp=0;
    if ([Button.titleLabel.text isEqualToString: @"APPLY CHANGES"])
    {
        j=0;
        [Button setTitle:@"EDIT" forState:UIControlStateNormal];
        [Button setTintColor:[UIColor blueColor]];
    }
    else
    {
         j=1;
        [Button setTitle:@"APPLY CHANGES" forState:UIControlStateNormal];
        [Button setTintColor:[UIColor redColor]];
    }
    
    [OrderTable reloadData];
    for(int k=0; k<ItemsOrder.count;k++)
    {
        NSInteger price =[[[ItemsOrder objectAtIndex:k]valueForKey:@"item_price" ]integerValue];
        NSInteger quantity =[[[ItemsOrder objectAtIndex:k]valueForKey:@"quantity" ]integerValue];
        NSInteger basketPrice= price*quantity;
        btp=btp + basketPrice;
        TPrice=[NSString stringWithFormat:@"%02lu", (unsigned long)btp];
    }
    if (ItemsOrder.count>0) {
       
    UIView* BLView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 50)];
    UIButton *basket=[[GlobalVariables class]BarButton];
    basket.frame = BLView.frame;
    [BLView addSubview:basket];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:BLView];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.rightBarButtonItem.enabled = NO;
        AmountLabel1.text=[@"Rs. " stringByAppendingString:TPrice];
        AmountLabel2.text=[@"Rs. " stringByAppendingString:TPrice];
 }
}

-(void)OrderRemove:(UIButton *) sender
{
    if(j==1)
    {   
        UITableViewCell *mycell= (UITableViewCell *)[[sender superview] superview];
        NSIndexPath *ind= [self.OrderTable indexPathForCell:mycell];
        [ItemsOrder removeObjectAtIndex:ind.row];
        [self.navigationController.view makeToast:@"Item Deleted"];
        NSInteger diff=[TPrice integerValue]-totalPrice;
        TPrice=[NSString stringWithFormat:@"%02lu", (unsigned long)diff];
        if(ItemsOrder.count==0)
        {
        TPrice=@"0";
        BasketItems=0;
        self.navigationItem.rightBarButtonItem=nil;
        }
       
        [OrderTable reloadData];
    }
}

- (IBAction)CheckOutButton:(id)sender {
    if(ItemsOrder.count==0)
        [self performSegueWithIdentifier:@"GoToMain" sender:self];
   }

-(void)AddBorders
{
    UIView *topBorder = [UIView new];
    topBorder.backgroundColor = [UIColor lightGrayColor];
    topBorder.frame = CGRectMake(0, 0,self.view.frame.size.width, 2);
    [PriceView addSubview:topBorder];
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [UIColor lightGrayColor];
    bottomBorder.frame = CGRectMake(0, self.PriceView.frame.size.height - 2, self.view.frame.size.width,2);
    [PriceView addSubview:bottomBorder];

}

#pragma mark - SegueMethod

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"GoToMain"])
           return YES;
    
    else if ([identifier isEqualToString:@"GoToProceed"])
    { if(ItemsOrder.count>0)
       return YES;
        return NO;
     }
    else if ([identifier isEqualToString:@"EToMain"])
    {if(ItemsOrder.count==0)
        return YES;
        return NO;    }
    else
  
        return NO;
}

@end
