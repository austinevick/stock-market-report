import 'dart:convert';

import 'package:flutter_marketstack_app/apikey.dart';
import 'package:flutter_marketstack_app/common/api.dart';
import 'package:flutter_marketstack_app/model/stock_exchange_data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final stockExchangeRemoteServiceProvider =
    Provider((_) => StockExchangeRemoteServiceImpl(Client()));

abstract class StockExchangeRemoteService {
  Stream getStockExchangeData(
      [String? searchTerm, String? dateFrom, String? dateTo]);
}

class StockExchangeRemoteServiceImpl implements StockExchangeRemoteService {
  final Client client;

  StockExchangeRemoteServiceImpl(this.client);

  @override
  Stream<StockExchangeDataModel> getStockExchangeData(
      [String? searchTerm,
      String? dateFrom,
      String? dateTo,
      int? limit = 10]) async* {
    final response = await client.get(Uri.parse(
        "${baseUrl}tickers?access_key=$apikey&limit=$limit&search=$searchTerm&date_from=$dateFrom&date_to=$dateTo")).timeout(const Duration(seconds:35));
    final data = jsonDecode(response.body);
    print(data);
    yield StockExchangeDataModel.fromJson(data);
  }
}
