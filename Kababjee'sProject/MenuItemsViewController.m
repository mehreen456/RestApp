//
//  MenuItemsViewController.m
//  ResturantApp
//
//  Created by Amerald on 01/07/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "MenuItemsViewController.h"


@interface MenuItemsViewController ()
@end

@implementation MenuItemsViewController
{
    CGFloat Dlwidth,NLwidth;
    int Dlines;
    UIBarButtonItem* rightBarButton;
    UIBarButtonItem *menu;
}
@synthesize JsonRes,MenuArray,menuTable,CImage;

- (void)viewDidLoad {
    
    [self show];
    [super viewDidLoad];
    [DejalActivityView activityViewForView:self.view withLabel:@"Loading ..." width:self.view.frame.size.width-self.view.frame.size.width/2];
    [self retriveData];
  
    }

#pragma mark - UITableDelegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        [tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MenuArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
        return NLwidth+(Dlwidth*Dlines)+5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
      return 10.;
    
    else
      return 20.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
   [self performSegueWithIdentifier:@"MSegue" sender:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MyTableCell";
    
    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
    MenuItems *currentCat=[MenuArray objectAtIndex:indexPath.section];
   
       NSURL *url = [NSURL URLWithString:currentCat.MImg];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@" "];
    __weak MyTableViewCell *weakCell = cell;
    
    [cell.thumbnailImageView setImageWithURLRequest:request
                                   placeholderImage:placeholderImage
                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                weakCell.thumbnailImageView.image=image;
                                                } failure:nil];
  
    cell.backgroundColor = [UIColor colorWithRed:1. green:1. blue:1. alpha:0.5];
    cell.nameLabel.text =currentCat.MIname ;
    cell.descriptionLabel.text = currentCat.MIdescrp;
    cell.priceLabel.text= [@"Rs " stringByAppendingString:currentCat.MIprice];
    NLwidth=cell.nameLabel.frame.size.height;
    Dlwidth=cell.descriptionLabel.frame.size.height;
    Dlines=cell.descriptionLabel.text.length/Dlwidth+1;
    return cell;
}

#pragma mark - My Methods

-(void)retriveData
{
    NSString *string = @"http://178.62.30.18:3002/api/v1/menus";
    NSURL *url = [NSURL URLWithString:string];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"d6e8a59c-9518-4998-a12a-9c97e50cebcb" forHTTPHeaderField:@"Authorization"];
    
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        JsonRes = (NSMutableArray *)responseObject;
        
        MenuArray =[[NSMutableArray alloc]init];
        for(int i=350;i<JsonRes.count-50;i++)
        {
            NSString *MId = [[[JsonRes objectAtIndex:i]valueForKey:@"category_id"]stringValue];
            
           if([MId isEqualToString:CID])
          {
            NSString *MIname = [[JsonRes objectAtIndex:i]valueForKey:@"name"];
            
            NSString *MIdescrp = [[JsonRes objectAtIndex:i]valueForKey:@"description"];
            
            NSString *MIprice = [[[JsonRes  objectAtIndex:i]valueForKey:@"price"]stringValue];
            NSString *ImageUrl= [[[[JsonRes objectAtIndex:i]valueForKey:@"images"]objectAtIndex:0]valueForKey:@"url"];
              
            MenuItems *MCobj= [[MenuItems alloc] initWithMIprice:MIprice andMIname:MIname andMIdescrp:MIdescrp andImageUrl:ImageUrl andMId:(NSString *) MId];
            [MenuArray addObject:MCobj];
              
            }
        }
        
        [self.menuTable reloadData];
        [DejalActivityView removeView];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
       NSLog(@" Menu Data retrived faild");    }];
   
}

-(void) basket
{
    [self performSegueWithIdentifier:@"BSegue" sender:self.view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
       
            [navController setViewControllers: @[dvc] animated: NO ];
            dvc.navigationItem.leftBarButtonItem=menu;
            dvc.navigationItem.rightBarButtonItem=rightBarButton;
            dvc.navigationItem.title=@"Checkout";
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated:YES];
            
        };
    }

    else
    {
            NSIndexPath *indexPath = [self.menuTable indexPathForSelectedRow];
            ItemDescriptionViewController *destViewController = segue.destinationViewController;
            MenuItems *m1= [MenuArray objectAtIndex:indexPath.section];
            destViewController.Name = m1.MIname;
            destViewController.Price=m1.MIprice;
            destViewController.imageUrl=m1.MImg;
            destViewController.ItemID=m1.MId;
            destViewController.navigationItem.rightBarButtonItem=rightBarButton;
    }

}

-(void) show
{
    menu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon.png" ] style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = menu;
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    
    if(BasketItems>0)
    {
        UIView* BLView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 50)];
        UIButton *basket=[[GlobalVariables class]BarButton];
        basket.frame = BLView.frame;
        [basket addTarget:self action:@selector(basket) forControlEvents:UIControlEventTouchUpInside];
        [BLView addSubview:basket];
        
        rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:BLView];
        self.navigationItem.rightBarButtonItem = rightBarButton;
    }
      self.navigationItem.title=CTitle;
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BAckground"]];
    [tempImageView setFrame:self.menuTable.frame];
    
    self.menuTable.backgroundView = tempImageView;
 
}

@end
