import 'package:flutter/widgets.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import 'signin_state.dart';

class SignInProvider with ChangeNotifier {
  SignInState _state = SignInState.initial();

  SignInState get state => _state;

  final AuthRepository authRepository;

  SignInProvider({
    required this.authRepository,
  });

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _state = _state.copyWith(signInStatusType: SignInStatusType.submitting);
    notifyListeners();

    try {
      await authRepository.signIn(email: email, password: password);
      _state = _state.copyWith(signInStatusType: SignInStatusType.success);
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(signInStatusType: SignInStatusType.error);
      notifyListeners();
      rethrow;
    }
  }
}
