import 'package:equatable/equatable.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';

class ProfileState extends Equatable {
  final ProcessStatusType processStatusType;
  final User user;
  final CustomError customError;

  const ProfileState({
    required this.processStatusType,
    required this.user,
    required this.customError,
  });

  factory ProfileState.initial() {
    return ProfileState(
      processStatusType: ProcessStatusType.initial,
      user: User.initialUser(),
      customError: CustomError(),
    );
  }

  @override
  List<Object> get props => [processStatusType, user, customError];

  ProfileState copyWith({
    ProcessStatusType? processStatusType,
    User? user,
    CustomError? customError,
  }) {
    return ProfileState(
      processStatusType: processStatusType ?? this.processStatusType,
      user: user ?? this.user,
      customError: customError ?? this.customError,
    );
  }
}
