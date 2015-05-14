//
//  ContentPDFViewController.h
//  NewsCenter
//
//  Created by wanghao on 14-3-19.
//
//

#import "PDFToolViewController.h"

@interface ContentPDFViewController : PDFToolViewController{
    UITextView *contentTextView;
}

@property(nonatomic, retain)UITextView *contentTextView;

- (id)initWithContent:(NSString *)content;

@end
