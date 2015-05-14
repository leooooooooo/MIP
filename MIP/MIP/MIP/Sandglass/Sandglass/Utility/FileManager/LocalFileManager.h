/********************************************************************
 Author: li_xiangai
 Class description:LocalFileManager
 *******************************************************/
#import <Foundation/Foundation.h>




@interface FileInformation : NSObject
{
    NSString *name;          //文件名
	NSString *Path;         //文件路径
	NSString *size;         //文件大小
	NSString *modificationDate;     //修改日期
    NSString *creationDate;         //创建日期
    NSString *author;           //文件作者
    NSString *type;
    
}
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain)NSString *path;
@property(nonatomic,retain)NSString *size;
@property(nonatomic,retain)NSString *modificationDate;
@property(nonatomic,retain)NSString *creationDate;
@property(nonatomic,retain)NSString *author ;
@property(nonatomic,retain)NSString *type ;
@end



@interface LocalFileManager : NSObject

/*********************************************************************
 Function description:拷贝文件或文件夹 成功：YES 失败：NO
 input Parameter: sourcePath,  //文件原路径
 input Parameter:destinationPath  //目的地路径
 Return value: BOOL
 Author: li_xiangai
 Remark: override
 *********************************************************************/

+(BOOL) copyFileOrFolder:(NSString *)sourcePath
         DestinationPath:(NSString*)destinationPath;    //拷贝粘贴文件

/*********************************************************************
 Function description:document文件夹路径
 Parameter: N/A
 Return value: NSString
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(NSString *)documentsFolderPath;   //document文件夹路

/*********************************************************************
 Function description:删除文件或文件夹，成功：YES 失败：NO
 input Parameter: path        //文件路径
 Return value: BOOL
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(BOOL)deleteFileOrFolder:(NSString *)path;    // 删除文件或文件夹

/*********************************************************************
 Function description:获取文件属性，返回FileInformation对象
 input Parameter: path        //文件路径
 Return value: FileInformation
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(FileInformation*)fileAttributesAtPath:(NSString*)path;  //获取文件属性


/*********************************************************************
 Function description:剪切粘贴文件或文件夹 成功：YES 失败：NO
 input Parameter: sourcePath,  //文件原路径
 input Parameter:destinationPath  //目的地路径
 Return value: BOOL
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(BOOL)cutAndPasteFileOrFolder:(NSString *)sourcePath
               DestinationPath:(NSString*)destinationPath; //剪切粘贴

/*********************************************************************
 Function description:重命名文件
 input Parameter: sourcePath,  //文件原路径
 input Parameter:destinationPath  //重命名后文件路径
 Return value: bool
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(BOOL)renameFileOrFolder:(NSString *)sourcePath
          DestinationPath:(NSString*)destinationPath;  //重命名
/*********************************************************************
 Function description:新建文件或文件夹
 input Parameter: path
 Return value: bool
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(BOOL)createFileOrFolder:(NSString*)path;  //新建文件或文件夹  


/*********************************************************************
 Function description:文件或文件夹是否存在
 input Parameter: path，    //文件路径
 output Parameter: isDirectory    //是否文件夹
 Return value: bool
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(BOOL)fileExistAtPath:(NSString *)path IsDirectory:(BOOL*)isDirectory;    //文件是否存在

/*********************************************************************
 Function description:压缩文件或文件夹
 input Parameter: path
 Return value: bool
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(BOOL)compressFileOrFolder:(NSString*)path;                    //压缩文件

/*********************************************************************
 Function description:解压文件或文件夹
 input Parameter: path
 Return value: bool
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(BOOL)decompressFileOrFolder:(NSString *)path;                 //解压文件

/*********************************************************************
 Function description:文件大小转化为GB.KB形式
 input Parameter: sourceSize   ／／long long
 Return value: NSString
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(NSString *)convertFileSizeToString:(long long)sourceSize;
@end





