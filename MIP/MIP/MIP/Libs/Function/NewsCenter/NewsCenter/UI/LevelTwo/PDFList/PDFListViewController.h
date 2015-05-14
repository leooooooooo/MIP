//
//  PDFListViewController.h
//  NewsCenter
//
//  Created by kangqijun on 14-3-18.
//
//

#import <UIKit/UIKit.h>
#import "PDFListView.h"
#import "NewsCenterPDF.h"

@protocol PDFListViewDelegate <NSObject>

- (void)lookAtThisPDF:(NewsCenterPDF *)pdf;

@end

@interface PDFListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    PDFListView     *pdfListView;
    UITableView     *m_tableView;
    
    id <PDFListViewDelegate> pdfListDelegate;
}

@property (assign, nonatomic) id <PDFListViewDelegate> pdfListDelegate;

- (id)initWithPDFList:(NSMutableArray *)arr;

@end
