import 'package:state_notifier/state_notifier.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import 'profile_state.dart';

class ProfileProvider extends StateNotifier<ProfileState> with LocatorMixin {
  ProfileProvider() : super(ProfileState.initial());

  Future<void> getProfile({
    required String uid,
  }) async {
    state = state.copyWith(processStatusType: ProcessStatusType.processing);
    final UserRepository userRepository = read<UserRepository>();
    try {
      User user = await userRepository.getProfile(uid: uid);
      state = state.copyWith(
          processStatusType: ProcessStatusType.success, user: user);
    } on CustomError catch (e) {
      state = state.copyWith(
          processStatusType: ProcessStatusType.error, customError: e);
    }
  }
}
// class ProfileProvider with ChangeNotifier {
//   final UserRepository userRepository;
//
//   ProfileProvider({
//     required this.userRepository,
//   });
//
//   ProfileState _state = ProfileState.initial();
//
//   ProfileState get state => _state;
//
//   Future<void> getProfile({required String uid}) async {
//     _state = _state.copyWith(processStatusType: ProcessStatusType.processing);
//     notifyListeners();
//
//     try {
//       final User user = await userRepository.getProfile(uid: uid);
//       _state = _state.copyWith(
//           processStatusType: ProcessStatusType.success, user: user);
//       notifyListeners();
//     } on CustomError catch (e) {
//       _state = _state.copyWith(
//           processStatusType: ProcessStatusType.error, customError: e);
//       notifyListeners();
//     }
//   }
//
// }
