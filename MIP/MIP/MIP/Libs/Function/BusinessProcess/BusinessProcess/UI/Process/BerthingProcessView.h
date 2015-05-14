//
//  BerthingProcessView.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/04.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BaseView.h"

@protocol BerthingProcessDelegate <NSObject>

- (void) planCompleteClick;

- (void) berthingClick:(NSString *)berthTime withBerthId:(NSString *)berthId andBerthPos:(NSString *)berthPos andCompId:(NSString *)companyId andRemark:(NSString *)remark;

@end

@interface BerthingProcessView : BaseView<UITextFieldDelegate>

@property (nonatomic, assign) id<BerthingProcessDelegate> delegate;

@property (nonatomic, retain) NSString *planEnterPortTime;
@property (nonatomic, retain) NSString *planLeavePortTime;

@property (nonatomic, retain) NSArray *berthNameList;
@property (nonatomic, retain) NSArray *berthPosList;

@property (nonatomic, retain) NSArray *berthNameValueList;
@property (nonatomic, retain) NSArray *berthPosValueList;

@property (nonatomic, retain) NSArray *berthComList;
@property (nonatomic, retain) NSArray *berthComValueList;

@end
