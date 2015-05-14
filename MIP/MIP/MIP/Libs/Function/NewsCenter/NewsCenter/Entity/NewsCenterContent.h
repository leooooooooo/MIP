//
//  NewsCenterContent.h
//  NewsCenter
//
//  Created by wanghao on 14-3-19.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewsCenterContent : NSManagedObject

@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * source;

@end
