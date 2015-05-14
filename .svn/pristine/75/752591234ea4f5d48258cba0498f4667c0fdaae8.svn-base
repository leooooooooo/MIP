//
//  ContentPDFViewController.m
//  NewsCenter
//
//  Created by wanghao on 14-3-19.
//
//

#import "ContentPDFViewController.h"

@interface ContentPDFViewController ()

@end

@implementation ContentPDFViewController
@synthesize contentTextView;

- (void)dealloc{
    [contentTextView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithContent:(NSString *)content
{
	if ((self = [super initWithDocument:nil])) {
        
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 500, 500)];
    [self.view addSubview:contentTextView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
