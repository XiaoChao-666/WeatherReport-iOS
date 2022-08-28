//
//  MySort.m
//  sort_realize
//
//  Created by ByteDance on 2022/8/24.
//

#import "MySort.h"

@implementation MySort

- (void)selectSort:(NSMutableArray *)arr {
    NSInteger n = [arr count];
    
    for(NSInteger i = 0 ; i < n; ++i) {
        NSInteger minPos = i;
        for(NSInteger j = i + 1; j < n; ++j) {
            if([arr[j] intValue] < [arr[minPos] intValue]) {
                minPos = j;
            }
        }
        [arr exchangeObjectAtIndex:i withObjectAtIndex:minPos];
    
    }
}


- (void)quicktSort:(NSMutableArray *)arr left:(NSInteger)l right:(NSInteger)r {
    if (l >= r) {
        return ;
    }
    NSInteger i = l;
    NSInteger j = r;
    NSInteger p = [[arr objectAtIndex:i] integerValue];

    while (i < j) {
        while (i < j && [arr[j] integerValue] >= p) {
            j--;
        }
        arr[i] = arr[j];
        while (i < j && [arr[i] integerValue] <= p) {
            i++;
        }
        arr[j] = arr[i];

    }
    arr[i] = @(p);
    [self quicktSort:arr left:l right:i - 1];
    [self quicktSort:arr left:i + 1 right:r];
}

- (void)heapSort:(NSMutableArray *)arr {
    for (NSInteger i = [arr count] / 2 - 1; i >= 0; i--) {
        [self p_maxHeapifyWithNumbers:arr start:i end:[arr count] - 1];
    }

    for (NSInteger i = [arr count] - 1; i > 0; i--) {
        [arr exchangeObjectAtIndex:0 withObjectAtIndex:i];
        [self p_maxHeapifyWithNumbers:arr start:0 end:i-1];
    }
}

- (void)p_maxHeapifyWithNumbers:(NSMutableArray *)arr start:(NSInteger)start end:(NSInteger)end {
    NSInteger dad = start;
    NSInteger son = dad * 2 + 1;
    while (son <= end) {
        if (son + 1 <= end && [arr[son] intValue] < [arr[son + 1] intValue]) {
            son++;
        }
        if ([arr[dad] intValue] > [arr[son] intValue]) {
            return;
        }else {
            [arr exchangeObjectAtIndex:son withObjectAtIndex:dad];
            dad = son;
            son = dad * 2 + 1;
        }
    }
}
@end
