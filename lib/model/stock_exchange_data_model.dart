class StockExchangeDataModel {
  List<Data>? data;

  StockExchangeDataModel({this.data});

  StockExchangeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? name;
  String? symbol;
  bool? hasIntraday;
  bool? hasEod;
  dynamic country;
  StockExchange? stockExchange;

  Data(
      {this.name,
      this.symbol,
      this.hasIntraday,
      this.hasEod,
      this.country,
      this.stockExchange});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    hasIntraday = json['has_intraday'];
    hasEod = json['has_eod'];
    country = json['country'];
    stockExchange = json['stock_exchange'] != null
        ? StockExchange.fromJson(json['stock_exchange'])
        : null;
  }
}

class StockExchange {
  String? name;
  String? acronym;
  String? mic;
  String? country;
  String? countryCode;
  String? city;
  String? website;

  StockExchange(
      {this.name,
      this.acronym,
      this.mic,
      this.country,
      this.countryCode,
      this.city,
      this.website});

  StockExchange.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    acronym = json['acronym'];
    mic = json['mic'];
    country = json['country'];
    countryCode = json['country_code'];
    city = json['city'];
    website = json['website'];
  }
}
