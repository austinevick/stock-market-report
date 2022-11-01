import 'package:flutter/material.dart';
import 'package:flutter_marketstack_app/common/constant.dart';
import 'package:flutter_marketstack_app/view_model/home_view_model.dart';
import 'package:flutter_marketstack_app/widget/stock_market_error_screen.dart';
import 'package:flutter_marketstack_app/widget/stock_market_list.dart';
import 'package:flutter_marketstack_app/widget/stock_market_search_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewFutureProvider = StreamProvider(
    (ref) => ref.watch(homeViewModelNotifier.notifier).getStockExchangeData());

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeViewModelNotifier.notifier).ref = ref;
    final notifier = ref.watch(homeViewModelNotifier.notifier);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stock Market Report'),
          actions: [
            IconButton(
                onPressed: () async => notifier
                    .showDatePicker()
                    .whenComplete(() => ref.refresh(homeViewFutureProvider)),
                icon: const Icon(Icons.calendar_month)),
            IconButton(
                onPressed: () => notifier.setStateValue(),
                icon: const Icon(Icons.search))
          ],
        ),
        body: ref.watch(homeViewFutureProvider).when(
            data: (data) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const StockMarketSearchField(),
                    data.data == null
                        ? Container()
                        : StockMarketList(data: data)
                  ],
                )),
            error: (e, t) => Center(
                  child: StockMarketErrorScreen(
                      () => ref.refresh(homeViewFutureProvider)),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
