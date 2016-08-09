
//  CategoriesViewController.m
//  ResturantApp
//
//  Created by Amerald on 01/07/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "CategoriesViewController.h"


@implementation CategoriesViewController

@synthesize CategoriesArray,myTable,HeaderView,Json;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.HeaderView.frame = CGRectMake(0,0,self.myTable.frame.size.width,self.view.frame.size.height/3);
     ItemsOrder =[[NSMutableArray alloc]init];
    [self retriveData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return myTable.frame.size.height/13;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return CategoriesArray.count;
   }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CCELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Categories *currentCat=[CategoriesArray objectAtIndex:indexPath.row];
    cell.textLabel.text=currentCat.CName ;
    cell.backgroundColor=[UIColor whiteColor];
   
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Categories *c1= [CategoriesArray objectAtIndex:indexPath.row];
    CID=c1.CId; 
    CTitle=c1.CName;
 }

#pragma mark - My Methods

-(void) retriveData
{
   NSString *string = @"http://178.62.30.18:3002/api/v1/categories";
    NSURL *url = [NSURL URLWithString:string];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"d6e8a59c-9518-4998-a12a-9c97e50cebcb" forHTTPHeaderField:@"Authorization"];
   
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        Json = (NSMutableArray *)responseObject;
        CategoriesArray =[[NSMutableArray alloc]init];
        
        for(int i=0;i<Json.count;i++)
        {
            NSString *CName = [[Json objectAtIndex:i]valueForKey:@"name"];
            NSString *CId = [[[Json objectAtIndex:i]valueForKey:@"id"]stringValue] ;
            Categories *Cobj=[[Categories alloc] initWithCId:CId andCName:CName];
            
            [CategoriesArray addObject:Cobj];
        }
     
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Data retrived faild");    }];
 
     [self.myTable reloadData];
}

#pragma mark - Passing Data Through Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
                       [navController setViewControllers: @[dvc] animated: NO ];
                       [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
      };
      
    }
}

@end
