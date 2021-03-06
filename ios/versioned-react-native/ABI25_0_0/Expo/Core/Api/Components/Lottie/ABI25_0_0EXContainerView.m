//
//  ABI25_0_0EXContainerView.m
//  LottieReactABI25_0_0Native
//
//  Created by Leland Richardson on 12/12/16.
//  Copyright © 2016 Airbnb. All rights reserved.
//

#import "ABI25_0_0EXContainerView.h"

// import UIView+ReactABI25_0_0.h
#if __has_include(<ReactABI25_0_0/UIView+ReactABI25_0_0.h>)
#import <ReactABI25_0_0/UIView+ReactABI25_0_0.h>
#elif __has_include("UIView+ReactABI25_0_0.h")
#import "UIView+ReactABI25_0_0.h"
#else
#import "ReactABI25_0_0/UIView+ReactABI25_0_0.h"
#endif

@implementation ABI25_0_0EXContainerView {
  LOTAnimationView *_animationView;
}

- (void)ReactABI25_0_0SetFrame:(CGRect)frame
{
  [super ReactABI25_0_0SetFrame:frame];
  if (_animationView != nil) {
    [_animationView ReactABI25_0_0SetFrame:frame];
  }
}

- (void)setProgress:(CGFloat)progress {
  _progress = progress;
  if (_animationView != nil) {
    _animationView.animationProgress = _progress;
  }
}

- (void)setSpeed:(CGFloat)speed {
  _speed = speed;
  if (_animationView != nil) {
    _animationView.animationSpeed = _speed;
  }
}

- (void)setLoop:(BOOL)loop {
  _loop = loop;
  if (_animationView != nil) {
    _animationView.loopAnimation = _loop;
  }
}

- (void)setResizeMode:(NSString *)resizeMode {
  if ([resizeMode isEqualToString:@"cover"]) {
    [self setContentMode:UIViewContentModeScaleAspectFill];
  } else if ([resizeMode isEqualToString:@"contain"]) {
    [self setContentMode:UIViewContentModeScaleAspectFit];
  } else if ([resizeMode isEqualToString:@"center"]) {
    [self setContentMode:UIViewContentModeCenter];
  }
}

- (void)setSourceJson:(NSString *)jsonString {
  NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                       options:kNilOptions
                                                         error:nil];
  [self replaceAnimationView:[LOTAnimationView animationFromJSON:json]];
}

- (void)setSourceName:(NSString *)name {
  [self replaceAnimationView:[LOTAnimationView animationNamed:name]];
}

- (void)play {
  if (_animationView != nil) {
    [_animationView play];
  }
}

- (void)playFromFrame:(NSNumber *)startFrame
              toFrame:(NSNumber *)endFrame {
  if (_animationView != nil) {
    [_animationView playFromFrame:startFrame
                          toFrame:endFrame withCompletion:nil];
  }
}

- (void)reset {
  if (_animationView != nil) {
    _animationView.animationProgress = 0;
    [_animationView pause];
  }
}

# pragma mark Private

- (void)replaceAnimationView:(LOTAnimationView *)next {
  if (_animationView != nil) {
    [_animationView removeFromSuperview];
  }
  _animationView = next;
  [self addSubview: next];
  [_animationView ReactABI25_0_0SetFrame:self.frame];
  [_animationView setContentMode:UIViewContentModeScaleAspectFit];
  [self applyProperties];
}

- (void)applyProperties {
  _animationView.animationProgress = _progress;
  _animationView.animationSpeed = _speed;
  _animationView.loopAnimation = _loop;
}

@end
