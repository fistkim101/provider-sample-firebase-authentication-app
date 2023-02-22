import 'package:state_notifier/state_notifier.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import 'signin_state.dart';

class SignInProvider extends StateNotifier<SignInState> with LocatorMixin {
  SignInProvider() : super(SignInState.initial());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final AuthRepository authRepository = read<AuthRepository>();
    state = state.copyWith(signInStatusType: ProcessStatusType.processing);

    try {
      await authRepository.signIn(email: email, password: password);
      state = state.copyWith(signInStatusType: ProcessStatusType.success);
    } on CustomError catch (e) {
      state = state.copyWith(signInStatusType: ProcessStatusType.error);
      rethrow;
    }
  }
}

// class SignInProvider with ChangeNotifier {
//   SignInState _state = SignInState.initial();
//
//   SignInState get state => _state;
//
//   final AuthRepository authRepository;
//
//   SignInProvider({
//     required this.authRepository,
//   });
//
//   Future<void> signIn({
//     required String email,
//     required String password,
//   }) async {
//     _state = _state.copyWith(signInStatusType: ProcessStatusType.processing);
//     notifyListeners();
//
//     try {
//       await authRepository.signIn(email: email, password: password);
//       _state = _state.copyWith(signInStatusType: ProcessStatusType.success);
//       notifyListeners();
//     } on CustomError catch (e) {
//       _state = _state.copyWith(signInStatusType: ProcessStatusType.error);
//       notifyListeners();
//       rethrow;
//     }
//   }
// }
