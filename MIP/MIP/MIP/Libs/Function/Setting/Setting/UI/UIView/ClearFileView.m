//
//  ClearFileView.m
//  Setting
//
//  Created by lixiangai on 14-1-26.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "ClearFileView.h"
#import  "ClearFileCell.h"

#define PopFrameTopShadow       7
#define PopFrameBottomShadow    17

@implementation ClearFileView
@synthesize _delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id)theDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self filesizeAndfileType];
   
        //全屏背景按钮

        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bgView.backgroundColor =[UIColor blackColor];
        bgView.alpha = 0.6;
        [self addSubview:bgView];
        [bgView release];
        
        allSelected = NO;
        self._delegate = theDelegate;
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 96.5, 320, 295 + PopFrameTopShadow + PopFrameBottomShadow)];
        contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:contentView];
        [contentView release];
        
        UIImageView *contentBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pot_box.png" imageBundle:settingBundle]];
        contentBgView.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
        [contentView addSubview:contentBgView];
        [contentBgView release];
        
        //数据清理"
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, PopFrameTopShadow, contentView.frame.size.width, 40)];
        titleLable.text = @"数据清理";
        titleLable.textAlignment = UITextAlignmentCenter;
        titleLable.textColor = [UIColor whiteColor];
        titleLable.font = [UIFont boldSystemFontOfSize:22];
        titleLable.backgroundColor = [UIColor clearColor];
        [contentView addSubview:titleLable];
        [titleLable release];
        
        //选择要清理的文件类型
        UILabel *titlepromt = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 200, 16)];
        titlepromt.text = @"选择要清理的文件类型：";
        titlepromt.textAlignment = UITextAlignmentLeft;
        titlepromt.textColor = [UIColor whiteColor];
        titlepromt.font = [UIFont systemFontOfSize:14];
        titlepromt.backgroundColor = [UIColor clearColor];
        [contentView addSubview:titlepromt];
        [titlepromt release];
        
        //
         _selectedAllButton = [[UIButton alloc] initWithFrame:CGRectMake(contentView.frame.size.width - 70, 50, 16, 16)];
        [_selectedAllButton setBackgroundImage:[UIImage imageNamed:@"file_unselected.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        [_selectedAllButton addTarget:self action:@selector(selectedAllOrnot) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:_selectedAllButton];
        [_selectedAllButton release];
    
        
        //
        UILabel *selectpromt = [[UILabel alloc] initWithFrame:CGRectMake(contentView.frame.size.width - 62, 50, 40, 16)];
        selectpromt.backgroundColor = [UIColor redColor];
        selectpromt.text = @"全选";
        selectpromt.textAlignment = UITextAlignmentRight;
        selectpromt.textColor = [UIColor whiteColor];
        selectpromt.font = [UIFont systemFontOfSize:14];
        selectpromt.backgroundColor = [UIColor clearColor];
        [contentView addSubview:selectpromt];
        [selectpromt release];
        
        fileTypeArrary = [[NSMutableArray alloc] initWithObjects:@"./jpg/png", @".pdf",@".txt",@"其他",nil];
        fileDictionary = [[NSMutableDictionary alloc] init];
        
        
        //文件类型列表
        _selecteFileTable  = [[UITableView alloc] initWithFrame:CGRectMake(20, 75, contentView.frame.size.width - 40,160) style:UITableViewStylePlain];
        _selecteFileTable.backgroundColor = [UIColor clearColor];
        _selecteFileTable.delegate = self;
        _selecteFileTable.dataSource = self;
        _selecteFileTable.bounces = NO;
        _selecteFileTable.rowHeight = 40;
        
#ifdef __IPHONE_7_0
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
        {
            _selecteFileTable.separatorInset = UIEdgeInsetsZero;
        }
#endif
        
        [contentView addSubview:_selecteFileTable];
        [_selecteFileTable release];
        
         UIButton *sureButton  = [[UIButton alloc] init];
        sureButton.frame = CGRectMake(25, 238, 130, 35);
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [contentView addSubview:sureButton];
        [sureButton release];
        
        
        UIButton *cancelBtn  = [[UIButton alloc] init];
        cancelBtn.frame = CGRectMake(165, 238, 130, 35);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"button_q.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelView) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [contentView addSubview:cancelBtn];
        [cancelBtn release];
       
    }
    return self;
}


