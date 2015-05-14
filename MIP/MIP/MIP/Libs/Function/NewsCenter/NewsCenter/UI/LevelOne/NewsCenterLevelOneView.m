//
//  NewsCenterLevelOneView.m
//  NewsCenter
//
//  Created by wanghao on 14-3-12.
//
//

#import "NewsCenterLevelOneView.h"

@implementation NewsCenterLevelOneView

@synthesize closeBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 54)];
        navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
        [self addSubview:navBarImg];
        [navBarImg release];
        
        Module *module = [[Userinfo shareUserinfo] getModuleWithIdentifier:kNewsCenterModuleIdentifier];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
        titleLab.text = module.name;
        titleLab.textAlignment = UITextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont boldSystemFontOfSize:24];
        titleLab.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLab];
        [titleLab release];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
