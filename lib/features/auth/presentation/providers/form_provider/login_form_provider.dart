//! 3 - StateNotifierProvider - Which is consumed outside
import '../provider.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});
