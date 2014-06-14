//
//  CatchCopyView.m
//  TinderLikeAnimations2
//
//  Created by Shun Usami on 2014/05/28.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = self.bounds;
        self.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.0];
        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, frame.size.height-64)];
//        UIImage *image = [UIImage  imageNamed:@"pointing2"];
//        float x = image.size.width;
//        float y = image.size.height;
//        float x2 = y*frame.size.width/(frame.size.height-64);
//        NSLog(@"%f %f %f %f %f",x, y,frame.size.width, frame.size.height-64, x2);
//        CGImageRef cgImage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(300, 0, x2, y));
//        UIImage *useimage = [UIImage imageWithCGImage:cgImage];
//        imageView.image = useimage;
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        [self addSubview:imageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
