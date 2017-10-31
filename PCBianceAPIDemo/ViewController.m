//
//  ViewController.m
//  PCBianceAPIDemo
//
//  Created by peichuang on 2017/10/15.
//  Copyright © 2017年 peichuang. All rights reserved.
//

#import "ViewController.h"
#import "PCSymbolDetailViewController.h"
#import "PCNetworkClient.h"
#import "PCNetworkClient+General.h"
#import "PCNetworkClient+MarketData.h"
#import "PCNetworkClient+Account.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *symbolListArray;
@property (copy, nonatomic) NSArray *tickersListArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupData];
}

- (void)setupData
{
    [self loadData];
}

- (void)loadData
{
    [PCNetworkClient lastPriceForAllSymbolWithCompletion:^(NSError *error, NSArray *responseObj) {
        self.symbolListArray = responseObj;
        [self.tableView reloadData];
    }];
    [PCNetworkClient allBookTickersWithCompletion:^(NSError *error, id responseObj) {
        self.tickersListArray = responseObj;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.symbolListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demoCellIdentifier" forIndexPath:indexPath];
    NSDictionary *dict = self.symbolListArray[indexPath.row];
    cell.textLabel.text = dict[@"symbol"];
    cell.detailTextLabel.text = dict[@"price"];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.symbolListArray[indexPath.row];
    
    PCSymbolDetailViewController *symbolDetail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PCSymbolDetailViewController"];
    symbolDetail.symbol = dict[@"symbol"];
    [self.navigationController pushViewController:symbolDetail animated:YES];
}

@end
