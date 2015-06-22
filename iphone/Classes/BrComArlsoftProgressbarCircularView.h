/**
 * Commercial : Copyright (c) 2014
 * ArlSoft Tecnologia <contato@arlsoft.com.br>
 *
 * All rights reserved.
 * This is proprietary software.
 * No warranty, explicit or implicit, provided.
 */

#import "TiBase.h"
#import "TiUIView.h"
#import "CircularProgressView.h"

@interface BrComArlsoftProgressbarCircularView : TiUIView {

    CircularProgressView* progressView;
}

@property (nonatomic, assign) BOOL animatedProgress;

@end