
#import "RNAntViewerManager.h"
@import AntViewer_ios;

@implementation RNAntViewerManager

RCT_EXPORT_MODULE(AntViewer)

- (UIView *)view
{
  return [[AntWidget alloc] init];
}
  
RCT_EXPORT_VIEW_PROPERTY(isLightMode, BOOL);
RCT_EXPORT_VIEW_PROPERTY(rightMargin, NSInteger);
RCT_EXPORT_VIEW_PROPERTY(bottomMargin, NSInteger);
RCT_EXPORT_VIEW_PROPERTY(onViewerAppear, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onViewerDisappear, RCTBubblingEventBlock);
  
+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

@end


  
