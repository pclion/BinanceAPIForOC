//
//  PCOrderRequestModel.h
//  PCBianceAPIDemo
//
//  Created by peichuang on 2017/10/21.
//  Copyright © 2017年 peichuang. All rights reserved.
//

#import "PCRequestModel.h"

@interface PCOrderRequestModel : PCRequestModel

@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, copy) NSString const *side;
@property (nonatomic, copy) NSString const *type;
@property (nonatomic, copy) NSString const *timeInForce;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *timestamp;

//@property (nonatomic, copy) NSString *clientOrderId;
@property (nonatomic, copy) NSString *stopPrice;
@property (nonatomic, copy) NSString *icebergQty;
@property (nonatomic, copy) NSString *recvWindow;

@end
