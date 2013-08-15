//
//  LayoutViewExtention.h
//  Layouts
//
//  Created by Manikandan K on 12/03/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GAP 2

@interface LayoutViewExtention : UIView {
    
    UIInterfaceOrientation currrentInterfaceOrientation;
    BOOL isFullScreen;
    
}


@property (nonatomic,readonly) UIInterfaceOrientation currrentInterfaceOrientation;
@property (nonatomic,assign) BOOL isFullScreen;


-(void)initalizeViews:(NSDictionary*)viewCollectionDictonary;
-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation;
-(void)reAdjustLayout;


@end
