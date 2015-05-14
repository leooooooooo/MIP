//
//  SubTableViewStyleCell.h
//  MOA
//
//  Created by Sea on 13-5-24.
//
//

#import <UIKit/UIKit.h>

@interface SubTableViewStyleCell : UITableViewCell {
    
    UITableView         *_subTableView;
    
}

@property (nonatomic, assign, readonly)id subTableView;

- (id)initWithSubTableViewClass:(Class)aClass reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)size;

@end
