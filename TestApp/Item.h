//
//  Item.h
//  TestApp
//
//  Created by João on 23/11/15.
//
//

#import <Foundation/Foundation.h>

@interface Item : NSObject <NSCoding>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *mapLat;
@property (nonatomic, strong) NSString *mapLon;
@property (nonatomic, strong) NSString *cityLabel;
@property (nonatomic, strong) NSString *userLabel;
@property (nonatomic, strong) NSString *listLabel;
@property (nonatomic, strong) NSArray *photos;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
