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

// here for debugging purpouses
- (void)updateViewConstraints {
  [super updateViewConstraints];
}

// here for debugging purpouses
- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
}

// here for debugging purpouses
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

- (void) loadView
{
  self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  // make sure we are using our own layout mechanism and now autolayout of subviews.
  // This is important. Strange layout effects will happen if we use autolayout for the card views.
  // If a card controller was created in IB then the size set in there should be the size we use here as the cards shows.
  self.view.autoresizesSubviews = NO;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  for (UIViewController *controller in self.cardControllers)
  {
    [controller willMoveToParentViewController:self];
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
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
