//
//  TableViewCell.m
//  tableviewSwpTest
//
//  Created by webapps on 17/2/15.
//  Copyright © 2017年 webapps. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        UIView *backGroundView = [[UIView alloc]init];
        backGroundView.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = backGroundView;
        //以下自定义控件
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


    [self changSeleImage];
//    [self changSeleImageColor];
}


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
    [super setHighlighted:highlighted animated:animated];
  
    return;
}

// 修改编辑状态下选中时的图片
- (void)changSeleImage{
    
   
    
    for (UIControl *control in self.subviews) {
        if (![control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            continue;
        }
        
        for (UIView *subView in control.subviews) {
            if (![subView isKindOfClass: [UIImageView class]]) {
                continue;
            }
            
            UIImageView *imageView = (UIImageView *)subView;
            if (self.selected) {
                imageView.image = [UIImage imageNamed:@"1.jpg"]; // 选中时的图片
            } else {
//                imageView.image = [UIImage imageNamed:@""];   // 未选中时的图片
            }
        }
    }
}

// 修改编辑状态下选中时的圆圈颜色
- (void)changSeleImageColor{
    
    [super layoutSubviews];
    for (UIControl *control in self.subviews) {
        if (![control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            continue;
        }
        
        for (UIView *subView in control.subviews) {
            if (![subView isKindOfClass: [UIImageView class]]) {
                continue;
            }
            
            UIImageView *imageView = (UIImageView *)subView;
            if (self.selected) {
                // KVC修改
                [imageView setValue:[UIColor orangeColor] forKey:@"tintColor"];   // 选中时的颜色
            } else {
            }
        }
    }
}

@end
