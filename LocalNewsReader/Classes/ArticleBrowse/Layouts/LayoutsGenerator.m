//
//  LayoutsGenerator.m
//  NumberCrunch
//
//  Created by Manikandan R on 3/15/13.
//  Copyright (c) 2013 Manikandan R. All rights reserved.
//

#import "LayoutsGenerator.h"
#import <CoreText/CoreText.h>

@interface LayoutsGenerator () {
    
    int testNo;
    int numberof6s;
    int numberof5s;
    int numberof4s;
    int numberof3s;
}

@property (nonatomic,strong) NSArray *layoutArray;

@end

@implementation LayoutsGenerator

- (id)initWithArticlesCount:(int)articlesCount
{
    self=[super init];
    if (self) {
        testNo=articlesCount;
        self.layoutArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)exceptionScenarios
{
    numberof5s=0;
    numberof6s=0;
    numberof4s=0;
    numberof3s=0;
    if (testNo==7) {
        numberof5s=1;
        return;
    }
    else if (testNo==8){
        numberof5s=1;
        numberof3s=1;
        return;
    }
    else if (testNo==9){
        numberof5s=1;
        numberof4s=1;
        return;
    }
    else if (testNo==12){
        numberof6s=2;
        return;
    }
}

- (NSArray *)doNumberCrunch
{
    NSArray *exceptions = [NSArray arrayWithObjects:@"7",@"8",@"9",@"12", nil];
    if ([exceptions containsObject:[NSString stringWithFormat:@"%d",testNo]])
        [self exceptionScenarios];
    else {
        int remainingNo = [self divisionLogic:testNo];
        
        if (remainingNo==5)
            numberof5s++;
        else if (remainingNo==6)
            numberof6s++;
        else if (remainingNo==3)
            numberof3s++;
        else if (remainingNo==4)
            numberof4s++;
        else if(remainingNo<=2)
            [self redoDivisionLogicByReducingBaseValues];
        else if (remainingNo>=7)
            [self redoDivisionLogicByIncreasingBaseValues];
    }
    NSString *str=[self add3s];
    NSString *str1=[self add4s];
    NSString *sendThisString=nil;
    if (str)
        sendThisString=str;
    if (str1)
        sendThisString=str1;
    NSString *str2=[self add5s:sendThisString];
    NSString *str3=[self add6s:str2];
    NSMutableString *string =[[NSMutableString alloc]initWithString:str3];
    [string deleteCharactersInRange:NSMakeRange([string length]-1, 1)];
    self.layoutArray=[string componentsSeparatedByString:@","];
    return self.layoutArray;
}

- (NSString *)add3s
{
    if (numberof3s==1)
        return @"3,";
    else
        return nil;
}

- (NSString *)add4s
{
    if (numberof4s==1)
        return @"4,";
    else
        return nil;
}

- (NSString *)add5s:(NSString *)input
{
    if (input) {
        NSMutableString *tempString = [[NSMutableString alloc]initWithString:input];
        for (int i=0;i<numberof5s;i++)
            [tempString appendString:@"5,"];
        return tempString;
    }
    else{
        NSMutableString *tempString = [[NSMutableString alloc]init];
        for (int i=0;i<numberof5s;i++)
            [tempString appendString:@"5,"];
        return tempString;
    }
    return nil;
}

- (NSString *)add6s:(NSString *)input
{
    NSMutableString *str = [[NSMutableString alloc]initWithString:input];
    for (int i=0;i<numberof6s;i++)
        [str appendString:@"6,"];
    return str;
}


- (int)divisionLogic:(int)targetNo
{
    numberof5s = floor((targetNo/5)/2);
    numberof6s = floor((targetNo/6)/2);
    int sum = numberof5s*5 + numberof6s*6;
    int remainingNo = targetNo - sum;
    return remainingNo;
}

- (void)redoDivisionLogicByReducingBaseValues
{
    numberof6s--;
    numberof5s++;
    int rem = testNo - (5*numberof5s) - (6*numberof6s);
    if (rem==3)
        numberof3s++;
    else if (rem==4)
        numberof4s++;
    else if (rem>=7)
        [self redoDivisionLogicByIncreasingBaseValues];
    else
        [self redoDivisionLogicByReducingBaseValues];
}

- (void)redoDivisionLogicByIncreasingBaseValues
{
    numberof6s++;
    numberof5s--;
    int rem = testNo - (5*numberof5s) - (6*numberof6s);
    if (rem==3)
        numberof3s++;
    else if (rem==4){
        numberof4s++;
        return;
    }
    else if (rem==5){
        numberof5s++;
        return;
    }
    else if (rem==6){
        numberof6s++;
        return;
    }
    else if(rem<=2)
        [self redoDivisionLogicByReducingBaseValues];
    else if (rem>=7)
        [self redoDivisionLogicByIncreasingBaseValues];

}

@end
