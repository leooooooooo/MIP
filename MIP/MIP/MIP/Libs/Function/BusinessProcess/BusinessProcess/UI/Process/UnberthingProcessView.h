//
//  UnberthingProcessView.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/05/23.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BaseView.h"

@protocol UnberthingProcessDelegate <NSObject>

- (void) planCompleteClick;

- (void) leaveBerthingClick:(NSString *)leaveTime;

- (void) moveBerthingClick:(NSString *)berthTime withBerthId:(NSString *)berthId andBerthPos:(NSString *)berthPos andCompId:(NSString *)companyId;

@end

@interface UnberthingProcessView : BaseView

@property (nonatomic, assign) id<UnberthingProcessDelegate> delegate;

@property (nonatomic, retain) NSString *planMoveBerthTime;
@property (nonatomic, retain) NSString *planMoveBerthNo;

@property (nonatomic, retain) NSString *curBerth;

@property (nonatomic, retain) NSArray *berthNameList;
@property (nonatomic, retain) NSArray *berthPosList;

@property (nonatomic, retain) NSArray *berthNameValueList;
@property (nonatomic, retain) NSArray *berthPosValueList;

@property (nonatomic, retain) NSArray *berthComList;
@property (nonatomic, retain) NSArray *berthComValueList;

@end
