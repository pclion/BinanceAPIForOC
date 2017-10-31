//
//  PCOrderCell.h
//  PCBianceAPIDemo
//
//  Created by peichuang on 2017/10/27.
//  Copyright © 2017年 peichuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(UIButton *button);

@interface PCOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (copy, nonatomic) ActionBlock cancelBlock;

@end
