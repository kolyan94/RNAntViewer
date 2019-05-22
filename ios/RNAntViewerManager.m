
#import "RNAntViewerManager.h"
@import AntViewer_ios;

@implementation RNAntViewerManager

RCT_EXPORT_MODULE(AntViewer)

- (UIView *)view
{
  return [[AntWidget alloc] init];
}

@end


  
