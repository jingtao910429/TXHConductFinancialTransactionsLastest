//
//  RechargeCell.m
//  TXHConductFinancialTransactions
//
//  Created by 吴建良 on 15/11/5.
//  Copyright © 2015年 rongyu. All rights reserved.
//

#import "RechargeCell.h"

@implementation RechargeCell
@synthesize leftLable,textField;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        leftLable=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 40)];
        leftLable.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:leftLable];
        
        textField=[[UITextField alloc] initWithFrame:CGRectMake(leftLable.frame.size.width+10, 5, kScreenWidth-leftLable.frame.size.width+10, 40)];
        [self.contentView addSubview:textField];
        
        
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}




@end
