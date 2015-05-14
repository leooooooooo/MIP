//
//  OutwardProcessView.h
//  BusinessProcess
//
//  Created by mengxianglei on 14-5-22.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BaseView.h"
#import "InsetTextField.h"

@protocol  OutwardProcessViewDelegate<NSObject>

- (void) planCompleteClickAction;
- (void) shipLeaveClickAction:(NSString *)remark andLeadTime:(NSString *)leadTime andLeaveTime:(NSString *)leaveTime;

@end


@interface OutwardProcessView : BaseView<UITextFieldDelegate>
{
    __weak id<OutwardProcessViewDelegate> m_delegate;
}
@property (nonatomic, weak) id<OutwardProcessViewDelegate> delegate;

@property (nonatomic, retain) NSString *planEnterPortTime;
@property (nonatomic, retain) NSString *planLeavePortTime;

@end
