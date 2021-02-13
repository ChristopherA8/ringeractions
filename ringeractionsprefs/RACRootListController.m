#include "RACRootListController.h"

@implementation RACRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)twitter {
	NSURL *twitter = [NSURL URLWithString:@"https://twitter.com/chr1sdev"];
	[[UIApplication sharedApplication] openURL:twitter options:@{} completionHandler:nil];
}

-(void)discord {
	NSURL *discord = [NSURL URLWithString:@"https://discord.gg/zHN7yuGqYr"];
	[[UIApplication sharedApplication] openURL:discord options:@{} completionHandler:nil];
}

-(void)paypal {
	NSURL *paypal = [NSURL URLWithString:@"https://paypal.me/chr1sdev"];
	[[UIApplication sharedApplication] openURL:paypal options:@{} completionHandler:nil];
}


- (void)selectApps {
  SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.chr1s.ringeractionsprefs" andKey:@"apps"];

    [self.navigationController pushViewController:s animated:YES];
	  s.navigationItem.title = @"Select App";
    self.navigationItem.hidesBackButton = FALSE;

}



@end
