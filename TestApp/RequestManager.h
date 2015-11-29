//
//  RequestManager.h
//  TestApp
//
//  Created by João on 23/11/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RequestManager : NSObject

+ (void)fetchDataWithSuccessBlock:(void (^)(NSArray *items))successBlock failureBlock:(void (^)(NSError *error))failureBlock forceUpdate:(BOOL)forceUpdate;

@end
