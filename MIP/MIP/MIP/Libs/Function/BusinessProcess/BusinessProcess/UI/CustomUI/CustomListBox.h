//
//  CustomListBox.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/08.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListBoxSelectedDelegate <NSObject>

- (void) selectedItemWithIndex : (NSInteger)index andTag : (NSInteger) tag;

@end

@interface CustomListBox : UIButton
{
    NSArray *m_itemList;
    NSArray *m_valueList;
    
    NSString *m_selectedItem;
    NSString *m_selectedValue;
    
    NSInteger m_maxRowCount;
    
    id <ListBoxSelectedDelegate> m_delegate;
}

@property (nonatomic, retain) NSString *selectedItem;
@property (nonatomic, retain) NSString *selectedValue;

@property (nonatomic, assign) NSInteger maxRowCount;

@property (nonatomic, assign) id <ListBoxSelectedDelegate> delegate;

- (void) bindingDataSource : (NSArray *)itemList;

- (void) bindingDataValue : (NSArray *)valueList;

@end
