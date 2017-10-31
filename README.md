# BinanceAPIForOC

binance-oc-api is a lightweight Object-C library for interacting with the [Binance API](https://www.binance.com/restapipub.html), providing complete API coverage, and supporting  asynchronous requests.

## Features
* Support for synchronous and asynchronous REST requests to all [General](https://www.binance.com/restapipub.html#user-content-general-endpoints), [Market Data](https://www.binance.com/restapipub.html#user-content-market-data-endpoints), [Account](https://www.binance.com/restapipub.html#user-content-account-endpoints) endpoints.

## Examples

### Getting Started

There are three main client classes that can be used to interact with the API:

 [`PCNetworkClient`], an asynchronous [Binance API](https://www.binance.com/restapipub.html) client;

```Object-C
[PCNetworkClient setupApiKey:@"" apiSecret:@""];
[PCNetworkClient lastPriceForAllSymbolWithCompletion:^(NSError *error, NSArray *responseObj) {
    self.symbolListArray = responseObj;
    [self.tableView reloadData];
}];
```

