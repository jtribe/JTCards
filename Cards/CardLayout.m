//
//  CardLayout.m
//  Cards
//
//  Created by Armin Kroll on 8/07/13.
//  Copyright (c) 2013 jTribe. All rights reserved.
//

#import "CardLayout.h"

@interface CardLayout ()

@property CGPoint startPanLocation;

@end

@implementation CardLayout

- (id) initWithViews:(NSArray*)views containerView:(UIView*)containerView
{
  self = [super init];
  if (self) {
    self.views = views;
    self.containerView = containerView;
    self.topMargin = 50.0;
    CGFloat bottomPartHeight = [self.views count] * self.collapsedSpacing;
    self.sizeToFit = CGSizeMake(containerView.bounds.size.width,
                                containerView.bounds.size.height - self.topMargin - bottomPartHeight);
    self.collapsedSpacing = 10.0;
    self.peekFromBottom = 30.0;
    self.expandedSpacing = 0.0;
  }
  return self;
}


#pragma mark - Logic


// layout is a function of the index of the child controller
- (void) layoutAllAnimated:(BOOL)animated;
{
  self.showingAll = YES;
  
  NSInteger index = 0;
  CGFloat availableHeigth = self.containerView.h - self.topMargin;
  CGFloat offset = (self.expandedSpacing? self.expandedSpacing : availableHeigth / [self.views count]);
  for (UIView *view in self.views) {
    [self addTapGestureRecogniserToView:view];
    CGFloat w = view.frame.size.width > self.sizeToFit.width ? self.sizeToFit.width : view.frame.size.width;
    CGFloat h = view.frame.size.height > self.sizeToFit.height ? self.sizeToFit.height : view.frame.size.height;
    CGFloat y = (offset * index) + self.topMargin;
    CGFloat x = view.superview.bounds.size.width/2 - w/2;
    CGRect rect = CGRectMake(x,y,w,h);
    if (!animated) {
      view.frame = rect;
    }
    else {
      [UIView animateWithDuration:0.3 delay:0.01*index options:(UIViewAnimationOptionCurveEaseInOut)animations:^{
        view.frame = rect;
      } completion:^(BOOL finished) {
        // done
      }];
    }
    index++;
  }
  
}

- (void) bringToFront:(UIView*)selectedView
{
  self.showingAll = NO;
  
  // move the controller view to top position
  [UIView animateWithDuration:0.3 delay:0.0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
    [selectedView centerOnSuperview];
  } completion:^(BOOL finished) {
    // done
  }];
  
  // move the other views down
  NSInteger index = 0;
  for (UIView *view in self.views) {
    if (selectedView != view) {
      [UIView animateWithDuration:0.3 delay:0.0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        [view moveDownBy:(view.superview.h - view.y)];
      } completion:^(BOOL finished) {
        // move up to peek out
        [UIView animateWithDuration:0.1 animations:^{
          [view moveUpBy:(self.peekFromBottom - index * self.collapsedSpacing)];
        }];
      }];
      [self addPanGestureRecogniserToView:view];
      index++;
    }
  }
}

#pragma mark - tap gesture
- (void) addTapGestureRecogniserToView:(UIView*)view
{
  // only add tap gesture if there is not already one
  for (UITapGestureRecognizer *recogniser in view.gestureRecognizers)
  {
    if ([recogniser isKindOfClass:[UITapGestureRecognizer class]] && recogniser.numberOfTapsRequired == 1) return;
  }
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognised:)];
  [view addGestureRecognizer:tap];
}

- (void) removeTapGestureRecognisersForView:(UIView*)view
{
  for (UITapGestureRecognizer *recogniser in view.gestureRecognizers)
  {
    if ([recogniser isKindOfClass:[UITapGestureRecognizer class]] && recogniser.numberOfTapsRequired == 1) {
      [view removeGestureRecognizer:recogniser];
    }
  }
}

#pragma mark - pan gesture
- (void) addPanGestureRecogniserToView:(UIView*)view
{
  // only add tap gesture if there is not already one
  for (UIPanGestureRecognizer *recogniser in view.gestureRecognizers)
  {
    if ([recogniser isKindOfClass:[UIPanGestureRecognizer class]]) return;
  }
  UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognised:)];
  [view addGestureRecognizer:pan];
}

- (void) removePanGestureRecognisersForView:(UIView*)view
{
  for (UIPanGestureRecognizer *recogniser in view.gestureRecognizers)
  {
    if ([recogniser isKindOfClass:[UITapGestureRecognizer class]] ) {
      [view removeGestureRecognizer:recogniser];
    }
  }
}

#pragma mark - Actions

#pragma mark tap
- (void) tapRecognised:(UIGestureRecognizer*)recogniser
{
  NSLog(@"tapped");
  // show all
  if (!self.showingAll) {
    [self layoutAllAnimated:YES];
    return;
  }
  
  // or bring selected to front
  UIView *view = recogniser.view;
  // bring to front
  if (view) {
    [self bringToFront:view];
    [view removeGestureRecognizer:recogniser];
  }
}

#pragma mark pan
- (void) panRecognised:(UIPanGestureRecognizer*)recogniser
{
  if (recogniser.state == UIGestureRecognizerStateEnded) {
    // bounce back
    [self bringToFront:recogniser.view];
    return;
  }
  if (recogniser.state == UIGestureRecognizerStateBegan) {
    self.startPanLocation = [recogniser translationInView:recogniser.view];
    return;
  }
  
  CGPoint location = [recogniser translationInView:recogniser.view];
  [recogniser.view moveDownBy:(location.y - self.startPanLocation.y)];
  self.startPanLocation = location;
}
                                       

@end