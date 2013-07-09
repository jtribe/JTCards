//
//  RootViewController.m
//  Cards
//
//  Created by Armin Kroll on 9/07/13.
//  Copyright (c) 2013 jTribe. All rights reserved.
//

#import "RootViewController.h"
#import "JTCardsLayout.h"
#import "SampleViewController.h"
#import "BViewController.h"
#import "JTCardsViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.title = @"Cards Samples";
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)defaultLayoutPressed:(id)sender {
  NSMutableArray *cards = [NSMutableArray array];
  {
    {
      SampleViewController *controller = [[SampleViewController alloc] initWithTitle:@"A"];
      controller.view.backgroundColor = [UIColor greenColor];
      [cards addObject:controller];
    }
    
    {
      SampleViewController *controller = [[SampleViewController alloc] initWithTitle:@"B"];
      controller.view.backgroundColor = [UIColor blueColor];
      [cards addObject:controller];
    }
    
    {
      SampleViewController *controller = [[SampleViewController alloc] initWithTitle:@"C"];
      controller.view.backgroundColor = [UIColor orangeColor];
      [cards addObject:controller];
    }
    
    {
      BViewController *controller = [[BViewController alloc] init];
      [cards addObject:controller];
    }
  }
  JTCardsViewController *controller = [[JTCardsViewController alloc] initWithCards:cards];
  controller.title = @"Default";
  [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)customisedLayoutPressed:(id)sender {
  NSMutableArray *cards = [NSMutableArray array];
  {
    {
      SampleViewController *controller = [[SampleViewController alloc] initWithTitle:@"A"];
      controller.view.backgroundColor = [UIColor greenColor];
      [cards addObject:controller];
    }
    
    {
      BViewController *controller = [[BViewController alloc] init];
      [cards addObject:controller];
    }

    {
      SampleViewController *controller = [[SampleViewController alloc] initWithTitle:@"B"];
      controller.view.backgroundColor = [UIColor blueColor];
      [cards addObject:controller];
    }
    
    {
      SampleViewController *controller = [[SampleViewController alloc] initWithTitle:@"C"];
      controller.view.backgroundColor = [UIColor orangeColor];
      [cards addObject:controller];
    }
  }
  JTCardsLayout *layout = [[JTCardsLayout alloc] init];
  layout.topMargin = 10.0;
  layout.containerSize = CGSizeMake(200, 350);
  layout.collapsedSpacing = 20.0;
  layout.peekFromBottom = 40.0;
  layout.expandedSpacing = 40.0;
  JTCardsViewController *controller = [[JTCardsViewController alloc] initWithCards:cards layout:layout];
  controller.title = @"Customised Layout";
  [self.navigationController pushViewController:controller animated:YES];

}
@end
