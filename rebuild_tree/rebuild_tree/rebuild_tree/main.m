//
//  main.m
//  rebuild_tree
//
//  Created by ByteDance on 2022/8/29.
//

#import <Foundation/Foundation.h>
#import "TNode.h"
void getNodeWithPreAndMin(TNode **rootNode, NSArray *arrayPre, NSArray *arrayMin) {
    if ((arrayPre.count == 0) && (arrayMin.count == 0)) {
        return;
    }
    NSNumber *root = arrayPre.firstObject;  // 获取根结点
    TNode *node = [[TNode alloc] init];
    *rootNode = node;
    node.value = [root integerValue];
    __block NSInteger rootIndex = 0;    // 根结点在中序遍历中的位置
    [arrayMin enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj integerValue] == [root integerValue]) {
            rootIndex = idx;
            *stop = YES;
        }
    }];
    NSArray *arrayLeftPre = [arrayPre subarrayWithRange:NSMakeRange(1, rootIndex)];
    NSArray *arrayLeftMin = [arrayMin subarrayWithRange:NSMakeRange(0, rootIndex)];
    TNode *leftNode = nil;
    getNodeWithPreAndMin(&leftNode, arrayLeftPre, arrayLeftMin);
    node.leftNode = leftNode;
    NSArray *arrayRightPre = [arrayPre subarrayWithRange:NSMakeRange(rootIndex + 1, arrayPre.count - rootIndex - 1)];
    NSArray *arrayRightMin = [arrayMin subarrayWithRange:NSMakeRange(rootIndex + 1, arrayMin.count - rootIndex - 1)];
    TNode *rightNode = nil;
    getNodeWithPreAndMin(&rightNode, arrayRightPre, arrayRightMin);
    node.rightNode = rightNode;
}

 

// 打印前序遍历

void printNodePre(TNode *node) {
    if (node) {
        NSLog(@"%ld", node.value);
        printNodePre(node.leftNode);
        printNodePre(node.rightNode);
    }
}

 

// 打印中序遍历

void printNodeMin(TNode *node) {
    if (node) {
        printNodeMin(node.leftNode);
        NSLog(@"%ld", node.value);
        printNodeMin(node.rightNode);
    }
}

 

// 打印后序遍历

void printNodeLater(TNode *node) {
    if (node) {
        printNodeLater(node.leftNode);
        printNodeLater(node.rightNode);
        NSLog(@"%ld", node.value);
    }
}


int main(int argc, const char * argv[]) {
    NSArray *arrayPre = @[@(1), @(2), @(4), @(7), @(3), @(5), @(6), @(8)];
    NSArray *arrayMin = @[@(4), @(7), @(2), @(1), @(5), @(3), @(8), @(6)];
    TNode *rootNode = nil;
    getNodeWithPreAndMin(&rootNode, arrayPre, arrayMin);
    NSLog(@"前序遍历");
    printNodePre(rootNode);
    NSLog(@"中序遍历");
    printNodeMin(rootNode);
    NSLog(@"后序遍历");
    printNodeLater(rootNode);
    
    return 0;
}
