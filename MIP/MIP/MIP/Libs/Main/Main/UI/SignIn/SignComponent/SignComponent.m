//
//  SignComponent.m
//  Main
//
//  Created by lu_sicong on 2014/03/14.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "SignComponent.h"
#import "MBProgressHUD.h"
#import "SignInViewController.h"


@implementation SignComponent

- (id)initWithComposite:(id)composite {
    
    self = [super initWithComposite:composite];
    
    if (self) {
        signViewCtrl = (SignViewController *)composite;
    }
    
    return self;
    
}

- (void) gpsLocaiton
{
    [MBProgressHUD showHUDAddedTo:[signViewCtrl view] animated:YES];
    [GPSLocation location:self];
}

- (void) locationPoint:(CGPoint)point
{
    [MBProgressHUD hideHUDForView:[signViewCtrl view] animated:YES];
    CLLocation *loction = [[CLLocation alloc] initWithLatitude:point.y longitude:point.x];
    
    NSLog(@"%f,%f,00",loction.coordinate.longitude,loction.coordinate.latitude);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:loction completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error) {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:@"定位失败！"
                                                                delegate:nil
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:@"确定", nil];
             [alertView show];
             [alertView release];

             return;
         }
         
         if (placemarks.count == 0)
         {
             NSLog(@"---no result------");
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:@"定位失败！"
                                                                delegate:nil
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:@"确定", nil];
             [alertView show];
             [alertView release];
             return;
         }
         
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSString *locatedAt = [NSString stringWithFormat:@"%@%@%@", [placemark.addressDictionary valueForKey:@"State"],[placemark.addressDictionary valueForKey:@"Name"],[placemark.addressDictionary valueForKey:@"Street"]];
         
         NSLog(@"I am currently at %@--->%@",locatedAt,placemark.locality);
         
         //if (placemark.locality)
         //{
             [signViewCtrl setLocationPlace:locatedAt];
         //}
         [geocoder release];
         [loction release];
     }];
    //[loction release];
}

- (void)locationWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:[signViewCtrl view] animated:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"定位失败！"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}

@end
