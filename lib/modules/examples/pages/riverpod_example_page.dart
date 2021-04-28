import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CountNotifier extends StateNotifier<int> {
  CountNotifier() : super(0);

  void increment() => state++;

  void decrement() => state--;

  void reset() => state = 0;
}

final counterProvider = StateNotifierProvider((ref) => CountNotifier());

class RiverpodExampleAPage extends HookWidget {
  static const PAGE_ROUTE = '/examples/riverpoda';

  @override
  Widget build(BuildContext context) {
    final counterState = useProvider(counterProvider.state);
    final counter = useProvider(counterProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('$counterState'),
            ElevatedButton(
              onPressed: () {
                counter.increment();
                // counter.increment();
              },
              child: Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () {
                counter.decrement();
                // counter.decrement();
              },
              child: Text('Decrement'),
            ),
            ElevatedButton(
              onPressed: () {
                counter.reset();
                // counter.reset();
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
