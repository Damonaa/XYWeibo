//
//  XYPhoto.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYSinglePhoto.h"
#import "UIImageView+WebCache.h"

@interface XYSinglePhoto ()

@property (nonatomic, weak) UIImageView *gifIV;
@end

@implementation XYSinglePhoto

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor redColor];
        UIImageView *gifIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        self.gifIV = gifIV;
        [self addSubview:gifIV];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.gifIV.x = self.width - self.gifIV.width;
    self.gifIV.y = self.height - self.gifIV.height;
 
}

- (void)setPicUrl:(NSURL *)picUrl{
    _picUrl = picUrl;
    
    [self sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    NSString *urlStr = picUrl.absoluteString;
//    XYLog(@"%@", urlStr);
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifIV.hidden = NO;
    }else{
        self.gifIV.hidden = YES;
    }
}
@end
