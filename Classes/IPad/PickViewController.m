
 //
 //  PickerViewController.m
 //  Wiz
 //
 //  Created by dong zhao on 11 11 25.
 //  Copyright 2011年 __MyCompanyName__. All rights reserved.
 //
 
 #import "PickViewController.h"
 #import "FoldersViewController.h"
 #import "NewNoteView.h"
 #import "UIView-TagExtensions.h"
#import "WizIndex.h"
#import "CommonString.h"
#import "WizGlobals.h"
#import "WizGlobalData.h"
#import "RecentDcoumentListView.h"
#import "SearchViewControllerIphone.h"
#import "TagsListTreeView.h"
#import "WizPhoneNotificationMessage.h"
#import "UserSttingsViewController.h"
//wiz-dzpqzb test
#import "FoldersViewControllerNew.h"
#import "TagsListTreeControllerNew.h"
#import "WizNotification.h"
//wiz-dzpqzb test
#import "WizTableViewController.h"

 #define NEWNOTEENTRY 101
 
@implementation PickerViewController
-(void) dealloc
{
    if ([WizGlobals WizDeviceVersion] < 5.0) {
        self.navigationController.delegate = nil;
    }
    [WizNotificationCenter removeObserver:self];
    [super dealloc];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
-(void) newNote
{
    NewNoteView* newNote= [[NewNoteView alloc]init];
    [newNote prepareForNewDocument];
    UINavigationController* controller = [[UINavigationController alloc] initWithRootViewController:newNote];
    [self.navigationController presentModalViewController:controller animated:YES];
    [newNote release];
    [controller release];
}
 
- (id)init
{
    self = [super init];
    if (self) {
        if ([WizGlobals WizDeviceVersion] < 5.0) {
            self.navigationController.delegate = self;
        }
        [WizNotificationCenter addObserverForIphoneSetupAccount:self selector:@selector(setupAccount)];
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated
{
     [[self.tabBarController.view viewWithTag:101]setHidden:NO];
     [super viewDidAppear:animated];
}
 
- (void)didReceiveMemoryWarning
{
         // Releases the view if it doesn't have a superview.
//         [super didReceiveMemoryWarning];
         
         // Release any cached data, images, etc that aren't in use.
}
 
 #pragma mark   View lifecycle
 
//- (void) selectedView:(NSNotification*)nc
//{
//    NSDictionary* userInfo = [nc userInfo];
//    NSNumber* index = [userInfo valueForKey:TypeOfMainPickerViewIndex];
//    [self setSelectedIndex:[index intValue]];
//}
- (void) popSelf
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void) setupAccount
{
    UserSttingsViewController* editAccountView = [[UserSttingsViewController alloc] initWithNibName:@"UserSttingsViewController" bundle:nil ];
    editAccountView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editAccountView animated:YES];
    [editAccountView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    RecentDcoumentListView* recent = [[RecentDcoumentListView alloc]init] ;
    UINavigationController* recentController = [[UINavigationController alloc]init];
    [recentController pushViewController:recent animated:NO];
    recentController.tabBarItem.image = [UIImage imageNamed:@"barItemRecent"];
    [recent release];
    
    FoldersViewControllerNew* folderView = [[FoldersViewControllerNew alloc] init];
    UINavigationController* folderController = [[UINavigationController alloc] init] ;
    [folderController  pushViewController:folderView animated:NO];
    folderView.title = WizStrFolders;
    folderController.tabBarItem.image = [UIImage imageNamed:@"barItemFolde"];
    [folderView release];

    TagsListTreeControllerNew* tagView = [[TagsListTreeControllerNew alloc] init];
    UINavigationController* tagController = [[UINavigationController alloc] init];
    tagView.title = WizStrTags;
    [tagController pushViewController:tagView animated:NO];
    tagController.tabBarItem.image = [UIImage imageNamed:@"barItemTag"];
    [tagView release];
    
    SearchViewControllerIphone *searchView = [[SearchViewControllerIphone alloc] init];
    UINavigationController* searchController = [[UINavigationController alloc]initWithRootViewController:searchView ];
    searchController.title = WizStrSearch;
    searchController.tabBarItem.image = [UIImage imageNamed:@"barItemSearch"];
    [searchView release];
    
    UIImageView* view = [[UIImageView alloc] init] ;
    UINavigationController* emptyController = [[UINavigationController alloc]init];
    emptyController.title = NSLocalizedString(@"New", nil);
    emptyController.tabBarItem.tag = 1000;
    emptyController.tabBarItem.image = [UIImage imageNamed:@"barItemNewNote"];
    [emptyController.view addSubview:view];
    [view release];
    self.viewControllers = [NSArray arrayWithObjects:recentController,folderController, emptyController, tagController ,searchController, nil];
    [recentController release];
    [folderController release];
    [emptyController release];
    [tagController release];
    [searchController release];
    [[self.tabBarController.view viewWithTag:101]setHidden:NO];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];

}
 
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
         // Return YES for supported orientations
         return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 
- (void) dismissModalViewControllerAnimated:(BOOL)animated
{
         [[self.tabBarController.view viewWithTag:101]setHidden:NO];
}

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(item.tag == 1000)
    {
        [self newNote];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewWillAppear:animated];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setSelectedIndex:0];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end

