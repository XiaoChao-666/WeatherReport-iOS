//
//  main.m
//  sort_realize
//
//  Created by ByteDance on 2022/8/24.
//

#import <Foundation/Foundation.h>
#import "MySort.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(9), @(6), @(3), @(5), @(2), @(4), @(1), @(8), @(7), @(0), nil];
        MySort *mySort = [[MySort alloc] init];
        NSLog(@"before select sort is %@", arr);
        [mySort selectSort:arr];
        NSLog(@"after select sort is %@", arr);
        
        NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:@(9), @(6), @(3), @(5), @(2), @(4), @(1), @(8), @(7), @(0), nil];
        NSLog(@"before quick sort is %@", arr2);
        [mySort quicktSort:arr2 left:0 right:[arr2 count] - 1];
        NSLog(@"after quick sort is %@", arr2);
        
        NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:@(9), @(6), @(3), @(5), @(2), @(4), @(1), @(8), @(7), @(0), nil];
        NSLog(@"before heap sort is %@", arr3);
        [mySort heapSort:arr3];
        NSLog(@"after heap sort is %@", arr3);
    }
    return 0;
}


