//
//  AttachManagement.m
//  MIP
//
//  Created by wang_hao on 13-11-24.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "AttachManagement.h"

#import "MessageAttachment.h"
#import "DocTransDocument.h"
//#import "InfoJournalEntiy.h"
//#import "CityPlanning.h"
//#import "MeetingArrangement.h"
#import "LibraryDocument.h"
#import "LeaderInstruction.h"
#import "LeaderSchedule.h"

@implementation AttachManagement
+(NSArray *)attachArray:(NSArray *)attachKind{
    NSMutableArray *returnArr = [[[NSMutableArray alloc] init] autorelease];
    for (NSString *className in attachKind) {
//        内部邮件
        if ([className isEqualToString:@"MessageAttachment"]) {
            NSMutableArray *messageAttachmentArray = [NSMutableArray arrayWithCapacity:1];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"MessageAttachment" inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
            
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"filePath != nil"];
            [fetchRequest setPredicate:predicate];
            NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"attachTitle" ascending:YES];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            // Create and initialize the fetch results controller.
            NSFetchedResultsController *fetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil] autorelease];
            
            NSError *error;
            if (![fetchedResultsController performFetch:&error]) {
                /*
                 Replace this implementation with code to handle the error appropriately.
                 
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 */
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            NSArray *a = fetchedResultsController.fetchedObjects;
            
            for (MessageAttachment *attach in a) {
                NSDictionary *dict = [NSDictionary  dictionaryWithObjectsAndKeys:attach.attachTitle,@"title",attach.filePath,@"path", nil];
                [messageAttachmentArray addObject:dict];
            }
            
            if ([messageAttachmentArray count]>0) {
                NSMutableDictionary *messageAttachmentDict = [NSMutableDictionary dictionaryWithCapacity:1];
                [messageAttachmentDict setObject:messageAttachmentArray forKey:@"内部邮件"];
                [returnArr addObject:messageAttachmentDict];
            }
            [fetchRequest release];
            
            [authorDescriptor release];
            
            [sortDescriptors release];
        }
        //如果有其他类别的文件，按照以上方法处理
        /*
         .......
         
         */
//        公文流转
        if ([className isEqualToString:@"DocTransDocument"]) {
            NSMutableArray *docTransDocumentmentArray = [NSMutableArray arrayWithCapacity:1];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"DocTransDocument" inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
            
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"filePath != nil"];
            [fetchRequest setPredicate:predicate];
            NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            // Create and initialize the fetch results controller.
            NSFetchedResultsController *fetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil] autorelease];
            
            NSError *error;
            if (![fetchedResultsController performFetch:&error]) {
                /*
                 Replace this implementation with code to handle the error appropriately.
                 
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 */
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            NSArray *a = fetchedResultsController.fetchedObjects;
            
            for (DocTransDocument *document in a) {
                NSDictionary *dict = [NSDictionary  dictionaryWithObjectsAndKeys:document.title,@"title",document.filePath,@"path", nil];
                [docTransDocumentmentArray addObject:dict];
            }
            
            if ([docTransDocumentmentArray count]>0) {
                NSMutableDictionary *docTransDocumentmentDict = [NSMutableDictionary dictionaryWithCapacity:1];
                [docTransDocumentmentDict setObject:docTransDocumentmentArray forKey:@"公文处理"];
                [returnArr addObject:docTransDocumentmentDict];
            }
            [fetchRequest release];
            
            [authorDescriptor release];
            
            [sortDescriptors release];
        }
//        信息刊物附件
        if ([className isEqualToString:@"InfoJournalEntiy"]) {
            NSMutableArray *messageAttachmentArray = [NSMutableArray arrayWithCapacity:1];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"InfoJournalEntiy" inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
            
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"filePath != nil"];
            [fetchRequest setPredicate:predicate];
            NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            // Create and initialize the fetch results controller.
            NSFetchedResultsController *fetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil] autorelease];
            
            NSError *error;
            if (![fetchedResultsController performFetch:&error]) {
                /*
                 Replace this implementation with code to handle the error appropriately.
                 
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 */
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            NSArray *a = fetchedResultsController.fetchedObjects;
            
//            for (InfoJournalEntiy *entity in a) {
//                NSDictionary *dict = [NSDictionary  dictionaryWithObjectsAndKeys:entity.title,@"title",entity.filePath,@"path", nil];
//                [messageAttachmentArray addObject:dict];
//            }
            
            if ([messageAttachmentArray count]>0) {
                NSMutableDictionary *messageAttachmentDict = [NSMutableDictionary dictionaryWithCapacity:1];
                [messageAttachmentDict setObject:messageAttachmentArray forKey:@"信息刊物"];
                [returnArr addObject:messageAttachmentDict];
            }
            [fetchRequest release];
            
            [authorDescriptor release];
            
            [sortDescriptors release];
            
        }
