import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/home_view.dart';
import '../view/home_view_model.dart';
import 'custom_textfield.dart';

class StockMarketSearchField extends ConsumerWidget {
  const StockMarketSearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeViewModelNotifier.notifier).ref = ref;
    final notifier = ref.watch(homeViewModelNotifier.notifier);
    final isSearching = ref.watch(homeViewModelNotifier);

    return AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: isSearching
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 40,
                  child: Material(
                      shape: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomTextfield(
                          hintText: 'Search here',
                          autoFocus: true,
                          filled: false,
                          controller: notifier.searchTerm,
                          onChanged: (value) =>
                              ref.refresh(homeViewFutureProvider),
                        ),
                      )),
                ),
              )
            : Container());
  }
}
