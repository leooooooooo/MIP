/********************************************************************
 Author: li_xiangai
 Class description:NdUncaughtExceptionHandle
 *******************************************************/

#import <Foundation/Foundation.h>

@interface NdUncaughtExceptionHandle : NSObject


/*********************************************************************
 Function description:设置异常回调处理函数
 Parameter: sender
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+ (void)setDefaultHandler;

/*********************************************************************
 Function description:获取异常回调对象
 Parameter: sender
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/

+ (NSUncaughtExceptionHandler*)getHandler;
@end
