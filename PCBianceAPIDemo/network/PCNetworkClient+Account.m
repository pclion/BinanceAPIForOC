//
//  PCNetworkClient+Account.m
//  PCBianceAPIDemo
//
//  Created by peichuang on 2017/10/21.
//  Copyright © 2017年 peichuang. All rights reserved.
//

#import "PCNetworkClient+Account.h"

@implementation PCNetworkClient (Account)

+ (void)makeOrderWithModel:(PCOrderRequestModel *)model withCompletion:(ResponseCompletion)completion
{
    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:model];
    
    [self POSTWithSignature:@"/api/v3/order" parameters:dict responseDataClass:[NSDictionary class] completion:^(NSError *error, id responseObj) {
        if (completion) {
            completion(error, responseObj);
        }
    }];
}

+ (void)checkOrderForSymbol:(NSString *)symbol withOrderId:(NSString *)orderId withCompletion:(ResponseCompletion)completion
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (symbol.length > 0) {
        [dict setObject:symbol forKey:@"symbol"];
    }
    if (orderId.length > 0) {
        [dict setObject:orderId forKey:@"orderId"];
    }
    [dict setObject:[NSString stringWithFormat:@"%.0lf", [[NSDate date] timeIntervalSince1970] * 1000] forKey:@"timestamp"];
    
    [self GETWithSignature:@"/api/v3/order" parameters:dict responseDataClass:[NSDictionary class] completion:^(NSError *error, id responseObj) {
        if (completion) {
            completion(error, responseObj);
        }
    }];
}

+ (void)cancelOrderForSymbol:(NSString *)symbol withOrderId:(NSString *)orderId withCompletion:(ResponseCompletion)completion
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (symbol.length > 0) {
        [dict setObject:symbol forKey:@"symbol"];
    }
    if (orderId.length > 0) {
        [dict setObject:orderId forKey:@"orderId"];
    }
    [dict setObject:[NSString stringWithFormat:@"%.0lf", [[NSDate date] timeIntervalSince1970] * 1000] forKey:@"timestamp"];

    [self DELETEWithSignature:@"/api/v3/order" parameters:dict responseDataClass:[NSDictionary class] completion:^(NSError *error, id responseObj) {
        if (completion) {
            completion(error, responseObj);
        }
    }];
}

+ (void)currentOpenOrderListForSymbol:(NSString *)symbol withCompletion:(ResponseCompletion)completion
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (symbol.length > 0) {
        [dict setObject:symbol forKey:@"symbol"];
    }
    [dict setObject:[NSString stringWithFormat:@"%.0lf", [[NSDate date] timeIntervalSince1970] * 1000] forKey:@"timestamp"];
    
    [self GETWithSignature:@"/api/v3/openOrders" parameters:dict responseDataClass:[NSDictionary class] completion:^(NSError *error, id responseObj) {
        if (completion) {
            completion(error, responseObj);
        }
    }];
}

+ (void)allOrderListForSymbol:(NSString *)symbol withCompletion:(ResponseCompletion)completion
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (symbol.length > 0) {
        [dict setObject:symbol forKey:@"symbol"];
    }
    [dict setObject:[NSString stringWithFormat:@"%.0lf", [[NSDate date] timeIntervalSince1970] * 1000] forKey:@"timestamp"];
    
    [self GETWithSignature:@"/api/v3/allOrders" parameters:dict responseDataClass:[NSDictionary class] completion:^(NSError *error, id responseObj) {
        if (completion) {
            completion(error, responseObj);
        }
    }];
}

+ (void)accountInfoWithCompletion:(ResponseCompletion)completion
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%.0lf", [[NSDate date] timeIntervalSince1970] * 1000] forKey:@"timestamp"];
    
    [self GETWithSignature:@"/api/v3/account" parameters:dict responseDataClass:[NSDictionary class] completion:^(NSError *error, id responseObj) {
        if (completion) {
            completion(error, responseObj);
        }
    }];
}

+ (void)myTradeListForSymbol:(NSString *)symbol withCompletion:(ResponseCompletion)completion
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (symbol.length > 0) {
        [dict setObject:symbol forKey:@"symbol"];
    }
    [dict setObject:[NSString stringWithFormat:@"%.0lf", [[NSDate date] timeIntervalSince1970] * 1000] forKey:@"timestamp"];
    
    [self GETWithSignature:@"/api/v3/myTrades" parameters:dict responseDataClass:[NSDictionary class] completion:^(NSError *error, id responseObj) {
        if (completion) {
            completion(error, responseObj);
        }
    }];
}

@end
