//
//  WebSiteViewController.m
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-26.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "WebSiteViewController.h"

#import "WebSiteContentViewController.h"

#import "WebSiteCategory.h"
#import "WebSiteEntity.h"

#import "CommonlyUsedToolBLL.h"


#define CATEGORYTABLEVIEW_TAG   1001
#define ITEMTABLEVIEW_TAG       1002
#define CATEGORYTEXTFIELD_TAG   1003
#define ENTITYNAMETEXTFIELD_TAG   1004
#define ENTITYVALUETEXTFIELD_TAG   1005

@interface WebSiteViewController (){
    NSFetchedResultsController  *categoryFetchedResultsController;
    NSFetchedResultsController  *itemFetchedResultsController;
    
    WebSiteCategory             *currentCategory;
}

@end

@implementation WebSiteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView{
    webSiteView = [[WebSiteView alloc] initWithFrame:CGRectMake(59, 55, 870, 693)];
    self.view = webSiteView;
    [webSiteView release];
    
    UIButton *categoryAddButton = webSiteView.categoryAddButton;
    [categoryAddButton addTarget:self action:@selector(addCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *itemAddButton = webSiteView.itemAddButton;
    [itemAddButton addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *categoryEditButton = webSiteView.categoryEditButton;
    [categoryEditButton addTarget:self action:@selector(editCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *itemEditButton = webSiteView.itemEditButton;
    [itemEditButton addTarget:self action:@selector(editItem:) forControlEvents:UIControlEventTouchUpInside];
    
    categoryFetchedResultsController = [WebSiteCategory categoryResultsController];
    
    categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(11, 56, 398, 556) style:UITableViewStylePlain];
    categoryTableView.tag = CATEGORYTABLEVIEW_TAG;
    categoryTableView.dataSource = self;
    categoryTableView.delegate = self;
    categoryTableView.backgroundColor = [UIColor clearColor];
    categoryTableView.backgroundView = nil;
    categoryTableView.rowHeight = 50;
    [self.view addSubview:categoryTableView];
    
    
    itemTableView = [[UITableView alloc] initWithFrame:CGRectMake(444, 59, 392, 550) style:UITableViewStylePlain];
    itemTableView.tag = ITEMTABLEVIEW_TAG;
    itemTableView.dataSource = self;
    itemTableView.delegate = self;
    itemTableView.backgroundColor = [UIColor clearColor];
    itemTableView.backgroundView = nil;
    itemTableView.rowHeight = 60;
    [self.view addSubview:itemTableView];
    
    categoryFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (categoryFetchedResultsController && ![categoryFetchedResultsController performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         */
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [categoryTableView reloadData];
    
}

- (void)addCategory:(id)sender{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
    
    bgImageView.image = [UIImage imageNamed:@"bg_alert_style1.png" imageBundle:publicResourceBundle];
    
    CustomNewAlertView *alertView = [[CustomNewAlertView alloc] initWithTitle:@"" message:@"" delegate:nil cancelButtonTitle:@"" otherButtonTitles:@""];
    
    //描述信息
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, bgImageView.frame.size.width, 50)];
    titleLab.text = @"添加分类";
    titleLab.font = [UIFont boldSystemFontOfSize:25];
    titleLab.textAlignment = UITextAlignmentCenter;
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setBackgroundColor:[UIColor clearColor]];
    [alertView addTheview:titleLab];
    [titleLab release];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 100, 50)];
    nameLab.text = @"分类名称";
    nameLab.font = [UIFont boldSystemFontOfSize:20];
    nameLab.textAlignment = UITextAlignmentCenter;
    [nameLab setTextColor:[UIColor colorWithHex:@"474747"]];
    [nameLab setBackgroundColor:[UIColor clearColor]];
    [alertView addTheview:nameLab];
    [nameLab release];
    
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(110, 80, 260, 50)];
    nameField.placeholder = @"请输入分类名称";
    nameField.font = [UIFont boldSystemFontOfSize:16];
    nameField.borderStyle = UITextBorderStyleRoundedRect;
    nameField.tag = CATEGORYTEXTFIELD_TAG;
    nameField.delegate = self;
    [nameField setTextColor:[UIColor colorWithHex:@"474747"]];
    [nameField setBackgroundColor:[UIColor whiteColor]];
    [alertView addTheview:nameField];
    [nameField release];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(20, 180, 170, 40);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithHex:@"3b6f92"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"button_blue_style1.png" imageBundle:publicResourceBundle] forState:UIControlStateNormal];
    [alertView addButton:cancelButton];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setTitle:@"确定" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor colorWithHex:@"3b6f92"] forState:UIControlStateNormal];
    [doneButton setBackgroundImage:[UIImage imageNamed:@"button_blue_style1.png" imageBundle:publicResourceBundle] forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(210, 180, 170, 40);
    [doneButton addTarget:self action:@selector(addCategoryConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addButton:doneButton];
    [alertView show];
    
    
    [bgImageView release];
    [alertView release];
}

- (void)addCategoryConfirm:(id)sender{
    UIButton *doneButton = (UIButton *)sender;
    CustomNewAlertView *customNewAlertView = (CustomNewAlertView *)doneButton.superview;
    UITextField *nameField = (UITextField *)[customNewAlertView viewWithTag:CATEGORYTEXTFIELD_TAG];
    
    NSString *categoryName = [nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (isValid(categoryName)&&categoryName.length>0) {
        if ([CommonlyUsedToolBLL isExsitWebSiteCategory:categoryName]) {
            [self showError:@"该分类已存在"];
        }else{
            [CommonlyUsedToolBLL saveWebSiteCategory:categoryName];
        }
    }else{
        [self showError:@"分类名称不能为空"];
    }
}



- (void)addItem:(id)sender{
    if (currentCategory == nil) {
        [self showError:@"请选择分类"];
    }else{
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
        
        bgImageView.image = [UIImage imageNamed:@"bg_alert_style1.png" imageBundle:publicResourceBundle];
        
        CustomNewAlertView *alertView = [[CustomNewAlertView alloc] initWithTitle:@"" message:@"" delegate:nil cancelButtonTitle:@"" otherButtonTitles:@""];
        
        //描述信息
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, bgImageView.frame.size.width, 50)];
        titleLab.text = @"添加网址";
        titleLab.font = [UIFont boldSystemFontOfSize:25];
        titleLab.textAlignment = UITextAlignmentCenter;
        [titleLab setTextColor:[UIColor whiteColor]];
        [titleLab setBackgroundColor:[UIColor clearColor]];
        [alertView addTheview:titleLab];
        [titleLab release];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 100, 50)];
        nameLab.text = @"名称";
        nameLab.font = [UIFont boldSystemFontOfSize:20];
        nameLab.textAlignment = UITextAlignmentCenter;
        [nameLab setTextColor:[UIColor colorWithHex:@"474747"]];
        [nameLab setBackgroundColor:[UIColor clearColor]];
        [alertView addTheview:nameLab];
        [nameLab release];
        
        UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(110, 60, 260, 50)];
        nameField.placeholder = @"请输入网址名称";
        nameField.font = [UIFont boldSystemFontOfSize:16];
        nameField.borderStyle = UITextBorderStyleRoundedRect;
        nameField.tag = ENTITYNAMETEXTFIELD_TAG;
        nameField.delegate = self;
        [nameField setTextColor:[UIColor colorWithHex:@"474747"]];
        [nameField setBackgroundColor:[UIColor whiteColor]];
        [alertView addTheview:nameField];
        [nameField release];
        
        UILabel *valueLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, 100, 50)];
        valueLab.text = @"地址";
        valueLab.font = [UIFont boldSystemFontOfSize:20];
        valueLab.textAlignment = UITextAlignmentCenter;
        [valueLab setTextColor:[UIColor colorWithHex:@"474747"]];
        [valueLab setBackgroundColor:[UIColor clearColor]];
        [alertView addTheview:valueLab];
        [valueLab release];
        
        UITextField *valueField = [[UITextField alloc] initWithFrame:CGRectMake(110, 115, 260, 50)];
        valueField.placeholder = @"请输入网址";
        valueField.font = [UIFont boldSystemFontOfSize:16];
        valueField.borderStyle = UITextBorderStyleRoundedRect;
        valueField.tag = ENTITYVALUETEXTFIELD_TAG;
        valueField.delegate = self;
        [valueField setTextColor:[UIColor colorWithHex:@"474747"]];
        [valueField setBackgroundColor:[UIColor whiteColor]];
        [alertView addTheview:valueField];
        [valueField release];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(20, 180, 170, 40);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor colorWithHex:@"3b6f92"] forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"button_blue_style1.png" imageBundle:publicResourceBundle] forState:UIControlStateNormal];
        [alertView addButton:cancelButton];
        
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneButton setTitle:@"确定" forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor colorWithHex:@"3b6f92"] forState:UIControlStateNormal];
        [doneButton setBackgroundImage:[UIImage imageNamed:@"button_blue_style1.png" imageBundle:publicResourceBundle] forState:UIControlStateNormal];
        doneButton.frame = CGRectMake(210, 180, 170, 40);
        [doneButton addTarget:self action:@selector(addItemConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [alertView addButton:doneButton];
        [alertView show];
        
        
        [bgImageView release];
        [alertView release];
    }
}

