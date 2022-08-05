//
//  AppDelegate.h
//  pro1
//
//  Created by ByteDance on 2022/6/22.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) UIWindow * window;

- (void)saveContext;


@end

