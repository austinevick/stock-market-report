import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marketstack_app/common/utils.dart';
import 'package:flutter_marketstack_app/service/stock_exchange_remote_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../common/constant.dart';
import '../model/stock_exchange_data_model.dart';

final homeViewModelNotifier =
    StateNotifierProvider<HomeViewModel, bool>((_) => HomeViewModel());

class HomeViewModel extends StateNotifier<bool> {
  HomeViewModel() : super(false);
  final searchTerm = TextEditingController();
  String dateFrom = '';
  String dateTo = '';
  WidgetRef? ref;

  void setStateValue() {
    state = !state;
    searchTerm.dispose();
  }

  Stream<StockExchangeDataModel> getStockExchangeData() async* {
    try {
      final response = ref!
          .watch(stockExchangeRemoteServiceProvider)
          .getStockExchangeData(searchTerm.text.trim(), dateFrom, dateTo);
      yield* response;
    } on SocketException catch (_) {
      showDialogFlash(
        title: noConnection,
        content: noConnectionMessage,
        onTap: () => AppSettings.openWirelessSettings(),
      );
      rethrow;
    } on TimeoutException catch (_) {
      showDialogFlash(content: timeout);
      rethrow;
    } catch (e) {
      showDialogFlash(content: somethingwentwrong);
      rethrow;
    }
  }

  Future showDatePicker() async {
    final dateTime = await showDateRangePicker(
        saveText: 'DONE',
        context: navigatorKey.currentContext!,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    dateFrom = DateFormat('yyyy-MM-dd').format(dateTime!.start);
    dateTo = DateFormat('yyyy-MM-dd').format(dateTime.end);
    print(dateFrom);
    print(dateTo);
  }
}