- (void)addItemConfirm:(id)sender{
    UIButton *doneButton = (UIButton *)sender;
    CustomNewAlertView *customNewAlertView = (CustomNewAlertView *)doneButton.superview;
    UITextField *nameField = (UITextField *)[customNewAlertView viewWithTag:ENTITYNAMETEXTFIELD_TAG];
    UITextField *valueField = (UITextField *)[customNewAlertView viewWithTag:ENTITYVALUETEXTFIELD_TAG];
    
    NSString *entityName = [nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *entityValue = [valueField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!isValid(entityName)||entityName.length==0) {
        [self showError:@"网址名称不能为空"];
    }else if(!isValid(entityValue)||entityValue.length==0){
        [self showError:@"网址不能为空"];
    }
    else{
        if ([CommonlyUsedToolBLL isExsitWebSiteEntityWithName:entityName inCategory:currentCategory]) {
            [self showError:@"该名称已存在"];
        }else{
            [CommonlyUsedToolBLL saveWebSiteEntityWithName:entityName andValue:entityValue inCategory:currentCategory];
        }
    }
}

- (void)editCategory:(id)sender{
    if (categoryTableView.editing) {
        [categoryTableView setEditing:NO animated:YES];
    }else{
        [categoryTableView setEditing:YES animated:YES];
    }
    
}

- (void)editItem:(id)sender{
    if (itemTableView.editing) {
        [itemTableView setEditing:NO animated:YES];
    }else{
        [itemTableView setEditing:YES animated:YES];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == CATEGORYTABLEVIEW_TAG) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[categoryFetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    }else{
        id <NSFetchedResultsSectionInfo> sectionInfo = [[itemFetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (tableView.tag == CATEGORYTABLEVIEW_TAG) {
        static NSString *CellIdentifier = @"CategoryTableViewCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            
            cell.imageView.image = [UIImage imageNamed:@"icon_sc.png" imageBundle:commonlyUsedToolBundle];
            
            cell.indentationWidth = 25;
            cell.indentationLevel =1;
            
            UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_cellBackground_style1_2.png" imageBundle:publicResourceBundle]];
            cell.selectedBackgroundView = selectedBackgroundView;
            [selectedBackgroundView release];
            
            cell.textLabel.textColor = cell.textLabel.highlightedTextColor = [UIColor colorWithRed:87.0/255 green:87.0/255 blue:87.0/255 alpha:1];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        }
//        config cell
        if (categoryFetchedResultsController.fetchedObjects.count > indexPath.row)
        {
            WebSiteCategory *entity = [categoryFetchedResultsController objectAtIndexPath:indexPath];
            
            cell.textLabel.text = entity.name;
        }
        
    }else{
        static NSString *CellIdentifier = @"ItemTableViewCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            
            cell.imageView.image = [UIImage imageNamed:@"icon_w_1.png" imageBundle:commonlyUsedToolBundle];
            
            cell.indentationWidth = 0;
            cell.indentationLevel =1;
            
            UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_cellBackground_style1_2.png" imageBundle:publicResourceBundle]];
            cell.selectedBackgroundView = selectedBackgroundView;
            [selectedBackgroundView release];
            
            UIImage *accessoryImage = [UIImage imageNamed:@"icon_arrow_right_style1.png" imageBundle:publicResourceBundle];
            UIImageView *accessoryView = [[UIImageView alloc] initWithImage:accessoryImage];
            accessoryView.frame = CGRectMake(0, 0, accessoryImage.size.width, accessoryImage.size.height);
            cell.accessoryView = accessoryView;
            cell.accessoryView.frame = CGRectMake(cell.accessoryView.frame.origin.x-50, 10, cell.accessoryView.frame.size.width, cell.accessoryView.frame.size.height);
            [accessoryView release];
            
            cell.textLabel.textColor = cell.textLabel.highlightedTextColor = [UIColor colorWithRed:87.0/255 green:87.0/255 blue:87.0/255 alpha:1];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
            
            cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:16];
            
            cell.detailTextLabel.textColor = cell.detailTextLabel.highlightedTextColor = [UIColor grayColor];
        }
//        config cell
        
        if (itemFetchedResultsController.fetchedObjects.count > indexPath.row)
        {
            WebSiteEntity *entity = [itemFetchedResultsController objectAtIndexPath:indexPath];
            
            cell.textLabel.text = entity.name;
            cell.detailTextLabel.text = entity.url;
        }
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == CATEGORYTABLEVIEW_TAG) {
        WebSiteCategory *category= [categoryFetchedResultsController objectAtIndexPath:indexPath];
        currentCategory = category;
        itemFetchedResultsController = category.fetchedResultsController;
        itemFetchedResultsController.delegate = self;
        NSError *error = nil;
        if (itemFetchedResultsController && ![itemFetchedResultsController performFetch:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [itemTableView reloadData];
        
    }else{
        WebSiteEntity *entity= [itemFetchedResultsController objectAtIndexPath:indexPath];
        
        WebSiteContentViewController *contentViewController = [[WebSiteContentViewController alloc] init];
        [self presentViewController:contentViewController animated:YES completion:NULL];
        NSURL *url = [NSURL URLWithString:[entity.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [contentViewController.contentWebView loadRequest:[NSURLRequest requestWithURL:url]];
        contentViewController.titleLabel.text = entity.name;
        [contentViewController release];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObject *entity = nil;
        
        if (tableView == categoryTableView) {
            entity = [categoryFetchedResultsController objectAtIndexPath:indexPath];
            if (entity == currentCategory) {
                currentCategory = nil;
            }
//            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
//            [context deleteObject:entity];
//            NSError *saveError = nil;
//            [context save:&saveError];
        }else{
            entity = [itemFetchedResultsController objectAtIndexPath:indexPath];
        }
        
        NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
        [context deleteObject:entity];
        NSError *saveError = nil;
        [context save:&saveError];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - NSFetchedResultsControllerDelegate
/*!
 @function
 @abstract      NSFetchedResultsControllerDelegate方法,当其管理的数据内容将要发生变化时,该方法将会被触发
 
 @param         controller                      被实现协议的controller
 
 @note          tableView准备开始更新
 
 @result        无
 */
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    if (categoryFetchedResultsController == controller)
    {
        [categoryTableView beginUpdates];
    }else{
        [itemTableView beginUpdates];
    }
}



/*!
 @function
 @abstract      NSFetchedResultsControllerDelegate方法,当其管理的数据内容将要发生变化时,该方法将会被触发
 
 @param         controller                      被实现协议的controller
 @param
 
 @note          根据当前数据发生的增,删,改,移动,视图对应的处理
 
 @result        无
 */
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = nil;
    if (categoryFetchedResultsController == controller) {
        tableView = categoryTableView;
    }else{
        tableView = itemTableView;
    }
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            
            
            
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}



/*!
 @function
 @abstract      NSFetchedResultsControllerDelegate方法,当其管理的数据内容变化完成时,该方法将会被触发
 
 @param         controller                      被实现协议的controller
 @param
 
 @note          tableView结束更新
 
 @result        无
 */
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    //lixiangai 三级目录数据错误问题
 
    if (categoryFetchedResultsController == controller)
    {
        [categoryTableView endUpdates];
        
        [categoryTableView flashScrollIndicators];
    }else{
        [itemTableView endUpdates];
        
        [itemTableView flashScrollIndicators];
    }
}

- (void)showError:(NSString *)string{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

@end
