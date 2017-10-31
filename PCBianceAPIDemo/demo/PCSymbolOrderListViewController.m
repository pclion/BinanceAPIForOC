//
//  PCSymbolOrderListViewController.m
//  PCBianceAPIDemo
//
//  Created by peichuang on 2017/10/27.
//  Copyright © 2017年 peichuang. All rights reserved.
//

#import "PCSymbolOrderListViewController.h"
#import "PCOrderCell.h"
#import "PCNetworkClient+Account.h"

@interface PCSymbolOrderListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *openOrderList;

@end

@implementation PCSymbolOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupData];
}

- (void)setupData
{
    [self loadData];
}

- (void)loadData
{
    [PCNetworkClient currentOpenOrderListForSymbol:self.symbol withCompletion:^(NSError *error, NSArray * responseObj) {
        self.openOrderList = responseObj;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.openOrderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCOrderCell class]) forIndexPath:indexPath];
    NSDictionary *dict = self.openOrderList[indexPath.row];
    NSTimeInterval time = [dict[@"time"] integerValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *orderInfo = [NSString stringWithFormat:@"%@ %@ %@ %@", dict[@"symbol"], dict[@"type"], dict[@"side"], date];
    cell.orderInfoLabel.text = orderInfo;
    cell.priceLabel.text = dict[@"price"];
    cell.quantityLabel.text = dict[@"origQty"];
    if ([dict[@"status"] isEqualToString:@"NEW"] || [dict[@"status"] isEqualToString:@"PARTIALLY_FILLED"]) {
        cell.cancelButton.hidden = NO;
    } else {
        cell.cancelButton.hidden = YES;
    }
    __weak typeof(self) wSelf = self;
    cell.cancelBlock = ^(UIButton *button) {
        [PCNetworkClient cancelOrderForSymbol:dict[@"symbol"] withOrderId:dict[@"orderId"] withCompletion:^(NSError *error, id responseObj) {
            [wSelf loadData];
        }];
    };
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

@end
