import 'package:flutter_riverpod/flutter_riverpod.dart';
class CounterProvider extends Notifier<double> {
  @override
  double build() {
    return 0;
  }
}