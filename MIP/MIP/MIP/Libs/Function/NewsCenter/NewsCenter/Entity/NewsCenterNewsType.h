//
//  NewsCenterNewsType.h
//  NewsCenter
//
//  Created by wanghao on 14-3-18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewsCenterNewsType : NSManagedObject

@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * userid;

@end
