//
//  BandWidthTools.h
//  BandWidthDemo
//
//  Created by suin on 2022/6/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define videoDurationThreshold 10.0
#define videoIntervalValue 2.0

@interface BandWidthTool : NSObject

/// 当前最新带宽，单位 Mbps
@property (nonatomic, assign, readonly) CGFloat bandWidth;
/// 预估带宽，单位 Mbps
@property (nonatomic, assign, readonly) CGFloat predictBandWidth;

/// 更新当前带宽 当资源时长小于 videoDurationThreshold (s) 时调用
/// @param totalBytes 下载完成的资源的数据总量
/// @param downLoadDuration 从发出请求到下载完毕的时长 单位 s
- (void)updateBandWidthWithDownloadVideoTotalBytes:(NSInteger)totalBytes downLoadDuration:(CGFloat)downLoadDuration;


/// 等时间间隔取样 当资源时长大于 videoDurationThreshold (s) 时调用，每隔 videoIntervalValue (s) 调用一次 直到资源下载完毕
/// @param bytes 当前已下载的数据总量
/// @param downLoadDuration 当前下载所用时间
- (void)extractSegmentationViedoWithVideoBytes:(NSInteger)bytes downLoadDuration:(CGFloat)downLoadDuration;

@end

NS_ASSUME_NONNULL_END
