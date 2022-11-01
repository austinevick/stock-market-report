import 'package:flutter/material.dart';
import 'package:flutter_marketstack_app/model/stock_exchange_data_model.dart';
import 'package:flutter_marketstack_app/view_model/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/constant.dart';

class StockMarketList extends ConsumerWidget {
  final StockExchangeDataModel data;
  const StockMarketList({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async =>
            ref.read(homeViewModelNotifier.notifier).getStockExchangeData(),
        child: ListView.builder(
          itemCount: data.data!.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              shape: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: lightGreen,
                        child: Text(
                          data.data![i].name!.substring(0, 1),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                    subtitle: Text(data.data![i].stockExchange!.name!),
                    title: Text(data.data![i].name!),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
