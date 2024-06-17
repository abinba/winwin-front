import 'package:flutter/foundation.dart';
import 'package:swipe_cards/swipe_cards.dart';

class MatchEngineProvider extends ChangeNotifier {
  MatchEngine _matchEngine = MatchEngine(swipeItems: []);

  MatchEngine get matchEngine => _matchEngine;

  void setSwipeItems(List<SwipeItem> items) {
    _matchEngine = MatchEngine(swipeItems: items);
    notifyListeners();
  }

  void clearItems() {
    _matchEngine = MatchEngine(swipeItems: []);
    notifyListeners();
  }
}