//        城市规划
        if ([className isEqualToString:@"CityPlanning"]) {
            NSMutableArray *messageAttachmentArray = [NSMutableArray arrayWithCapacity:1];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"CityPlanning" inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
            
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"filePath != nil"];
            [fetchRequest setPredicate:predicate];
            NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            // Create and initialize the fetch results controller.
            NSFetchedResultsController *fetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil] autorelease];
            
            NSError *error;
            if (![fetchedResultsController performFetch:&error]) {
                /*
                 Replace this implementation with code to handle the error appropriately.
                 
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 */
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            NSArray *a = fetchedResultsController.fetchedObjects;
            
//            for (CityPlanning *entity in a) {
//                NSDictionary *dict = [NSDictionary  dictionaryWithObjectsAndKeys:entity.title,@"title",entity.filePath,@"path", nil];
//                [messageAttachmentArray addObject:dict];
//            }
            
            if ([messageAttachmentArray count]>0) {
                NSMutableDictionary *messageAttachmentDict = [NSMutableDictionary dictionaryWithCapacity:1];
                [messageAttachmentDict setObject:messageAttachmentArray forKey:@"城市规划"];
                [returnArr addObject:messageAttachmentDict];
            }
            [fetchRequest release];
            
            [authorDescriptor release];
            
            [sortDescriptors release];
            
        }
//        会议通知
        if ([className isEqualToString:@"MeetingArrangement"]) {
            NSMutableArray *messageAttachmentArray = [NSMutableArray arrayWithCapacity:1];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"MeetingArrangement" inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
            
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"filePath != nil"];
            [fetchRequest setPredicate:predicate];
            NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            // Create and initialize the fetch results controller.
            NSFetchedResultsController *fetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil] autorelease];
            
            NSError *error;
            if (![fetchedResultsController performFetch:&error]) {
                /*
                 Replace this implementation with code to handle the error appropriately.
                 
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 */
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            NSArray *a = fetchedResultsController.fetchedObjects;
            
//            for (MeetingArrangement *entity in a) {
//                NSDictionary *dict = [NSDictionary  dictionaryWithObjectsAndKeys:entity.title,@"title",entity.filePath,@"path", nil];
//                [messageAttachmentArray addObject:dict];
//            }
            
            if ([messageAttachmentArray count]>0) {
                NSMutableDictionary *messageAttachmentDict = [NSMutableDictionary dictionaryWithCapacity:1];
                [messageAttachmentDict setObject:messageAttachmentArray forKey:@"会议通知"];
                [returnArr addObject:messageAttachmentDict];
            }
            [fetchRequest release];
            
            [authorDescriptor release];
            
            [sortDescriptors release];
            
        }
//        公文库
        if ([className isEqualToString:@"LibraryDocument"]) {
            NSMutableArray *messageAttachmentArray = [NSMutableArray arrayWithCapacity:1];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"LibraryDocument" inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
            
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"filePath != nil"];
            [fetchRequest setPredicate:predicate];
            NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            // Create and initialize the fetch results controller.
            NSFetchedResultsController *fetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil] autorelease];
            
            NSError *error;
            if (![fetchedResultsController performFetch:&error]) {
                /*
                 Replace this implementation with code to handle the error appropriately.
                 
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 */
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            NSArray *a = fetchedResultsController.fetchedObjects;
            
            for (LibraryDocument *entity in a) {
                NSDictionary *dict = [NSDictionary  dictionaryWithObjectsAndKeys:entity.title,@"title",entity.filePath,@"path", nil];
                [messageAttachmentArray addObject:dict];
            }
            
            if ([messageAttachmentArray count]>0) {
                NSMutableDictionary *messageAttachmentDict = [NSMutableDictionary dictionaryWithCapacity:1];
                [messageAttachmentDict setObject:messageAttachmentArray forKey:@"公文库"];
                [returnArr addObject:messageAttachmentDict];
            }
            [fetchRequest release];
            
            [authorDescriptor release];
            
            [sortDescriptors release];
            
        }
