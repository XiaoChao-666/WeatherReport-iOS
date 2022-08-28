//
//  BlockUses.h
//  block_and_containers
//
//  Created by ByteDance on 2022/8/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef int (^addBlock)(int a, int b);

@interface BlockUses : NSObject

@property (nonatomic, copy) addBlock myAddBlock;

- (void)blockAsLocalVarialbe;
- (void)blockAsProperty;
- (void)blockAsMethodParameterWithOthersParameter:(addBlock)callBackBlock param1:(int)p1 param2:(int)p2;
- (void)blockAsMethodParameter:(addBlock)callBackBlock;

@end

NS_ASSUME_NONNULL_END
