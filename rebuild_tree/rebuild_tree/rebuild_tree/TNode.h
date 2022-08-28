//
//  TNode.h
//  rebuild_tree
//
//  Created by ByteDance on 2022/8/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TNode *leftNode;
@property (nonatomic, strong) TNode *rightNode;


@end

NS_ASSUME_NONNULL_END
