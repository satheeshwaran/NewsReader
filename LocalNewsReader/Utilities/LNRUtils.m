//
//  LNRUtils.m
//  LocalNewsReader
//
//  Created by Admin on 8/19/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import "LNRUtils.h"
#import "TFHpple.h"

@implementation LNRUtils

+ (NSString *)returnTheImageURL: (NSString *)content
{
    
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *parser = [TFHpple hppleWithHTMLData:data];
    
    NSString *xpathQueryString = @"//img";
    NSArray *nodes = [parser searchWithXPathQuery:xpathQueryString];
    NSString *url =nil;
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    
    int i=0;
    for (TFHppleElement *element in nodes)
    {
        i++;
        NSString *src = [element objectForKey:@"src"];
        NSString *widht = [element objectForKey:@"width"];
        NSString *height = [element objectForKey:@"height"];
        if ([[dictionary valueForKey:@"width"] intValue]<[widht intValue] || i==1) {
            if ([height intValue]>100 || [widht intValue]>100) {
                [dictionary setValue:src forKey:@"src"];
                [dictionary setValue:height forKey:@"height"];
                [dictionary setValue:widht forKey:@"width"];
                url= src;
            }
        }
    }
    return url;
}

@end