-(void)selectedAllOrnot
{
    allSelected = !allSelected;
    [_selectedAllButton setBackgroundImage:[UIImage imageNamed:@"file_unselected.png" imageBundle:settingBundle] forState:UIControlStateNormal];
    if (allSelected)
    {
        [_selectedAllButton setBackgroundImage:[UIImage imageNamed:@"file_selected.png" imageBundle:settingBundle] forState:UIControlStateNormal];
    }
    for (int i = 0; i < fileTypeArrary.count; i++)
    {
        [fileDictionary setObject:[NSNumber numberWithBool:allSelected] forKey:[fileTypeArrary objectAtIndex:i]];
    }
    [_selecteFileTable reloadData];
    
}

-(void)cancelView
{
    [self removeFromSuperview];
}

-(void)sureAction
{
    if ([fileDictionary.allKeys count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"您尚未选择要清理的项目，请先勾选 ！"
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
        
        return;
    }
    
    NSEnumerator *enumerator = [fileDictionary keyEnumerator];
    NSString *str = nil;
    while ((str = [enumerator nextObject]))
    {
        NSNumber *num = [fileDictionary objectForKey:str];
        
        if ([num boolValue])
        {
            if ([str isEqualToString:[fileTypeArrary objectAtIndex:0]])
            {
                [self deleteTheFile:jpgArray];
            }
             else if ([str isEqualToString:[fileTypeArrary objectAtIndex:1]])
            {
                [self deleteTheFile:pdfArray];
            }
             else if ([str isEqualToString:[fileTypeArrary objectAtIndex:2]])
             {
                 [self deleteTheFile:txtArray];
             }
             else
             {
                 NSString *libraryPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Preferences"];
                 NSFileManager *fileManager = [NSFileManager defaultManager];
                 NSArray *preferencesDir = [fileManager subpathsOfDirectoryAtPath:libraryPath error:nil];
                 
                 for (NSString *fileName in preferencesDir)
                 {
                     
                     NSString *filePath = [libraryPath stringByAppendingPathComponent:fileName];
                     [fileManager removeItemAtPath:filePath error:NULL];
                 }
                 
                 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                 [userDefaults setObject:nil forKey:@"lastLoginUserName"];
                 [userDefaults setBool:NO forKey:@"autoLogin"];

                 NSDictionary *dic  = [userDefaults dictionaryRepresentation];
                 for (id key in dic)
                 {
                     [userDefaults removeObjectForKey:key];
                 }

                 [self deleteTheFile:otherArray];
             }
            
        }
        
        
    }
    
 
    if (_delegate && [_delegate respondsToSelector:@selector(clearOver)])
    {
        [_delegate clearOver];
    }
    
    [self removeFromSuperview];

}

-(void)deleteTheFile:(NSArray *)arr
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString  *str in arr)
    {
        [fileManager removeItemAtPath:str error:NULL];
    }
   

}

