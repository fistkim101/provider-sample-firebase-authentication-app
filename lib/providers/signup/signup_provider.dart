import 'package:flutter/widgets.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import 'signup_state.dart';

class SignUpProvider with ChangeNotifier {
  final AuthRepository authRepository;

  SignUpProvider({
    required this.authRepository,
  });

  SignUpState _state = SignUpState.initial();

  SignUpState get state => _state;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _state = _state.copyWith(statusType: ProcessStatusType.processing);
    notifyListeners();

    try {
      await authRepository.signUp(name: name, email: email, password: password);
      _state = _state.copyWith(statusType: ProcessStatusType.success);
      notifyListeners();
    } on CustomError catch (e) {
      _state =
          _state.copyWith(statusType: ProcessStatusType.error, customError: e);
      notifyListeners();
      rethrow;
    }
  }
}
