//
//  NSString+MD5Encrypt.h
//  MOA
//
//  Created by  on 12-2-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

@interface NSString (md5)

-(NSString *) md5EncryptUsingEncoding:(NSStringEncoding)encoding;

@end
