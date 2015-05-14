//
//  CommonlyUsedToolView.h
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-26.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BaseView.h"

@interface CommonlyUsedToolView : BaseView{
    UIImageView     *lineView1;
    UIImageView     *lineView2;
    UILabel         *titleLab;
    UIButton        *closeBtn;     //关闭按钮
    
}
@property (nonatomic, retain, readonly) UILabel         *titleLab;
@property (nonatomic, retain, readonly) UIButton        *closeBtn;

@end
