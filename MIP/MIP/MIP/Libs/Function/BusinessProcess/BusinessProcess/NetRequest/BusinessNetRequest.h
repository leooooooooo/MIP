//
//  BusinessNetRequest.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/03.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "MIPNetUniformInterface.h"

@interface BusinessNetRequest : NetUniformInterface

- (void)requestForNextModuleList;

- (void)requestForLargeCommissionWithShipInfoList;
- (void)requestForLargeCommissionWithNonShipInfoList;

- (void)requestForBerthingProcessInfoList;
- (void)requestForBerthingProcessInfoDetail;

- (void)requestForJobProcessInfoList;
- (void)requestForJobProcessInfoDetail;

- (void)requestForUnberthingProcessInfoList;
- (void)requestForUnberthingProcessInfoDetail;

- (void)requestForOutwardProcessInfoList;
- (void)requestForOutwardProcessInfoDetail;

- (void)requestForBerthList;

- (void)requestForBerthPosList;

- (void)requestForJobCompanyList;

- (void)requestForAuditShipJob;

- (void)requestForUndoAuditShipJob;

- (void)requestForAuditNonShipJob;

- (void)requestForUnAuditNonShipJob;

- (void)requestForSaveBerthingPlanComplete;

- (void)requestForSaveShipBerthing;

- (void)requestForSaveLeavePlanComplete;

- (void)requestForSaveShipLeave;

- (void)requestForSaveShiftingPlanComplete;

- (void)requestForSaveShipLeaveBerth;

- (void)requestForSaveShipShiftBerth;

- (void) requestForSaveMarginValue;

- (void) requestForConfirmAssessment;

- (void) requestForSaveUnloadStartTime;

- (void) requestForSaveUnloadEndTime;

- (void) requestForSaveloadStartTime;

- (void) requestForSaveloadEndTime;

- (void) requestForSaveErrorHandling;

- (void) requestForSaveNonLoadUnloadShip;

@end
