//
//  Layout1.h
//  Layouts
//
//  Created by Manikandan K on 12/03/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LayoutViewExtention.h"
@class UIViewExtention;

/** 3 Articles **/
@interface Layout1 : LayoutViewExtention {
    UIViewExtention* view1;
    UIViewExtention* view2;
    UIViewExtention* view3;
}
@property (nonatomic) UIViewExtention* view1;
@property (nonatomic) UIViewExtention* view2;
@property (nonatomic) UIViewExtention* view3;

@end