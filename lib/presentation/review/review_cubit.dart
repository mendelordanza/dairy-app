import 'package:bloc/bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:meta/meta.dart';

import '../../helper/shared_prefs.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final SharedPrefs sharedPrefs;

  ReviewCubit({required this.sharedPrefs}) : super(ReviewInitial());

  showReview() async {
    final show = sharedPrefs.getShouldShowReview();
    int lastPromptTime = sharedPrefs.getLastReview() ?? 0;
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (show && currentTime - lastPromptTime >= 7 * 24 * 60 * 60 * 1000) {
      final InAppReview inAppReview = InAppReview.instance;
      if (await inAppReview.isAvailable()) {
        inAppReview.requestReview();
        sharedPrefs.setShouldShowReview(false);
        sharedPrefs.setLastReview(currentTime);
      }
    }
  }
}
