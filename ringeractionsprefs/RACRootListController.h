#import <Preferences/PSListController.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSSpecifier.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <CepheiPrefs/HBLinkTableCell.h>
#import <CepheiPrefs/HBTwitterCell.h>
#import <Cephei/HBPreferences.h>

#import <SparkAppListTableViewController.h>

@interface RACRootListController : PSListController
-(void)twitter;
-(void)discord;
-(void)paypal;
@end

