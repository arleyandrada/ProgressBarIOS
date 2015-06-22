/**
 * Commercial : Copyright (c) 2014
 * ArlSoft Tecnologia <contato@arlsoft.com.br>
 *
 * All rights reserved.
 * This is proprietary software.
 * No warranty, explicit or implicit, provided.
 */

#import <UIKit/UIKit.h>

@interface CircularProgressView : UIView

@property(nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property(nonatomic) CGFloat textOpacity UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong) UIColor *trackTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *progressTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic) CGFloat trackOpacity UI_APPEARANCE_SELECTOR;
@property(nonatomic) CGFloat progressOpacity UI_APPEARANCE_SELECTOR;
@property(nonatomic) NSInteger roundedCorners UI_APPEARANCE_SELECTOR; // Can not use BOOL with UI_APPEARANCE_SELECTOR :-(
@property(nonatomic) CGFloat thicknessRatio UI_APPEARANCE_SELECTOR;
@property(nonatomic) CGFloat progress;
@property(copy, nonatomic) NSString *text;

@property(nonatomic) CGFloat indeterminateDuration UI_APPEARANCE_SELECTOR;
@property(nonatomic) NSInteger indeterminate UI_APPEARANCE_SELECTOR; // Can not use BOOL with UI_APPEARANCE_SELECTOR :-(

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
- (void)setText:(NSString*)text;

@end
