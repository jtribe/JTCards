//
//  BViewController.h
//  Cards
//
//  Created by Armin Kroll on 8/07/13.
//  Copyright (c) 2013 jTribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)switchedChanged:(id)sender;
- (IBAction)segmentChanged:(id)sender;

@end