#pragma mark tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fileTypeArrary.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FileTpyeCell";
    
    ClearFileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[ClearFileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.tag = [indexPath row];
    }
    
    cell.tag = indexPath.row;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.fileTpyeLable.text = [fileTypeArrary objectAtIndex:[indexPath  row]] ;


    // 设置选中
    NSNumber *number = [fileDictionary objectForKey:[fileTypeArrary objectAtIndex:indexPath.row]];
    cell.selectedCell =NO;
    
    if (number)
    {
     
        BOOL  tempBool = [number boolValue];
        cell.selectedCell = tempBool;
        [cell setTheSelectedState:tempBool];

    }
 
    cell.totalSize.text =[filesizeArray objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark ClearFileCellDelegate

-(void)selectedCell:(ClearFileCell*)cell
{


    [fileDictionary setObject:[NSNumber numberWithBool:cell.selectedCell] forKey: [fileTypeArrary objectAtIndex:cell.tag]];
    
    int x = 0;
    for (int i = 0; i < fileTypeArrary.count ; i++)
    {
        if ([[fileDictionary objectForKey:[fileTypeArrary objectAtIndex:i]] boolValue])
        {
            x++;
        }
        
    }
    
    [_selectedAllButton setBackgroundImage:[UIImage imageNamed:@"file_unselected.png" imageBundle:settingBundle] forState:UIControlStateNormal];
    allSelected = NO;

    if (x == fileTypeArrary.count)
    {
        [_selectedAllButton setBackgroundImage:[UIImage imageNamed:@"file_selected.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        allSelected = YES;
    }


}

#pragma mark file size
-(void)filesizeAndfileType
{
    
    NSString *DocumentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

    
//    NSArray *subDir = [fileManager subpathsOfDirectoryAtPath:DocumentPath error:nil];
    

    
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray * filelist = [fileManager contentsOfDirectoryAtPath:DocumentPath error:nil];
    
     jpgArray = [[NSMutableArray alloc]init];
     otherArray = [[NSMutableArray alloc]init];
     txtArray = [[NSMutableArray alloc]init];
     pdfArray = [[NSMutableArray alloc]init];
    filesizeArray = [[NSMutableArray alloc] init];
    
    
    //size
    
     pdfSize = 0;
     txtSize = 0;
     jpgSize = 0;
     otherSize = 0;
    
	BOOL isDir = NO;
	for (NSString *file in filelist)
	{
		if ([file hasPrefix:@"."])
		{
			continue;
		}
        //
		if([file isEqualToString:@"webdav_stdout"])
		{
			continue;
		}
        
		NSString *tempPath = [NSString stringWithFormat:@"%@/%@",DocumentPath,file];
		NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:tempPath error:nil];
     
        
		
		NSString *suffix= [file pathExtension];
		[fileManager fileExistsAtPath:tempPath isDirectory:(&isDir)];
        
        if (isDir)
        {
            [self statisticalFilesizeByPath:tempPath];
        }
		else
		{

            if ([suffix isEqualToString:@"pdf"])
            {

            pdfSize +=  [[fileAttributes objectForKey:NSFileSize] doubleValue];
            [pdfArray addObject:tempPath];


            }
            else if([suffix isEqualToString:@"txt"])
            {
                txtSize +=  [[fileAttributes objectForKey:NSFileSize] doubleValue];
                [txtArray addObject:tempPath];

            }
            else if([suffix isEqualToString:@"jpg"] ||[suffix isEqualToString:@"png"])
            {
                jpgSize +=  [[fileAttributes objectForKey:NSFileSize] doubleValue];
                [jpgArray addObject:tempPath];
            }
            else
            {
                otherSize +=  [[fileAttributes objectForKey:NSFileSize] doubleValue];
                [otherArray addObject:tempPath];
            }
        }
    }
    
    [filesizeArray addObject:[self calculateFileSize:jpgSize]];
    [filesizeArray addObject:[self calculateFileSize:pdfSize]];
    [filesizeArray addObject:[self calculateFileSize:txtSize]];
    [filesizeArray addObject:[self calculateFileSize:otherSize]];
    
    
    
}


-(void)statisticalFilesizeByPath:(NSString*)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray * filelist = [fileManager contentsOfDirectoryAtPath:path error:nil];
    
	BOOL isDir = NO;
    
	for (NSString *file in filelist)
	{

		NSString *tempPath = [NSString stringWithFormat:@"%@/%@",path,file];
		NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:tempPath error:nil];
        //        NSLog(@"fileAttributes==%@",fileAttributes);
        
		
		NSString *suffix= [file pathExtension];
		[fileManager fileExistsAtPath:tempPath isDirectory:(&isDir)];
        
        if (isDir)
        {
            [self statisticalFilesizeByPath:tempPath];
        }
		else
		{
            
            if ([suffix isEqualToString:@"pdf"])
            {
                pdfSize +=  [[fileAttributes objectForKey:NSFileSize] doubleValue];
                [pdfArray addObject:tempPath];
            }
            else if([suffix isEqualToString:@"txt"])
            {
                txtSize +=  [[fileAttributes objectForKey:NSFileSize] doubleValue];
                [txtArray addObject:tempPath];
                
            }
            else if([suffix isEqualToString:@"jpg"] ||[suffix isEqualToString:@"png"])
            {
                jpgSize +=  [[fileAttributes objectForKey:NSFileSize] doubleValue];
                [jpgArray addObject:tempPath];
            }
            else
            {
                otherSize +=  [[fileAttributes objectForKey:NSFileSize] doubleValue];
                [otherArray addObject:tempPath];
            }
        }
    }

}


-(NSString *)calculateFileSize:(double )size
{
	
	double x = size;
	//NSLog(@"x===%lld",x);
	
	if (x < 1024)
	{
		NSString *strKB = [NSString stringWithFormat:@"0%@",@"B"];
		return strKB ;
	}
	else if(x >= 1024 && x < 1048576)
	{
		float y =(float)x/1024;
		NSString *strKB = [NSString stringWithFormat:@"%0.1f%@",y,@"KB"];
		return strKB ;
	}
	else if(x >= 1048576 && x < 1073741824)
	{
		float y =(float)x/1048576;
		NSString *strKB = [NSString stringWithFormat:@"%0.1f%@",y,@"MB"];
		return strKB ;
        
	}
	else
	{
		float y =(float)x/1073741824;
		NSString *strKB = [NSString stringWithFormat:@"%0.1f%@",y,@"GB"];
		return strKB ;
	}
	
}


-(void)dealloc
{
   
    [fileTypeArrary release];
    [filesizeArray release];
    [pdfArray release];
    [otherArray release];
    [txtArray release];
    [jpgArray release];
     [super dealloc];
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
