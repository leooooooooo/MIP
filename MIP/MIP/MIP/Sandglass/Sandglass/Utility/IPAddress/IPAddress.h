/********************************************************************
 Author: li_xiangai
 Class description:IPAddress
 *******************************************************/
#import <Foundation/Foundation.h>
#include <sys/socket.h>
//for ifaddrs
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#include <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>


#import "getgateway.h"
@interface IPAddress : NSObject
+(NSString *)currentIPAddress;

@end
