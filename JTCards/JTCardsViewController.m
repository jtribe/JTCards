//
//  CardsViewController.m
//  Cards
//
//  Created by Armin Kroll on 8/07/13.
//  Copyright (c) 2013 jTribe. All rights reserved.
//

#import "JTCardsViewController.h"
#import "JTCardsLayout.h"

@interface JTCardsViewController ()
@property BOOL showingAll;
@property (nonatomic,strong) NSMutableArray *cardControllers;
@property (nonatomic,strong) JTCardsLayout *layout;
@end

@implementation JTCardsViewController

- (id) initWithCards:(NSArray*)cardControllers layout:(JTCardsLayout*)layout
{
  self = [super init];
  if (self) {
    self.cardControllers =  [NSMutableArray arrayWithArray:cardControllers];
    self.layout = layout;
  }
  return self;
}

- (id) initWithCards:(NSArray*)cardControllers
{
  return [self initWithCards:cardControllers layout:nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  for (UIViewController *controller in self.cardControllers)
  {
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
  }
  
  NSMutableArray *views = [NSMutableArray array];
  for (UIViewController *controller in self.childViewControllers) {
    [views addObject:controller.view];
  }
  // create the default layout only if no layout was set during intialisation.
  if (!self.layout) {
    self.layout = [[JTCardsLayout alloc] initWithViews:views containerView:self.view];
  }
  else {
    // the layout was already set so just add the views and container view to it.
    self.layout.views = views;
    self.layout.containerView = self.view;
  }

}

- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.layout layoutAllAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
