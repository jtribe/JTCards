//
//  CardWithImageViewController.h
//  Cards
//
//  Created by Armin Kroll on 14/07/13.
//  Copyright (c) 2013 jTribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardWithImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic,strong) NSString* headerText;
@property (nonatomic,strong) NSString* contentText;
@property (nonatomic,strong) UIImage* image;

@end
