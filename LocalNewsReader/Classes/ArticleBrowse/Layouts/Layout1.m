//
//  Layout1.m
//  Layouts
//
//  Created by Manikandan K on 12/03/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import "Layout1.h"
#import "UIViewExtention.h"
#import <QuartzCore/QuartzCore.h>

@implementation Layout1

@synthesize view1;
@synthesize view2;
@synthesize view3;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initalizeViews:(NSDictionary*)viewCollectionDictonary {
    
    view1 = (UIViewExtention*)[viewCollectionDictonary objectForKey:@"view1"];
    [view1 setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:view1];
    
    view2 = (UIViewExtention*)[viewCollectionDictonary objectForKey:@"view2"];
    [view2 setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:view2];
    
    view3 = (UIViewExtention*)[viewCollectionDictonary objectForKey:@"view3"];
    [view3 setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:view3];
}

-(void)rotate:(UIInterfaceOrientation)orientation animation:(BOOL)animation {
    
    [view1 setBackgroundColor:[UIColor whiteColor]];
	[view2 setBackgroundColor:[UIColor whiteColor]];
	[view3 setBackgroundColor:[UIColor whiteColor]];
    
	
	/*view1.layer.borderWidth=0.6f;
     view2.layer.borderWidth=0.6f;
     view3.layer.borderWidth=0.6f;
     view4.layer.borderWidth=0.6f;
     view5.layer.borderWidth=0.6f;
     
     UIColor *color1=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
     [view1.layer setBorderColor:color1.CGColor];
     [view2.layer setBorderColor:color1.CGColor];
     [view3.layer setBorderColor:color1.CGColor];
     [view4.layer setBorderColor:color1.CGColor];
     [view5.layer setBorderColor:color1.CGColor];*/
    
	
	for (UIView* myview in [self subviews]) {
		if ([myview isKindOfClass:[UIViewExtention class]]) {
			if (self.isFullScreen) {
				if (!((UIViewExtention*)myview).isFullScreen) {
					[((UIViewExtention*)myview) setAlpha:0];
				}
			}else {
				[((UIViewExtention*)myview) setAlpha:1];
			}
		}
	}
	
	if (animation) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.50];
	}
    
	if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
		if (view1 != nil) {
            int y = 2;
			[view1 setFrame:CGRectMake(0, y, super.frame.size.width, (super.frame.size.height/2)-GAP)];
            
            y = (super.frame.size.height/2)+GAP;
            [view2 setFrame:CGRectMake(0, y, super.frame.size.width /2, (super.frame.size.height/2)-GAP)];
            [view3 setFrame:CGRectMake(view2.frame.origin.x+view2.frame.size.width+GAP, y, (super.frame.size.width /2)-GAP, (super.frame.size.height/2)-GAP)];
            
		}
	}else {
		if (view1 != nil) {
			
            int y = 2;
			[view1 setFrame:CGRectMake(0, y, super.frame.size.width/3, (super.frame.size.height)-GAP)];
            [view2 setFrame:CGRectMake(view1.frame.origin.x+view1.frame.size.width+GAP, y, (super.frame.size.width/3)-GAP, super.frame.size.height-GAP)];
            [view3 setFrame:CGRectMake(view2.frame.origin.x+view2.frame.size.width+GAP, y, (super.frame.size.width/3)-GAP, super.frame.size.height-GAP)];
            
		}
    }
    
    if (animation) {
        
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];
		[UIView commitAnimations];
        
	}else {
        
		for (UIView* myview in [self subviews]) {
			if ([myview isKindOfClass:[UIViewExtention class]]) {
				[((UIViewExtention*)myview) setAlpha:1];
			}
		}
    }
    
    for (UIView* myview in [self subviews]) {
		if ([myview isKindOfClass:[UIViewExtention class]]) {
			[((UIViewExtention*)myview) rotate:orientation animation:YES];
		}
	}
}

- (void)animationEnd:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context {
    
    for (UIView* myview in [self subviews]) {
		if ([myview isKindOfClass:[UIViewExtention class]]) {
			[((UIViewExtention*)myview) setAlpha:1];
		}
	}
    
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

