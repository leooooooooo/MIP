//
//  BottomBarView.h
//  Sandglass
//
//  Created by kangqijun on 14-4-15.
//
//

#import <UIKit/UIKit.h>
#import "BottomItemView.h"

@protocol BottomBarViewDelegate <NSObject>

- (void)selectOperate:(id)sender;

@end

typedef enum
{
    operateType_nextPage = 0,
    operateType_lastPage,
    operateType_help,
    operateType_rotate,
    operateType_checkAccessory
    
}BottomBarType;

@interface BottomBarView : UIView
{
    NSArray                  *imageNameArr;
    NSArray                  *imageNameHLArr;
    NSMutableArray           *itemViewArr;
    UIImageView              *bgImageView;
    
    id<BottomBarViewDelegate> barDelegate;
    
    BOOL                      fourTab;
}

@property (assign, nonatomic) id<BottomBarViewDelegate> barDelegate;

@property (assign, nonatomic) BOOL                      fourTab;

- (void)loadBottomItemDataHasAccessory:(BOOL)has;

@end
