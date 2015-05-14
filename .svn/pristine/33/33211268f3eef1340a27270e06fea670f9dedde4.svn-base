//
//  DaoBase.h
//  MyFirstApp
//
//  Created by dextrys on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FMDatabase.h" 
//@class FMDatabase;

@interface DaoBase : NSObject {
	//FMDatabase *db;
}

//@property (nonatomic, retain) FMDatabase *db;

//-(NSString *)setTable:(NSString *)sql;
//- (BOOL)insert:(NSString *)sql;
//- (BOOL)update:(NSString *)sql;
//- (BOOL)deleteResult:(NSString *)sql;
-(BOOL)executeSQL:(FMDatabase *) fmDB SqlString:(NSString *)sql,...;
- (BOOL)executeSQL:(NSString *)sql,...;
- (FMResultSet *)selectResult:(NSString *)sql;

@end
