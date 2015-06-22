/**
 * Commercial : Copyright (c) 2014
 * ArlSoft Tecnologia <contato@arlsoft.com.br>
 *
 * All rights reserved.
 * This is proprietary software.
 * No warranty, explicit or implicit, provided.
 */

#import "CircularProgressView.h"

#import <QuartzCore/QuartzCore.h>

@interface CircularProgressLayer : CALayer

@property(nonatomic, strong) UIFont *textFont;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic) CGFloat textOpacity;
@property(nonatomic, strong) UIColor *trackTintColor;
@property(nonatomic, strong) UIColor *progressTintColor;
@property(nonatomic) CGFloat trackOpacity;
@property(nonatomic) CGFloat progressOpacity;
@property(nonatomic) NSInteger roundedCorners;
@property(nonatomic) CGFloat thicknessRatio;
@property(nonatomic) CGFloat progress;
@property(copy, nonatomic) NSString *text;

@end

@implementation CircularProgressLayer

@dynamic textFont;
@dynamic textColor;
@dynamic textOpacity;
@dynamic trackTintColor;
@dynamic progressTintColor;
@dynamic trackOpacity;
@dynamic progressOpacity;
@dynamic roundedCorners;
@dynamic thicknessRatio;
@dynamic progress;
@dynamic text;

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"progress"]) {
        return YES;
    } else if ([key isEqualToString:@"text"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

- (void)drawInContext:(CGContextRef)context
{
    CGRect rect = self.bounds;
    CGPoint centerPoint = CGPointMake(rect.size.width / 2.0f, rect.size.height / 2.0f);
    CGFloat radius = MIN(rect.size.height, rect.size.width) / 2.0f;
    
    CGFloat progress = MIN(self.progress, 1.0f - FLT_EPSILON);
    CGFloat radians = (float)((progress * 2.0f * M_PI) - M_PI_2);
    
    CGContextSetFillColorWithColor(context, [self.trackTintColor colorWithAlphaComponent:self.trackOpacity].CGColor);
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius, (float)(2.0f * M_PI), 0.0f, TRUE);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(context, trackPath);
    CGContextFillPath(context);
    CGPathRelease(trackPath);
    
    if (progress > 0.0f) {
        CGContextSetBlendMode(context, kCGBlendModeClear);

        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGMutablePathRef progressPathClear = CGPathCreateMutable();
        CGPathMoveToPoint(progressPathClear, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(progressPathClear, NULL, centerPoint.x, centerPoint.y, radius, (float)(3.0f * M_PI_2), radians, NO);

        if (self.roundedCorners) {
            CGFloat pathWidth = radius * self.thicknessRatio;
            CGFloat xOffset = radius * (1.0f + ((1.0f - (self.thicknessRatio / 2.0f)) * cosf(radians)));
            CGFloat yOffset = radius * (1.0f + ((1.0f - (self.thicknessRatio / 2.0f)) * sinf(radians)));
            CGPoint endPoint = CGPointMake(xOffset, yOffset);
            
            CGRect startEllipseRectClear = (CGRect) {
                .origin.x = centerPoint.x - pathWidth / 2.0f,
                .origin.y = 0.0f,
                .size.width = pathWidth,
                .size.height = pathWidth
            };
            CGPathAddEllipseInRect(progressPathClear, NULL, startEllipseRectClear);
            
            CGRect endEllipseRectClear = (CGRect) {
                .origin.x = endPoint.x - pathWidth / 2.0f,
                .origin.y = endPoint.y - pathWidth / 2.0f,
                .size.width = pathWidth,
                .size.height = pathWidth
            };
            CGPathAddEllipseInRect(progressPathClear, NULL, endEllipseRectClear);
        }

        CGPathCloseSubpath(progressPathClear);
        CGContextAddPath(context, progressPathClear);
        CGContextFillPath(context);
        CGPathRelease(progressPathClear);

        CGContextSetBlendMode(context, kCGBlendModeNormal);
    
        CGContextSetFillColorWithColor(context, [self.progressTintColor colorWithAlphaComponent:self.progressOpacity].CGColor);
        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, (float)(3.0f * M_PI_2), radians, NO);
    
        if (self.roundedCorners) {
            CGFloat pathWidth = radius * self.thicknessRatio;
            CGFloat xOffset = radius * (1.0f + ((1.0f - (self.thicknessRatio / 2.0f)) * cosf(radians)));
            CGFloat yOffset = radius * (1.0f + ((1.0f - (self.thicknessRatio / 2.0f)) * sinf(radians)));
            CGPoint endPoint = CGPointMake(xOffset, yOffset);
            
            CGRect startEllipseRect = (CGRect) {
                .origin.x = centerPoint.x - pathWidth / 2.0f,
                .origin.y = 0.0f,
                .size.width = pathWidth,
                .size.height = pathWidth
            };
            CGPathAddEllipseInRect(progressPath, NULL, startEllipseRect);
            
            CGRect endEllipseRect = (CGRect) {
                .origin.x = endPoint.x - pathWidth / 2.0f,
                .origin.y = endPoint.y - pathWidth / 2.0f,
                .size.width = pathWidth,
                .size.height = pathWidth
            };
            CGPathAddEllipseInRect(progressPath, NULL, endEllipseRect);
        }

        CGPathCloseSubpath(progressPath);
        CGContextAddPath(context, progressPath);
        CGContextFillPath(context);
        CGPathRelease(progressPath);
    }

    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGFloat innerRadius = radius * (1.0f - self.thicknessRatio);
    CGRect clearRect = (CGRect) {
        .origin.x = centerPoint.x - innerRadius,
        .origin.y = centerPoint.y - innerRadius,
        .size.width = innerRadius * 2.0f,
        .size.height = innerRadius * 2.0f
    };
    CGContextAddEllipseInRect(context, clearRect);
    CGContextFillPath(context);

    NSString* text = self.text;
    
    if (text != nil && ![text isEqualToString:@""]) {
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        
        UIGraphicsPushContext(context);
        
        NSDictionary *attributes = @{ NSFontAttributeName : self.textFont,
                                      NSForegroundColorAttributeName : [self.textColor colorWithAlphaComponent:self.textOpacity] };
        
        CGRect textFrame = [text boundingRectWithSize:rect.size
                                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                           attributes:attributes
                                              context:nil];
        
        CGPoint textFrameMidPoint = CGPointMake(CGRectGetMidX(textFrame), CGRectGetMidY(textFrame));
        
        CGFloat dx = centerPoint.x - textFrameMidPoint.x;
        CGFloat dy = centerPoint.y - textFrameMidPoint.y;
        CGPoint drawPoint = CGPointMake(dx, dy);
        
        [text drawAtPoint:drawPoint withAttributes:attributes];
        
        UIGraphicsPopContext();
    }
}

@end

@interface CircularProgressView ()

@end

@implementation CircularProgressView

+ (void) initialize
{
    if (self == [CircularProgressView class]) {
        CircularProgressView *circularProgressViewAppearance = [CircularProgressView appearance];

        [circularProgressViewAppearance setTextFont:[UIFont boldSystemFontOfSize:12.0f]];
        [circularProgressViewAppearance setTextColor:[UIColor whiteColor]];
        [circularProgressViewAppearance setTextOpacity:1.0f];

        [circularProgressViewAppearance setTrackTintColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3f]];
        [circularProgressViewAppearance setProgressTintColor:[UIColor whiteColor]];
        [circularProgressViewAppearance setTrackOpacity:1.0f];
        [circularProgressViewAppearance setProgressOpacity:1.0f];
        [circularProgressViewAppearance setBackgroundColor:[UIColor clearColor]];
        [circularProgressViewAppearance setThicknessRatio:0.3f];
        [circularProgressViewAppearance setRoundedCorners:NO];
        
        [circularProgressViewAppearance setIndeterminateDuration:2.0f];
        [circularProgressViewAppearance setIndeterminate:NO];
    }
}

