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
#import "CardWithImageViewController.h"

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

- (IBAction)oneMorePressed:(id)sender {
  NSMutableArray *cards = [NSMutableArray array];
  {
    {
      CardWithImageViewController *controller = [[CardWithImageViewController alloc] init];
      controller.headerText = @"Some red info";
      controller.image = [UIImage imageNamed:@"bg_1.png"];
      controller.contentText = @"Kia ora.. Sink some piss, this beautiful sheila is as beaut as a solid rimu Undie 500. Mean while, in the Four Square supermarket, Dr Ropata and Rhys Darby were up to no good with a bunch of stoked Tuis. The mean as force ";
      [cards addObject:controller];
    }
    {
      CardWithImageViewController *controller = [[CardWithImageViewController alloc] init];
      controller.headerText = @"Some orange info";
      controller.image = [UIImage imageNamed:@"bg_2.png"];
      controller.contentText = @"Put the jug on will you bro, all these pretty suss kais can wait till later. The first prize for frying up goes to... Mrs Falani and his same same but different rugby ball, what a egg. Bro, giant wekas are really hammered good with";
      [cards addObject:controller];
    }
    {
      CardWithImageViewController *controller = [[CardWithImageViewController alloc] init];
      controller.headerText = @"Some blue info";
      controller.image = [UIImage imageNamed:@"bg_3.png"];
      controller.contentText = @"The next Generation of hard yakka ankle biters have already flogged over at the fish n' chip shop. What's the hurry Mr Whippy? There's plenty of boxes of fluffies in behind the bicycle shed. Castle Hill holds the most good as community in the country.";
      [cards addObject:controller];
    }    {
      CardWithImageViewController *controller = [[CardWithImageViewController alloc] init];
      controller.headerText = @"Some green info";
      controller.image = [UIImage imageNamed:@"bg_4.png"];
      controller.contentText = @"TPull a sickie, but. The pearler force of his pashing was on par with Bazza's mint length of number 8 wire. Put the jug on will you bro, all these random quater-acre patchs can wait till later.";
      [cards addObject:controller];
    }
  }
  JTCardsViewController *controller = [[JTCardsViewController alloc] initWithCards:cards];
  [self.navigationController pushViewController:controller animated:YES];

}
@end
