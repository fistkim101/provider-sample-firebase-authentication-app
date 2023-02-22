import 'package:equatable/equatable.dart';
import 'package:provider_sample_firebase_authentication_app/enums/process_status_type.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';

class SignUpState extends Equatable {
  final ProcessStatusType statusType;
  final CustomError customError;

  @override
  List<Object> get props => [statusType, customError];

  const SignUpState({
    required this.statusType,
    required this.customError,
  });

  factory SignUpState.initial() {
    return SignUpState(
        statusType: ProcessStatusType.initial, customError: CustomError());
  }

  @override
  String toString() {
    return 'SignUpState{statusType: $statusType, customError: $customError}';
  }

  SignUpState copyWith({
    ProcessStatusType? statusType,
    CustomError? customError,
  }) {
    return SignUpState(
      statusType: statusType ?? this.statusType,
      customError: customError ?? this.customError,
    );
  }
}