+ (Class)layerClass
{
    return [CircularProgressLayer class];
}

- (CircularProgressLayer *)circularProgressLayer
{
    return (CircularProgressLayer *)self.layer;
}

- (id)init
{
    return [super initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
}

- (void)didMoveToWindow
{
    CGFloat windowContentsScale = self.window.screen.scale;
    self.circularProgressLayer.contentsScale = windowContentsScale;
}

#pragma mark - Progress

- (CGFloat)progress
{
    return self.circularProgressLayer.progress;
}

- (void)setProgress:(CGFloat)progress
{
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [self.layer removeAnimationForKey:@"indeterminateAnimation"];
    [self.circularProgressLayer removeAnimationForKey:@"progress"];
    
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
        animation.duration = fabsf(self.progress - pinnedProgress); // Same duration as UIProgressView animation
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.fromValue = [NSNumber numberWithFloat:self.progress];
        animation.toValue = [NSNumber numberWithFloat:pinnedProgress];
        [self.circularProgressLayer addAnimation:animation forKey:@"progress"];
    } else {
        [self.circularProgressLayer setNeedsDisplay];
    }
    self.circularProgressLayer.progress = pinnedProgress;
}

#pragma mark - Text

- (NSString*)text
{
    return self.circularProgressLayer.text;
}

