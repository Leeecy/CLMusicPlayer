//
//  TabBarController.m
//  CLMusicPlayer
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 sunsmart. All rights reserved.
//

#import "TabBarController.h"
#import "MusicsViewController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    MusicsViewController *music = [[MusicsViewController alloc] init];
    UINavigationController *navgation = [[UINavigationController alloc] initWithRootViewController:music];
    self.viewControllers = @[navgation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
