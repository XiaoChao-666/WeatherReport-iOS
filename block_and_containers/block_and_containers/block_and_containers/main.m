//
//  main.m
//  block_and_containers
//
//  Created by ByteDance on 2022/8/23.
//

#import <Foundation/Foundation.h>
#import "BlockUses.h"
#import "ContainerUses.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BlockUses *myBlock = [[BlockUses alloc] init];
        [myBlock blockAsLocalVarialbe]; //block作为本地变量
        [myBlock blockAsProperty]; //block作为Property
        [myBlock blockAsMethodParameterWithOthersParameter:^int(int a, int b) //block作为参数（带其他参数）
         {
            return a + b;
        } param1:1 param2:2];
        [myBlock blockAsMethodParameter:^int(int a, int b) //block作为参数
         {
            return a + b;
        }];
        
        ContainerUses *myContainer = [[ContainerUses alloc] init];
        [myContainer arrayUses];
        [myContainer mutableArrayUses];
        [myContainer setUses];
        [myContainer mutableSetUses];
        [myContainer dicUses];
        [myContainer mutableDicUses];
    }
    return 0;
}



