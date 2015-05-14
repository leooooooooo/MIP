/********************************************************************
 Author: li_xiangai
 Class description:IPAddress
 *******************************************************/
#import "IPAddress.h"
#import "ASIHTTPRequest.h"



@implementation IPAddress

/*********************************************************************
 Function description:获取wifi的ip地址
 Parameter: nil
 Return value: NSString
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(NSString *)currentIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    NSLog(@"address-1-->%@",address);
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    NSLog(@"address--->%@",address);
    in_addr_t i =inet_addr([address cStringUsingEncoding:NSUTF8StringEncoding]);
    in_addr_t* x =&i;
    char gw_addr[16] = {0};
    getdefaultgateway(x, gw_addr);
    NSString *returnString = [[NSString alloc] initWithFormat:@"%s",gw_addr];
    NSLog(@"returnString--->%@",returnString);
    return [returnString autorelease];
//    return  [NSString stringWithFormat:@"%s",gw_addr];

}

@end
