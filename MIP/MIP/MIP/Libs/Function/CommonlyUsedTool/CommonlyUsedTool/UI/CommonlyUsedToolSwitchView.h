//
//  CommonlyUsedToolSwitchView.h
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-26.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BaseView.h"

@interface CommonlyUsedToolSwitchView : BaseView{
    UIButton    *webSiteButton;
    UIButton    *noteButton;
    UIButton    *calenderButton;
}

@property (nonatomic, retain, readonly) UIButton    *webSiteButton;
@property (nonatomic, retain, readonly) UIButton    *noteButton;
@property (nonatomic, retain, readonly) UIButton    *calenderButton;

@end
