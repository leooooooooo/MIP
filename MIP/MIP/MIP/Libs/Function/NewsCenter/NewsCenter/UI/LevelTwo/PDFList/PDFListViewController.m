//
//  PDFListViewController.m
//  NewsCenter
//
//  Created by kangqijun on 14-3-18.
//
//

#import "PDFListViewController.h"

@interface PDFListViewController ()
{
    NSMutableArray   *pdfArr;
}

@property (retain, nonatomic) NSMutableArray   *pdfArr;

@end

@implementation PDFListViewController

@synthesize pdfArr;

@synthesize pdfListDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPDFList:(NSMutableArray *)arr
{
    self = [super init];
    
    if (self) {
        
        self.pdfArr = arr;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.6;
    [self.view addSubview:bgView];
    [bgView release];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 340)];
    contentView.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 340)];
    bgImageView.image = [UIImage imageNamed:@"upgrade_box.png" imageBundle:loginBundle];
    [contentView addSubview:bgImageView];
    [bgImageView release];
    
    //描述信息
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, contentView.frame.size.width, 50)];
    titleLab.text = @"附件列表";
    titleLab.font = [UIFont boldSystemFontOfSize:22];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:titleLab];
    [titleLab release];
    
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 80, 280, 170) style:UITableViewStylePlain];
    m_tableView.backgroundColor = [UIColor clearColor];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
#ifdef __IPHONE_7_0
    m_tableView.separatorInset = UIEdgeInsetsZero;
#endif
    
    [contentView addSubview:m_tableView];
    
    [self.view addSubview:contentView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(110, 255, 100, 35);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:loginBundle] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:backButton];
    
    [self exChangeOut:contentView dur:0.3];
    
    [contentView release];
}

-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    
    //animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}

- (void)backEvent
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.pdfArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:178.0/255 green:216.0/255 blue:254.0/255 alpha:1.0];
    }
    
    cell.textLabel.textColor = [UIColor colorWithHex:@"3b6f92"];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NewsCenterPDF *pdf = [self.pdfArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = pdf.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCenterPDF *pdf = [self.pdfArr objectAtIndex:indexPath.row];
    
    if (pdfListDelegate)
    {
        [pdfListDelegate lookAtThisPDF:pdf];
    }
    
    [self backEvent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