//        领导签批
        if ([className isEqualToString:@"LeaderInstruction"]) {
            NSMutableArray *messageAttachmentArray = [NSMutableArray arrayWithCapacity:1];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"LeaderInstruction" inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
            
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"filePath != nil"];
            [fetchRequest setPredicate:predicate];
            NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            // Create and initialize the fetch results controller.
            NSFetchedResultsController *fetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil] autorelease];
            
            NSError *error;
            if (![fetchedResultsController performFetch:&error]) {
                /*
                 Replace this implementation with code to handle the error appropriately.
                 
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 */
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            NSArray *a = fetchedResultsController.fetchedObjects;
            
            for (LeaderInstruction *entity in a) {
                NSDictionary *dict = [NSDictionary  dictionaryWithObjectsAndKeys:entity.title,@"title",entity.filePath,@"path", nil];
                [messageAttachmentArray addObject:dict];
            }
            
            if ([messageAttachmentArray count]>0) {
                NSMutableDictionary *messageAttachmentDict = [NSMutableDictionary dictionaryWithCapacity:1];
                [messageAttachmentDict setObject:messageAttachmentArray forKey:@"领导批示"];
                [returnArr addObject:messageAttachmentDict];
            }
            
            [fetchRequest release];
            
            [authorDescriptor release];
            
            [sortDescriptors release];
            
        }
//        领导日程
        if ([className isEqualToString:@"LeaderSchedule"]) {
            NSMutableArray *messageAttachmentArray = [NSMutableArray arrayWithCapacity:1];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"LeaderSchedule" inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
            
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"filePath != nil"];
            [fetchRequest setPredicate:predicate];
            NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            // Create and initialize the fetch results controller.
            NSFetchedResultsController *fetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil] autorelease];
            
            NSError *error;
            if (![fetchedResultsController performFetch:&error]) {
                /*
                 Replace this implementation with code to handle the error appropriately.
                 
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 */
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            NSArray *a = fetchedResultsController.fetchedObjects;
            
            for (LeaderSchedule *entity in a) {
                NSDictionary *dict = [NSDictionary  dictionaryWithObjectsAndKeys:entity.title,@"title",entity.filePath,@"path", nil];
                [messageAttachmentArray addObject:dict];
            }
            
            if ([messageAttachmentArray count]>0) {
                NSMutableDictionary *messageAttachmentDict = [NSMutableDictionary dictionaryWithCapacity:1];
                [messageAttachmentDict setObject:messageAttachmentArray forKey:@"日程安排"];
                [returnArr addObject:messageAttachmentDict];
            }
            
            [fetchRequest release];
            
            [authorDescriptor release];
            
            [sortDescriptors release];
            
        }
    }
    
    [self removeNoExitsFileInArray:returnArr];
        
    return returnArr;
}


+ (void)removeNoExitsFileInArray:(NSMutableArray *)arr
{
    NSMutableArray *deleteArr = [[NSMutableArray alloc] init];
    
    //删除沙盒中不存在的文件
    for (NSDictionary *dic in arr)
    {
        NSArray *valueArr = [dic allValues];
        
        if ([valueArr count] > 0)
        {
            NSMutableArray *arr = [valueArr objectAtIndex:0];
            
            BOOL noFile = [self checkFileExistsInArray:arr];
            
            if (noFile == YES)
            {
                [deleteArr addObject:dic];
            }
        }
    }
    
    [arr removeObjectsInArray:deleteArr];
    
    [deleteArr release];
}



+ (BOOL)checkFileExistsInArray:(NSMutableArray *)arr
{
    BOOL noFile = YES;
    
    NSMutableArray *noExitArr = [[NSMutableArray alloc] init];
    
    if (isValid(arr))
    {
        for (NSDictionary *arrDic in arr)
        {
            NSString *name = [arrDic objectForKey:@"path"];
            
            NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/%@/%@",@"Documents",name];
            
            NSFileManager *manager = [NSFileManager defaultManager];
            
            if (![manager fileExistsAtPath:filePath] || ![[name pathExtension] isEqualToString:@"pdf"])
            {
                [noExitArr addObject:arrDic];
            }
            else
            {
                noFile = NO;
            }
        }
        
        [arr removeObjectsInArray:noExitArr];
    }
    
    [noExitArr release];
    
    return noFile;
}

@end
