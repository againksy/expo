#import "ABI24_0_0EXBrightness.h"

#import <UIKit/UIKit.h>

@implementation ABI24_0_0EXBrightness

ABI24_0_0RCT_EXPORT_MODULE(ExponentBrightness);


ABI24_0_0RCT_EXPORT_METHOD(setBrightnessAsync:
                  (float)brightnessValue
                  resolver:(ABI24_0_0RCTPromiseResolveBlock)resolve
                  rejecter:(ABI24_0_0RCTPromiseRejectBlock)reject)
{
  [self _performSynchronouslyOnMainThread:^{
    [UIScreen mainScreen].brightness = brightnessValue;
  }];
  resolve(nil);
}

ABI24_0_0RCT_REMAP_METHOD(getBrightnessAsync,
                 resolver:(ABI24_0_0RCTPromiseResolveBlock)resolve
                 rejecter:(ABI24_0_0RCTPromiseRejectBlock)reject)
{
  __block float result = 0;
  [self _performSynchronouslyOnMainThread:^{
    result = [UIScreen mainScreen].brightness;
  }];
  resolve(@(result));
}

- (void)_performSynchronouslyOnMainThread:(void (^)(void))block
{
  if ([NSThread isMainThread]) {
    block();
  } else {
    dispatch_sync(dispatch_get_main_queue(), block);
  }
}

@end
