//
//  BandWidthTools.m
//  BandWidthDemo
//
//  Created by suin on 2022/6/30.
//

#import "BandWidthTool.h"
#import <math.h>

#define NaturalLogarithm 2.718281828459

@interface BandWidthTool()

/// 上次间隔采样的带宽结果
@property (nonatomic, assign) NSInteger lastIntervalBandWidth;
/// 上次间隔采样的平均带宽结果
@property (nonatomic, assign) NSInteger lastAverageBandWidth;
/// 上次采样的数据大小
@property (nonatomic, assign) NSInteger lastBytes;
@end

@implementation BandWidthTool

#pragma mark -- 段内带宽预测

/// 更新当前带宽 当资源时长小于 videoDurationThreshold (s) 时调用
/// @param totalBytes 下载完成的资源的数据总量
/// @param downLoadDuration 从发出请求到下载完毕的时长 单位 s
- (void)updateBandWidthWithDownloadVideoTotalBytes:(NSInteger)totalBytes downLoadDuration:(CGFloat)downLoadDuration{
    _bandWidth =  totalBytes / downLoadDuration / 125000;
}

/// 等时间间隔取样 当资源时长大于 videoDurationThreshold (s) 时调用，每隔 videoIntervalValue (s) 调用一次 直到资源下载完毕
/// @param bytes 当前已下载的数据总量
/// @param downLoadDuration 当前下载所用时间
- (void)extractSegmentationViedoWithVideoBytes:(NSInteger)bytes downLoadDuration:(CGFloat)downLoadDuration{
    // 计算当前取样次数
    int intervalCount = downLoadDuration / videoIntervalValue;
    if (intervalCount == 0) {
        _lastIntervalBandWidth = 0;
        _lastAverageBandWidth = 0;
        _lastBytes = 0;
        return;
    }
    if (intervalCount == 1) {
        _bandWidth = bytes / downLoadDuration / 125000;
        _predictBandWidth = _bandWidth;
        _lastIntervalBandWidth = _bandWidth;
        _lastAverageBandWidth = _bandWidth;
        _lastBytes = bytes;
        return;
    }
    
    // 计算抽样值的指数平均值
    _bandWidth = ((intervalCount - 1) * _lastAverageBandWidth + 2 * _lastIntervalBandWidth) / (intervalCount + 1);
    // 计算带宽预估值
    _predictBandWidth = _bandWidth + [self volatilityValue];
    // 记录上次的平均值、实时值
    _lastIntervalBandWidth = (bytes - _lastBytes) / videoIntervalValue / 125000;
    _lastAverageBandWidth = _bandWidth;
    _lastBytes = bytes;
}

#pragma mark -- 段间带宽预测

/// 获取估测带宽和即时带宽的差值
- (CGFloat)differenceValue{
    return _predictBandWidth - _bandWidth;
}

/// 获取修正值
- (CGFloat)correctionValue{
    CGFloat normalizedValue = fabs([self differenceValue]) / 100;
    return 1 / (1 + powf(NaturalLogarithm, 21 * (normalizedValue - 0.167)));
}

/// 获取波动值
- (CGFloat)volatilityValue{
    return [self differenceValue] * [self correctionValue];
}

@end
