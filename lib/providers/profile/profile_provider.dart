import 'package:flutter/widgets.dart';
import 'package:provider_sample_firebase_authentication_app/enums/enums.dart';
import 'package:provider_sample_firebase_authentication_app/models/custom_error.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';
import 'profile_state.dart';

class ProfileProvider with ChangeNotifier {
  final UserRepository userRepository;

  ProfileProvider({
    required this.userRepository,
  });

  ProfileState _state = ProfileState.initial();

  ProfileState get state => _state;

  Future<void> getProfile({required String uid}) async {
    _state = _state.copyWith(processStatusType: ProcessStatusType.processing);
    notifyListeners();

    try {
      final User user = await userRepository.getProfile(uid: uid);
      _state = _state.copyWith(
          processStatusType: ProcessStatusType.success, user: user);
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(
          processStatusType: ProcessStatusType.error, customError: e);
      notifyListeners();
    }
  }

// Future<void> getProfile({required String uid}) async {
//   _state = _state.copyWith(profileStatus: ProfileStatus.loading);
//   notifyListeners();
//
//   try {
//     final User user = await profileRepository.getProfile(uid: uid);
//
//     _state = _state.copyWith(profileStatus: ProfileStatus.loaded, user: user);
//     notifyListeners();
//   } on CustomError catch (e) {
//     _state = _state.copyWith(profileStatus: ProfileStatus.error, error: e);
//     notifyListeners();
//   }
// }

}
