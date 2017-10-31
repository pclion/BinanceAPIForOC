//
//  PCNetworkClient+Account.h
//  PCBianceAPIDemo
//
//  Created by peichuang on 2017/10/21.
//  Copyright © 2017年 peichuang. All rights reserved.
//

#import "PCNetworkClient.h"
#import "PCOrderRequestModel.h"

@interface PCNetworkClient (Account)

//下单
+ (void)makeOrderWithModel:(PCOrderRequestModel *)model withCompletion:(ResponseCompletion)completion;
//检查订单
+ (void)checkOrderForSymbol:(NSString *)symbol withOrderId:(NSString *)orderId withCompletion:(ResponseCompletion)completion;
//取消订单
+ (void)cancelOrderForSymbol:(NSString *)symbol withOrderId:(NSString *)orderId withCompletion:(ResponseCompletion)completion;
//当前打开订单列表
+ (void)currentOpenOrderListForSymbol:(NSString *)symbol withCompletion:(ResponseCompletion)completion;
//交易品类所有订单列表
+ (void)allOrderListForSymbol:(NSString *)symbol withCompletion:(ResponseCompletion)completion;
//账户信息
+ (void)accountInfoWithCompletion:(ResponseCompletion)completion;
//交易品类我的交易列表
+ (void)myTradeListForSymbol:(NSString *)symbol withCompletion:(ResponseCompletion)completion;

@end
