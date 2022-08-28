//
//  ContainerUses.h
//  block_and_containers
//
//  Created by ByteDance on 2022/8/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContainerUses : NSObject

@property (nonatomic, strong) NSArray<NSString *> *myArray;
@property (nonatomic, strong) NSMutableArray<NSString *> *myMutableArray;

@property (nonatomic, strong) NSSet<NSString *> *mySet;
@property (nonatomic, strong) NSMutableSet<NSString *> *myMutableSet;

@property (nonatomic, strong) NSDictionary *myDic;
@property (nonatomic, strong) NSMutableDictionary *myMutableDic;

- (void)arrayUses;
- (void)mutableArrayUses;
- (void)setUses;
- (void)mutableSetUses;
- (void)dicUses;
- (void)mutableDicUses;

@end

NS_ASSUME_NONNULL_END
