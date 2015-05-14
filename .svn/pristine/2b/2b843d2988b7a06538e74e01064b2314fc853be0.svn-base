/********************************************************************
 Author: li_xiangai
 Class description:GPSLocation
 *******************************************************/
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol GPSLocationDelegate<NSObject>


/*********************************************************************
 Function description:GPS定位成功
  output Parameter: point    point.x 表示经度  point.y 表示纬度
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
-(void)locationPoint:(CGPoint)point;

/*********************************************************************
 Function description:GPS定位失败
 output Parameter: error
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
-(void)locationWithError:(NSError *)error;
@end

@interface GPSLocation : NSObject<CLLocationManagerDelegate>

/*********************************************************************
 Function description:开始GPS定位
 Parameter: delegate  设置代理
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(void)location:(id)delegate;   //定位
@end

