//
//  CustomPopListView.h
//  Sandglass
//
//  Created by kangqijun on 13-11-5.
//
//

#import <UIKit/UIKit.h>

@protocol CustomPopListViewDelegate <NSObject>

@optional
- (void)removePopListView;

@end

@interface CustomPopListView : UIView
{
    id <CustomPopListViewDelegate> m_delegate;
}

@property (assign, nonatomic) id <CustomPopListViewDelegate> m_delegate;

//添加子视图
- (void)loadContentViewWith:(UIView *)_view withPosionView:(UIView *)_pView;
- (void)loadDatePickerViewWith:(UIView *)_view withPosionView:(UIView *)_pView;

//移出POP视图
- (void)closePopListView;

@end
