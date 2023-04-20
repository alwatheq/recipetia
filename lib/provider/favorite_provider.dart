import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteNotifier extends StateNotifier<bool> {
  FavoriteNotifier(super.state);

  void change() {
    state = !state;
  }
}