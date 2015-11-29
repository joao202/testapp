//
//  RequestManager.m
//  TestApp
//
//  Created by João on 23/11/15.
//
//

#import "RequestManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "Item.h"

#define kDataFile @"kDataFile"
#define kDataKey @"kDataKey"

@implementation RequestManager

+ (void)fetchDataWithSuccessBlock:(void (^)(NSArray *items))successBlock failureBlock:(void (^)(NSError *error))failureBlock forceUpdate:(BOOL)forceUpdate
{
    if (!forceUpdate) {
        NSArray *data = [RequestManager readData];
        if (data && [data isKindOfClass:[NSArray class]]) {
            successBlock(data);
            return;
        }
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Sources" ofType: @"plist"];
    NSDictionary *sources = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *url = [sources objectForKey:@"serviceURL"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSArray *data = [(NSDictionary *)responseObject valueForKey:@"ads"];
        NSMutableArray *items = [NSMutableArray new];
        
        for (NSDictionary *dict in data) {
            Item *item = [[Item alloc] initWithDictionary:dict];
            [items addObject:item];
        }
        
        [RequestManager saveData:items];
        
        if (successBlock) {
            successBlock(items);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (NSString *)dataFilePath
{
    NSString *filePath = nil;
    
    if (kDataFile != nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        filePath = [[paths firstObject] stringByAppendingPathComponent:kDataFile];
    }
    
    return filePath;
}

+ (NSArray *)readData
{
    NSMutableDictionary *dict;
    @try {
        dict = [NSKeyedUnarchiver unarchiveObjectWithFile:[RequestManager dataFilePath]];
    }
    @catch (NSException *exception) {
        dict = nil;
    }
    
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        dict = [[NSMutableDictionary alloc] init];
    }
    
    NSArray *data = (NSArray *)[dict valueForKey:kDataKey];
    return data;
}

+ (void)saveData:(NSArray *)data
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:data forKey:kDataKey];
    [NSKeyedArchiver archiveRootObject:dict toFile:[self dataFilePath]];
}


@end
