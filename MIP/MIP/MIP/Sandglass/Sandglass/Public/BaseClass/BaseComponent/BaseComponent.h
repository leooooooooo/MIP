//
//  BaseComponent.h
//  MIP
//
//  Created by Sea on 13-9-4.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "AbstractComponent.h"

@interface BaseComponent : AbstractComponent



/*!
 @function
 @abstract      使用组件控制器基类初始化功能组件
 
 @param         composite              需要控制的控制器
 
 @result        组件实例
 */
- (id)initWithComposite:(id)composite;

@end
