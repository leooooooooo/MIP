/* 
 * Copyright (c) 2009 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>

enum {
  KalTileTypeRegular   = 0,
  KalTileTypeAdjacent  = 1 << 0,
  KalTileTypeToday     = 1 << 1,
};
typedef char KalTileType;

@class KalDate;

@interface KalTileView : UIView
{
    
    UILabel  *monthLabel;             //月份
    UIImageView  *scheduleImage;         //日程安排
    UILabel *dateLabel;                  //日期
    UIImageView *todayImage;            //今日
    UILabel  *monthChinese;            //月份
    BOOL  isSelected;
    KalDate *date;
    KalDate *mainDate;
    BOOL scheduleState;           //日程安排状态
  CGPoint origin;
  struct {
    unsigned int selected : 1;
    unsigned int highlighted : 1;
    unsigned int marked : 1;
    unsigned int type : 2;
  } flags;
}
@property (nonatomic)BOOL scheduleState; 
@property (nonatomic) NSUInteger numWeeks;
@property (nonatomic,retain)UILabel  *monthLabel;
@property (nonatomic,retain)UIImageView  *scheduleImage;
@property (nonatomic,retain)UILabel *dateLabel;
@property (nonatomic,retain)UIImageView *todayImage;
@property (nonatomic,assign) BOOL  isSelected;
@property (nonatomic,retain)UILabel  *monthChinese;
@property (nonatomic, retain) KalDate *date;
@property (nonatomic, retain) KalDate *mainDate;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;
@property (nonatomic, getter=isSelected) BOOL selected;
@property (nonatomic, getter=isMarked) BOOL marked;
@property (nonatomic) KalTileType type;

- (void)resetState;
- (BOOL)isToday;
- (BOOL)belongsToAdjacentMonth;
-(void)updateTheDateView:(KalTileView *)dateView ;
-(void)resumeTheView;
-(void)tileBackgroundColor:(KalTileView*)view;
@end
