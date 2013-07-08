//
//  ViewController.m
//  Cards
//
//  Created by Armin Kroll on 8/07/13.
//  Copyright (c) 2013 jTribe. All rights reserved.
//

#import "ViewController.h"
#import "AViewController.h"
#import "BViewController.h"
#import "CardLayout.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableDictionary *childrenDictionary;
@property BOOL showingAll;
@property (nonatomic,strong) CardLayout *layout;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  {
    AViewController *controller = [[AViewController alloc] initWithTitle:@"A"];
    [self addChildViewController:controller];
    controller.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:controller.view];
   }
  
  {
    AViewController *controller = [[AViewController alloc] initWithTitle:@"B"];
    [self addChildViewController:controller];
    controller.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:controller.view];
  }
  
  {
    AViewController *controller = [[AViewController alloc] initWithTitle:@"C"];
    [self addChildViewController:controller];
    controller.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:controller.view];
  }
  
  {
    BViewController *controller = [[BViewController alloc] init];
    [self addChildViewController:controller];
    controller.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:controller.view];
  }
  
  
  NSMutableArray *views = [NSMutableArray array];
  for (UIViewController *controller in self.childViewControllers) {
    [views addObject:controller.view];
  }
  self.layout = [[CardLayout alloc] initWithViews:views containerView:self.view];
  [self.layout layoutAllAnimated:NO];
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
