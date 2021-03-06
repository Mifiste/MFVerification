//
//  AuthcodeView.m
//  MFTextView
//
//  Created by lanouhn on 16/4/29.
//  Copyright © 2016年 Mifiste. All rights reserved.
//

#import "AuthcodeView.h"

#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
#define kLineCount 4
#define kLineWidth 1.0
#define kCharCount 4
#define kFontSize [UIFont systemFontOfSize:arc4random() % 5 + 15]

@implementation AuthcodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = kRandomColor;
        
        //获取验证码
        [self getAuthcode];
    }
    return self;
}

- (void)getAuthcode {
    //素材
    self.dataArray = @[@"A", @"B" , @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"a", @"b" , @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z"];
    self.authcodeString = [[NSMutableString alloc] initWithCapacity:kCharCount];
    
    for (int i = 0; i < kCharCount; i++) {
        NSInteger index = arc4random() % (self.dataArray.count - 1);
        NSString *tempStr = self.dataArray[index];
        self.authcodeString = (NSMutableString *)[self.authcodeString stringByAppendingString:tempStr];
    }
}

//点击切换界面
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self getAuthcode];
    
    //利用drawRect方法来绘制验证码
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.backgroundColor = kRandomColor;
    
    //根据要显示的验证码字符 根据长度计算显示位置
    
    NSString *text = [NSString stringWithFormat:@"%@", self.authcodeString];
    
    CGSize cSize = [@"A" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    
    int width = rect.size.width / text.length - cSize.width;
    
    int height = rect.size.height - cSize.height;
    
    CGPoint point;
    
    float pX, pY;
    
    for (int i = 0; i < text.length; i++) {
        pX = arc4random() % width + rect.size.width / text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%c", c];
        
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:kFontSize}];
    }
    
    //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条宽度
    CGContextSetLineWidth(context, kLineWidth);
    
    //绘制干扰线
    for (int i = 0; i < kLineCount; i++)
    {
        UIColor *color = kRandomColor;
        CGContextSetStrokeColorWithColor(context, color.CGColor);//设置线条填充色
        
        //设置线的起点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        //设置线终点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        //画线
        CGContextStrokePath(context);
    }
    
}

@end
