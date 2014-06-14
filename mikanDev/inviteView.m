//
//  inviteView.m
//  TinderLikeAnimations2
//
//  Created by Shun Usami on 2014/05/31.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import "inviteView.h"

@implementation inviteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    UIImage *image = [UIImage  imageNamed:@"NotYet"];
    float x = image.size.width;
    float y = image.size.height;
    float x2 = y*frame.size.width/frame.size.height;
    NSLog(@"%f %f %f %f %f",x, y,frame.size.width, frame.size.height, x2);
    CGImageRef cgImage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, x2, y));
    UIImage *useimage = [UIImage imageWithCGImage:cgImage];
    imageView.image = useimage;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.alpha = 0.8;
    [self addSubview:imageView];
    UILabel* hogeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 140, self.frame.size.width, 40)];
    hogeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:32.0];
    hogeLabel.text = @"Coming Soon...";
    hogeLabel.textColor = [UIColor whiteColor];
    hogeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:hogeLabel];
    
    
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
