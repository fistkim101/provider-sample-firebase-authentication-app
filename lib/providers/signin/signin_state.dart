import 'package:equatable/equatable.dart';
import 'package:provider_sample_firebase_authentication_app/enums/signin_status_type.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';

class SignInState extends Equatable {
  final SignInStatusType signInStatusType;
  final CustomError customError;

  @override
  List<Object> get props => [signInStatusType, customError];

  factory SignInState.initial() {
    return SignInState(
      signInStatusType: SignInStatusType.initial,
      customError: CustomError(),
    );
  }

  const SignInState({
    required this.signInStatusType,
    required this.customError,
  });

  @override
  String toString() {
    return 'SignInState{' +
        ' signInStatusType: $signInStatusType,' +
        ' customError: $customError,' +
        '}';
  }

  SignInState copyWith({
    SignInStatusType? signInStatusType,
    CustomError? customError,
  }) {
    return SignInState(
      signInStatusType: signInStatusType ?? this.signInStatusType,
      customError: customError ?? this.customError,
    );
  }
}
