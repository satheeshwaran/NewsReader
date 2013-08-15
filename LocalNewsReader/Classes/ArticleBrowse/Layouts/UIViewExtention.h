//
//  UIViewExtention.h
//  Layouts
//
//  Created by Manikandan K on 12/03/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewExtention : UIView {
    
    UIInterfaceOrientation currrentInterfaceOrientation;
    BOOL isFullScreen;
    CGRect originalRect;
    
}

@property (nonatomic,readonly) UIInterfaceOrientation currrentInterfaceOrientation;
@property (nonatomic,assign) BOOL isFullScreen;
@property (nonatomic,assign) CGRect originalRect;

-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation;
-(void)reAdjustLayout;

@end
