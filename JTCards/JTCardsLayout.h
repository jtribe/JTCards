//
//  CardLayout.h
//  Cards
//
//  Created by Armin Kroll on 8/07/13.
//  Copyright (c) 2013 jTribe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JTCardLayoutDelegate <NSObject>
- (void) movedIntoFocus;
- (void) movedOutOfFocus;
@end

/* 
 Layout has 2 states
 1. showing all views
 2. showing single view
 */
@interface JTCardsLayout : NSObject

// showing all views or focusing on one?
@property BOOL showingAll;
// the views to layout
@property (nonatomic,strong) NSArray *views;
// the reference view that contains all other views
@property (nonatomic,strong) UIView *containerView;
// the controller that uses the layout
@property (nonatomic,strong) NSArray *delegates;


// top margin of focused card
@property CGFloat topMargin;
// size to fit the cards in
@property CGSize containerSize;
// spacing between cards when expanded in showAll mode
@property CGFloat expandedSpacing;
// spacing between cards when collapsed at bottom
@property CGFloat collapsedSpacing;
// the distance from the bottom the top collapsed card peeks out
@property CGFloat peekFromBottom;

- (id) initWithViews:(NSArray*)views
           delegates:(NSArray*)delegates
       containerView:(UIView*)containerView;
- (void) layoutAllAnimated:(BOOL)animated;
- (void) bringToFront:(UIView*)view;

@end
