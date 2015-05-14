//
//  WeiboButton.h
//  Main
//
//  Created by lu_sicong on 2014/05/10.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "MessageButton.h"

@interface WeiboButton : MessageButton
{
    NSArray *m_newsArr;
}

@property (nonatomic, retain) NSArray *newsArr;

@end
