//
//  CardLayout.m
//  Cards
//
//  Created by Armin Kroll on 8/07/13.
//  Copyright (c) 2013 jTribe. All rights reserved.
//

#import "JTCardsLayout.h"

@interface JTCardsLayout ()
@property CGPoint startPanLocation;
@property CGPoint lastPanLocation;
@property id<JTCardLayoutDelegate> delegateInFocus;
@end

@implementation JTCardsLayout

- (id) initWithViews:(NSArray*)views
           delegates:(NSArray*)delegates
       containerView:(UIView*)containerView
{
  self = [super init];
  if (self) {
    self.views = views;
    [self addTapViews];
    self.delegates = delegates;
    self.containerView = containerView;
    self.topMargin = 0.0;
    self.containerSize = self.containerView.bounds.size;
    self.collapsedSpacing = 5.0;
    self.peekFromBottom = 50.0;
    self.expandedSpacing = 0.0;
  }
  return self;
}

- (id) init
{
  return [self initWithViews:nil delegates:nil containerView:nil];
}

#pragma mark - augment views
- (void)addTapViews {
  for (UIView *view in self.views) {
    UIView *tapView = [[UIView alloc] initWithFrame:view.bounds];
    tapView.backgroundColor = [UIColor clearColor];
    [view addSubview:tapView];
    [self addTapGestureRecogniserToView:tapView];
  }
}

- (void)removeTapViews {
  for (UIView *view in self.views) {
    // TODO: should we use a tag instead?
    UIView *tapView = [view.subviews lastObject];
    [tapView removeFromSuperview];
  }
}

- (void) deactivateTapForView:(UIView*)view
{
  UIView *tapView = [view.subviews lastObject];
  tapView.userInteractionEnabled = NO;
}
- (void) activateTapForView:(UIView*)view
{
  UIView *tapView = [view.subviews lastObject];
  tapView.userInteractionEnabled = YES;
}

#pragma mark - accessors

- (CGSize) sizeToFit
{
  CGFloat bottomPartHeight = [self.views count] * self.collapsedSpacing;
  return CGSizeMake(self.containerSize.width,
                    self.containerSize.height - self.topMargin - bottomPartHeight);
}

#pragma mark - Logic
// find the delegate to call and let know that it moved out of focus.
- (id) delegateForView:(id)view
{
  NSInteger index = [self.views indexOfObject:view];
  id<JTCardLayoutDelegate> delegate = [self.delegates objectAtIndex:index];
  return delegate;
}


// layout is a function of the index of the child controller
- (void) layoutAllAnimated:(BOOL)animated;
{
  self.showingAll = YES;
  
  NSInteger index = 0;
  CGFloat availableHeigth = self.containerView.bounds.size.height - self.topMargin;
  CGFloat offset = (self.expandedSpacing? self.expandedSpacing : availableHeigth / [self.views count]);
  // let delegate know it moved out of focus
  if (self.delegateInFocus) {
    if ([self.delegateInFocus respondsToSelector:@selector(movedOutOfFocus)]) {
      [self.delegateInFocus movedOutOfFocus];
    }
    self.delegateInFocus = nil;
  }
  
  for (UIView *view in self.views) {
    // force into container size if needed
    [self activateTapForView:view];
    
    // (re)attach pan recogniser to view
    [self addPanGestureRecogniserToView:view];

    CGFloat w = view.frame.size.width > self.sizeToFit.width ? self.sizeToFit.width : view.frame.size.width;
    CGFloat h =  view.frame.size.height > self.sizeToFit.height ? self.sizeToFit.height : view.frame.size.height;// self.sizeToFit.height;
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
    selectedView.center = CGPointMake(selectedView.superview.bounds.size.width/2, selectedView.bounds.size.height/2 + self.topMargin);
  } completion:^(BOOL finished) {
    [self deactivateTapForView:selectedView];
    // let the delegate know that it is in focus
    id delegate = [self delegateForView:selectedView];
    if (delegate) {
      if ([delegate respondsToSelector:@selector(movedIntoFocus)]) {
        [delegate movedIntoFocus];
      }
      self.delegateInFocus = delegate;
    }
  }];
  
  // move the other views down
  NSInteger index = 0;
  for (UIView *view in self.views) {
    if (selectedView != view) {
      [UIView animateWithDuration:0.3 delay:0.0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        CGFloat moveDownBy = (view.superview.frame.size.height - view.frame.origin.y);
        view.center = CGPointMake(view.center.x, view.center.y + moveDownBy);
      } completion:^(BOOL finished) {
        // move up to peek out from bottom
        [UIView animateWithDuration:0.1 animations:^{
          CGFloat moveUpBy = (self.peekFromBottom - index * self.collapsedSpacing);
          view.center = CGPointMake(view.center.x, view.center.y - moveUpBy);
        }];
      }];
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
  // The (real) view is the superview. The recogniser was put on a child.
  UIView *view = recogniser.view.superview;
  // bring to front
  if (view) {
    [self bringToFront:view];
//    [view removeGestureRecognizer:recogniser];
  }
}

#pragma mark pan
- (void) panRecognised:(UIPanGestureRecognizer*)recogniser
{
  UIView *view = recogniser.view;
  CGPoint location = [recogniser translationInView:view];
  NSLog(@"%f, %f", location.x, location.y);
  
  CGFloat movedTotalDownBy = (location.y - self.startPanLocation.y);
  NSLog(@"total moved %f", movedTotalDownBy);
  CGFloat movedDownBy = (location.y - self.lastPanLocation.y);
  NSLog(@"moved %f", movedDownBy);
  
  if (recogniser.state == UIGestureRecognizerStateEnded) {
    if ( movedTotalDownBy > 100) {
      // collapse and show all when moved to far down.
      [self layoutAllAnimated:YES];
    }
    else {
      // bounce back
      [self bringToFront:view];
    }
    self.lastPanLocation = CGPointZero;
    self.startPanLocation = CGPointZero;
    return;
  }
  if (recogniser.state == UIGestureRecognizerStateBegan) {
    self.startPanLocation = location;
    return;
  }
  
  if (!self.lastPanLocation.y == 0 ) {
    view.center = CGPointMake(view.center.x, view.center.y + movedDownBy);
  }
  self.lastPanLocation = location;
}

@end
