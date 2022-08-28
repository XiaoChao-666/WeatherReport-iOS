//
//  MySort.h
//  sort_realize
//
//  Created by ByteDance on 2022/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySort : NSObject

- (void)selectSort:(NSMutableArray *)arr;
- (void)quicktSort:(NSMutableArray *)arr left:(NSInteger)l right:(NSInteger)r;
- (void)heapSort:(NSMutableArray *)arr;

@end

NS_ASSUME_NONNULL_END
