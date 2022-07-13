//
//  ViewController.m
//  BandWidthDemo
//
//  Created by suin on 2022/6/30.
//

#import "ViewController.h"
#import "BandWidthTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BandWidthTool *tools = [BandWidthTool new];
    
    // 整段资源预估
    [tools updateBandWidthWithDownloadVideoTotalBytes:140000000 downLoadDuration:20];
    NSLog(@"整段资源预估：%f Mbp/s",tools.bandWidth);
    // 分段采样预估
    [tools extractSegmentationViedoWithVideoBytes:10000000 downLoadDuration:2];
    NSLog(@"第一段实时：%.2f Mbp/s 预估第二段：%.2f Mbp/s",tools.bandWidth,tools.predictBandWidth);
    [tools extractSegmentationViedoWithVideoBytes:25000000 downLoadDuration:4];
    NSLog(@"第二段实时：%.2f Mbp/s 预估第三段：%.2f Mbp/s",tools.bandWidth,tools.predictBandWidth);
    [tools extractSegmentationViedoWithVideoBytes:40000000 downLoadDuration:6];
    NSLog(@"第三段实时：%.2f Mbp/s 预估第四段：%.2f Mbp/s",tools.bandWidth,tools.predictBandWidth);
    [tools extractSegmentationViedoWithVideoBytes:60000000 downLoadDuration:8];
    NSLog(@"第四段实时：%.2f Mbp/s 预估第五段：%.2f Mbp/s",tools.bandWidth,tools.predictBandWidth);
    [tools extractSegmentationViedoWithVideoBytes:80000000 downLoadDuration:10];
    NSLog(@"第五段实时：%.2f Mbp/s 预估第六段：%.2f Mbp/s",tools.bandWidth,tools.predictBandWidth);
    [tools extractSegmentationViedoWithVideoBytes:100000000 downLoadDuration:12];
    NSLog(@"第六段实时：%.2f Mbp/s 预估第七段：%.2f Mbp/s",tools.bandWidth,tools.predictBandWidth);
    [tools extractSegmentationViedoWithVideoBytes:110000000 downLoadDuration:14];
    NSLog(@"第七段实时：%.2f Mbp/s 预估第八段：%.2f Mbp/s",tools.bandWidth,tools.predictBandWidth);
    [tools extractSegmentationViedoWithVideoBytes:115000000 downLoadDuration:16];
    NSLog(@"第八段实时：%.2f Mbp/s 预估第九段：%.2f Mbp/s",tools.bandWidth,tools.predictBandWidth);
    [tools extractSegmentationViedoWithVideoBytes:120000000 downLoadDuration:18];
    NSLog(@"第九段实时：%.2f Mbp/s 预估第十段：%.2f Mbp/s",tools.bandWidth,tools.predictBandWidth);
    [tools extractSegmentationViedoWithVideoBytes:140000000 downLoadDuration:20];
    NSLog(@"第十段实时：%.2f Mbp/s 预估第十一段：%.2f Mbp/s",tools.bandWidth,tools.predictBandWidth);
    
}


@end
