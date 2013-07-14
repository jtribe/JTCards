//
//  CardWithImageViewController.m
//  Cards
//
//  Created by Armin Kroll on 14/07/13.
//  Copyright (c) 2013 jTribe. All rights reserved.
//

#import "CardWithImageViewController.h"

@interface CardWithImageViewController ()

@end

@implementation CardWithImageViewController

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
  // Do any additional setup after loading the view from its nib.
  if (self.image) self.cardImageView.image = self.image;
  if (self.headerText) self.headerLabel.text = self.headerText;
  if (self.contentText) self.contentLabel.text = self.contentText;
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
