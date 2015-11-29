//
//  Item.m
//  TestApp
//
//  Created by João on 23/11/15.
//
//

#import "Item.h"
#import <UIKit/UIKit.h>

@implementation Item

@synthesize description;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.identifier = [dictionary valueForKey:@"id"];
        self.url = [dictionary valueForKey:@"url"];
        self.title = [dictionary valueForKey:@"title"];
        self.desc = [dictionary valueForKey:@"description"];
        self.created = [dictionary valueForKey:@"created"];
        self.status = [dictionary valueForKey:@"status"];
        self.mapLat = [dictionary valueForKey:@"map_lat"];
        self.mapLon = [dictionary valueForKey:@"map_lon"];
        self.cityLabel = [dictionary valueForKey:@"city_label"];
        self.userLabel = [dictionary valueForKey:@"user_label"];
        self.listLabel = [dictionary valueForKey:@"list_label"];
        
        if ([dictionary valueForKey:@"photos"]) {
            NSMutableArray *photos = [NSMutableArray new];
            
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"olx\\.pt\\/anuncio\\/(.*)-ID" options:NSRegularExpressionCaseInsensitive error:&error];
            NSTextCheckingResult *match = [regex firstMatchInString:_url options:0 range:NSMakeRange(0, [_url length])];
            NSRange matchRange = [match rangeAtIndex:1];
            
            NSString *slug = [_url substringWithRange:matchRange];
            NSString *key = [[dictionary valueForKeyPath:@"photos.riak_key"] stringValue];
            
            for (NSDictionary *photo in [dictionary valueForKeyPath:@"photos.data"]) {
                NSString *slot = [[photo valueForKeyPath:@"slot_id"] stringValue];
                NSString *width = [[photo valueForKeyPath:@"w"] stringValue];
                NSString *height = [[photo valueForKeyPath:@"h"] stringValue];
                NSString *imagePath = [self imagePathForKey:key
                                                       slot:slot
                                                      width:width
                                                     height:height
                                                       slug:slug];
                [photos addObject:imagePath];
            }
            
            self.photos = photos;
        }
    }
    return self;
}

- (NSString *)imagePathForKey:(NSString *)key slot:(NSString *)slot width:(NSString *)width height:(NSString *)height slug:(NSString *)slug
{
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Sources" ofType: @"plist"];
    NSDictionary *sources = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *imagePath = [sources objectForKey:@"imagesURL"];
    
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"KEY" withString:key];
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"SLOT" withString:slot];
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"WIDTH" withString:width];
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"HEIGHT" withString:height];
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"SLUG" withString:slug];

    return imagePath;
}

#pragma mark NSCoding

#define kIdentifierKey      @"Identifier"
#define kUrlKey             @"Url"
#define kTitleKey           @"Title"
#define kDescriptionKey     @"Description"
#define kCreatedKey         @"Created"
#define kStatusKey          @"Status"
#define kMapLatKey          @"MapLat"
#define kMapLonKey          @"MapLon"
#define kCityLabelKey       @"CityLabel"
#define kUserLabelKey       @"UserLabel"
#define kListLabelKey       @"ListLabel"
#define kPhotosKey          @"Photos"

- (void)encodeWithCoder:(NSCoder *)aCoder;
{
    [aCoder encodeObject:_identifier forKey:kIdentifierKey];
    [aCoder encodeObject:_url forKey:kUrlKey];
    [aCoder encodeObject:_title forKey:kTitleKey];
    [aCoder encodeObject:_desc forKey:kDescriptionKey];
    [aCoder encodeObject:_created forKey:kCreatedKey];
    [aCoder encodeObject:_status forKey:kStatusKey];
    [aCoder encodeObject:_mapLat forKey:kMapLatKey];
    [aCoder encodeObject:_mapLon forKey:kMapLonKey];
    [aCoder encodeObject:_cityLabel forKey:kCityLabelKey];
    [aCoder encodeObject:_userLabel forKey:kUserLabelKey];
    [aCoder encodeObject:_listLabel forKey:kListLabelKey];
    [aCoder encodeObject:_photos forKey:kPhotosKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.identifier = [aDecoder decodeObjectForKey:kIdentifierKey];
        self.url = [aDecoder decodeObjectForKey:kUrlKey];
        self.title = [aDecoder decodeObjectForKey:kTitleKey];
        self.desc = [aDecoder decodeObjectForKey:kDescriptionKey];
        self.created = [aDecoder decodeObjectForKey:kCreatedKey];
        self.status = [aDecoder decodeObjectForKey:kStatusKey];
        self.mapLat = [aDecoder decodeObjectForKey:kMapLatKey];
        self.mapLon = [aDecoder decodeObjectForKey:kMapLonKey];
        self.cityLabel = [aDecoder decodeObjectForKey:kCityLabelKey];
        self.userLabel = [aDecoder decodeObjectForKey:kUserLabelKey];
        self.listLabel = [aDecoder decodeObjectForKey:kListLabelKey];
        self.photos = [aDecoder decodeObjectForKey:kPhotosKey];
    }
    return self;
}

@end
