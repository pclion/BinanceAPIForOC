//
//  PCOrderCell.m
//  PCBianceAPIDemo
//
//  Created by peichuang on 2017/10/27.
//  Copyright © 2017年 peichuang. All rights reserved.
//

#import "PCOrderCell.h"

@implementation PCOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)cancelAction:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock(sender);
    }
}

@end
