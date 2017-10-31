//
//  PCSymbolDetailViewController.m
//  PCBianceAPIDemo
//
//  Created by peichuang on 2017/10/25.
//  Copyright © 2017年 peichuang. All rights reserved.
//

#import "PCSymbolDetailViewController.h"
#import "PCSymbolOrderListViewController.h"
#import "PCNetworkClient+MarketData.h"
#import "PCNetworkClient+Account.h"

@interface PCSymbolDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bidsTableView;
@property (weak, nonatomic) IBOutlet UITableView *asksTableView;
@property (weak, nonatomic) IBOutlet UILabel *buySymbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxBuyLabel;
@property (weak, nonatomic) IBOutlet UIButton *limitPriceButton;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (copy, nonatomic) NSArray *bidsArray;
@property (copy, nonatomic) NSArray *asksArray;
@property (copy, nonatomic) NSDictionary *accountInfo;

@property (copy, nonatomic) NSString *buySymbol;
@property (copy, nonatomic) NSString *sellSymbol;
@property (copy, nonatomic) NSString *buyQuantity;
@property (copy, nonatomic) NSString *sellQuantity;

@end

@implementation PCSymbolDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.symbol;
    [self handleSymbol];
    [self setupData];
    [self fetchAccountInfo];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSymbol
{
    NSArray<NSString *> *buySymbolArray = @[@"USDT",@"BTC",@"ETH"];
    
    [buySymbolArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [self.symbol rangeOfString:obj];
        if (range.location != NSNotFound) {
            self.buySymbol = obj;
            self.sellSymbol = [self.symbol substringToIndex:range.location];
            *stop = YES;
        }
    }];
}

- (void)setupView
{
    self.buySymbolLabel.text = @"";
    self.maxBuyLabel.text = @"";
}

- (void)setupData
{
    [self loadData];
}

- (void)loadData
{
    if (self.symbol.length > 0) {
        [PCNetworkClient marketDepthForSymbol:self.symbol withCompletion:^(NSError *error, NSDictionary * responseObj) {
            self.bidsArray = responseObj[@"bids"];
            self.asksArray = responseObj[@"asks"];
            [self.bidsTableView reloadData];
            [self.asksTableView reloadData];
        }];
    }
}

- (void)fetchAccountInfo
{
    [PCNetworkClient accountInfoWithCompletion:^(NSError *error, id responseObj) {
        self.accountInfo = responseObj;
        
        NSArray<NSDictionary *> *balancesArray = self.accountInfo[@"balances"];
        [balancesArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([self.buySymbol isEqualToString:obj[@"asset"]]) {
                self.buyQuantity = obj[@"free"];
                self.buySymbolLabel.text = [NSString stringWithFormat:@"There is %@ %@ in your account！", self.buyQuantity, self.buySymbol];
            }
            if ([self.sellSymbol isEqualToString:obj[@"asset"]]) {
                self.sellQuantity = obj[@"free"];
                self.maxBuyLabel.text = [NSString stringWithFormat:@"There is %@ %@ in your account！", self.sellQuantity, self.sellSymbol];
            }
        }];
    }];
}

- (PCOrderRequestModel *)createOrderModelWithSide:(NSString const *)side
{
    PCOrderRequestModel *model = [[PCOrderRequestModel alloc] init];
    model.symbol = self.symbol;
    model.side = side;
    model.type = self.limitPriceButton.selected ? orderTypeMarket : orderTypeLimit;
    model.timeInForce = timeForceGTC;
    model.quantity = self.quantityTextField.text;
    model.price = [orderTypeMarket isEqualToString:(NSString *)model.type] ? nil : self.priceTextField.text;
    model.timestamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] * 1000];
    
    return model;
}

#pragma mark - action

- (IBAction)limitPriceAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.priceTextField.text = @"market price";
        self.priceTextField.enabled = NO;
    } else {
        self.priceTextField.text = nil;
        self.priceTextField.enabled = YES;
    }
}

- (IBAction)buyAction:(id)sender {
    PCOrderRequestModel *orderRequest = [self createOrderModelWithSide:orderSideBuy];
    
    [PCNetworkClient makeOrderWithModel:orderRequest withCompletion:^(NSError *error, id responseObj) {
        
    }];
}

- (IBAction)sellAction:(id)sender {
    PCOrderRequestModel *orderRequest = [self createOrderModelWithSide:orderSideSell];
    
    [PCNetworkClient makeOrderWithModel:orderRequest withCompletion:^(NSError *error, id responseObj) {
        
    }];
}

- (IBAction)orderListAction:(id)sender {
    PCSymbolOrderListViewController *symbolOrder = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PCSymbolOrderListViewController"];
    symbolOrder.symbol = self.symbol;
    [self.navigationController pushViewController:symbolOrder animated:YES];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.bidsTableView) {
        return self.bidsArray.count;
    } else if (tableView == self.asksTableView) {
        return self.asksArray.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"depthCellIdentifier" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    NSArray *array;
    if (tableView == self.bidsTableView) {
        array = self.bidsArray[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithRed:103/255. green:151/255. blue:26/255. alpha:1];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:103/255. green:151/255. blue:26/255. alpha:1];
    } else if (tableView == self.asksTableView) {
        array = self.asksArray[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithRed:253/255. green:137/255. blue:139/255. alpha:1];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:253/255. green:137/255. blue:139/255. alpha:1];
    }
    if (array.count > 1) {
        cell.textLabel.text = array[0];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.4lf", [array[1] doubleValue]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
