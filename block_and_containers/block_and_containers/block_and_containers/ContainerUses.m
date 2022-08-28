//
//  ContainerUses.m
//  block_and_containers
//
//  Created by ByteDance on 2022/8/23.
//

#import "ContainerUses.h"

@implementation ContainerUses

- (void)arrayUses {
    self.myArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",nil];
    NSLog(@"myarray is %@", self.myArray);
    NSLog(@"myarray[2] is %@", [self.myArray objectAtIndex:2]);
    NSString *searchStr = @"5";
    [self.myArray containsObject:searchStr] ? NSLog(@"myarray contain %@", searchStr) :  NSLog(@"myarray not contain %@", searchStr);
    
}
- (void)mutableArrayUses {
    self.myMutableArray = [NSMutableArray arrayWithArray:self.myArray];
    [self.myMutableArray addObject:@"5"];
    NSLog(@"add 5 ,myMutableArray is %@", self.myMutableArray);
    [self.myMutableArray removeObject:@"2"];
    NSLog(@"remove 2 ,myMutableArray is %@", self.myMutableArray);
}
- (void)setUses {
    self.mySet = [NSSet setWithObjects:@"1",@"2",@"3",nil];
    NSString *searchStr = @"5";
    [self.mySet containsObject:searchStr] ? NSLog(@"mySet contain %@", searchStr) :  NSLog(@"mySet not contain %@", searchStr);
}
- (void)mutableSetUses {
    self.myMutableSet = [NSMutableSet setWithSet:self.mySet];
    [self.myMutableSet addObject:@"5"];
    NSString *searchStr = @"5";
    [self.myMutableSet containsObject:searchStr] ? NSLog(@"myMutableSet contain %@", searchStr) :  NSLog(@"myMutableSet not contain %@", searchStr);
}
- (void)dicUses {
    self.myDic = [NSDictionary dictionaryWithObject:@"value1" forKey:@"key1"];
    NSString *searchStr = @"key1";
    NSString *searchVal = [self.myDic objectForKey:searchStr];
    (searchVal != nil) ? NSLog(@"myDic contain %@, value is %@", searchStr, searchVal) : NSLog(@"myDic not contain %@", searchStr);
}
- (void)mutableDicUses {
    self.myMutableDic = [NSMutableDictionary dictionaryWithDictionary:self.myDic];
    [self.myMutableDic setObject:@"value2" forKey:@"key1"];
    NSString *searchStr = @"key1";
    NSString *searchVal = [self.myMutableDic objectForKey:searchStr];
    searchVal != nil ? NSLog(@"myMutableDic contain %@, value is %@", searchStr, searchVal) : NSLog(@"myMutableDic not contain %@", searchStr);
}

@end
