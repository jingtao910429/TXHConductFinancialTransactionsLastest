//
//  MyaccountnumberCell.m
//  TXHConductFinancialTransactions
//
//  Created by 吴建良 on 15/11/4.
//  Copyright © 2015年 rongyu. All rights reserved.
//

#import "MyaccountnumberCell.h"

@implementation MyaccountnumberCell
@synthesize leftimageview,leftlable,rightlable;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        
        leftimageview=[[UIImageView alloc] initWithFrame:CGRectMake(5, (45 - 25 - 6)/2, 30, 30)];
        [self.contentView addSubview:leftimageview];
        
       
        leftlable=[[UILabel alloc] initWithFrame:CGRectMake(leftimageview.frame.size.width + 12, 5, 80, 35)];
        leftlable.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:leftlable];
        
        float pos = leftlable.frame.origin.x + leftlable.frame.size.width + 5;
        
        rightlable=[[UILabel alloc] initWithFrame:CGRectMake(pos, 5, kScreenWidth - pos - 10 - 20, 35)];
        rightlable.font = [UIFont systemFontOfSize:16];
        
        rightlable.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:rightlable];
 
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}


@end
