import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/foundation.dart';

import '../../enums/enums.dart';
import '../../repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthProvider with ChangeNotifier {
  AuthState _state = AuthState.initial();

  AuthState get state => _state;

  final AuthRepository authRepository;

  AuthProvider({
    required this.authRepository,
  });

  void update(fbAuth.User? user) {
    if (user != null) {
      _state = _state.copyWith(
        authStatusType: AuthStatusType.authenticated,
        user: user,
      );
    } else {
      _state = _state.copyWith(authStatusType: AuthStatusType.unAuthenticated);
    }
    notifyListeners();
  }

  void signOut() async {
    await authRepository.signOut();
  }
}
