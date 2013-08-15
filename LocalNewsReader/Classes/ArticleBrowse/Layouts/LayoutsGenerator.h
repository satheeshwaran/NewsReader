//
//  LayoutsGenerator.h
//  NumberCrunch
//
//  Created by Manikandan R on 3/15/13.
//  Copyright (c) 2013 Manikandan R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LayoutsGenerator : NSObject
- (id)initWithArticlesCount:(int)articlesCount;
- (NSArray *)doNumberCrunch;
@end