- (void)setText:(NSString*)text
{
    [self.layer removeAnimationForKey:@"indeterminateAnimation"];
    [self.circularProgressLayer removeAnimationForKey:@"text"];
    
    [self.circularProgressLayer setNeedsDisplay];
    self.circularProgressLayer.text = text;
}

#pragma mark - UIAppearance methods

- (UIFont *)textFont
{
    return self.circularProgressLayer.textFont;
}

- (void)setTextFont:(UIFont *)textFont
{
    self.circularProgressLayer.textFont = textFont;
    [self.circularProgressLayer setNeedsDisplay];
}

- (UIColor *)textColor
{
    return self.circularProgressLayer.textColor;
}

- (void)setTextColor:(UIColor *)textColor
{
    self.circularProgressLayer.textColor = textColor;
    [self.circularProgressLayer setNeedsDisplay];
}

- (CGFloat)textOpacity
{
    return self.circularProgressLayer.textOpacity;
}

- (void)setTextOpacity:(CGFloat)textOpacity
{
    self.circularProgressLayer.textOpacity = textOpacity;
    [self.circularProgressLayer setNeedsDisplay];
}

- (UIColor *)trackTintColor
{
    return self.circularProgressLayer.trackTintColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    self.circularProgressLayer.trackTintColor = trackTintColor;
    [self.circularProgressLayer setNeedsDisplay];
}

- (UIColor *)progressTintColor
{
    return self.circularProgressLayer.progressTintColor;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    self.circularProgressLayer.progressTintColor = progressTintColor;
    [self.circularProgressLayer setNeedsDisplay];
}

- (CGFloat)trackOpacity
{
    return self.circularProgressLayer.trackOpacity;
}

- (void)setTrackOpacity:(CGFloat)trackOpacity
{
    self.circularProgressLayer.trackOpacity = trackOpacity;
    [self.circularProgressLayer setNeedsDisplay];
}

- (CGFloat)progressOpacity
{
    return self.circularProgressLayer.progressOpacity;
}

- (void)setProgressOpacity:(CGFloat)progressOpacity
{
    self.circularProgressLayer.progressOpacity = progressOpacity;
    [self.circularProgressLayer setNeedsDisplay];
}

- (NSInteger)roundedCorners
{
    return self.roundedCorners;
}

- (void)setRoundedCorners:(NSInteger)roundedCorners
{
    self.circularProgressLayer.roundedCorners = roundedCorners;
    [self.circularProgressLayer setNeedsDisplay];
}

- (CGFloat)thicknessRatio
{
    return self.circularProgressLayer.thicknessRatio;
}

- (void)setThicknessRatio:(CGFloat)thicknessRatio
{
    self.circularProgressLayer.thicknessRatio = MIN(MAX(thicknessRatio, 0.f), 1.f);
    [self.circularProgressLayer setNeedsDisplay];
}

- (NSInteger)indeterminate
{
    CAAnimation *spinAnimation = [self.layer animationForKey:@"indeterminateAnimation"];
    return (spinAnimation == nil ? 0 : 1);
}

- (void)setIndeterminate:(NSInteger)indeterminate
{
    if (indeterminate && !self.indeterminate) {
        CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        spinAnimation.byValue = [NSNumber numberWithFloat:indeterminate > 0 ? 2.0f*M_PI : -2.0f*M_PI];
        spinAnimation.duration = self.indeterminateDuration;
        spinAnimation.repeatCount = HUGE_VALF;
        [self.layer addAnimation:spinAnimation forKey:@"indeterminateAnimation"];
    } else {
        [self.layer removeAnimationForKey:@"indeterminateAnimation"];
    }
}

@end
