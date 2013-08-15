//
//  UIImage+LocalNewsAdditions.h
//  upsc
//
//  Created by Satheeshwaran on 8/9/13.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (LocalNewsAdditions)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize;
+(UIImage *)getCircularImageWithColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize;
+ (UIImage *)roundedImageWithImage:(UIImage *)image;

@end
