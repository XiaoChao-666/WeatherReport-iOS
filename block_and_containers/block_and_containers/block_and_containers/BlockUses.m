//
//  BlockUses.m
//  block_and_containers
//
//  Created by ByteDance on 2022/8/23.
//

#import "BlockUses.h"

@implementation BlockUses

- (void)blockAsLocalVarialbe {
    int (^add)(int,int) = ^(int a, int b){
        return a + b;
    };
    NSLog(@"blockAsLocalVarialbe output : %d", add(1, 2));
}

- (void)blockAsProperty {
    self.myAddBlock = ^(int a, int b) {
        return a + b;
    };
    NSLog(@"blockAsProperty output : %d", self.myAddBlock(1, 2));
}

- (void)blockAsMethodParameterWithOthersParameter:(addBlock)callBackBlock param1:(int)p1 param2:(int)p2 {
    NSLog(@"blockAsMethodParameterWithOthersParameter output : %d", callBackBlock(p1,p2));
}

- (void)blockAsMethodParameter:(addBlock)callBackBlock {
    NSLog(@"blockAsMethodParameter output : %d", callBackBlock(1,2));
}
@end
