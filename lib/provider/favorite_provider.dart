import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteNotifier extends StateNotifier<bool> {
  FavoriteNotifier() : super(false);

  void change() {
    state = !state;
  }
}