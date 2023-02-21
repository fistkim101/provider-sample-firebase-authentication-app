import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import '../../enums/enums.dart';

class AuthState extends Equatable {
  final AuthStatusType authStatusType;
  final fbAuth.User? user;

  const AuthState({
    required this.authStatusType,
    this.user,
  });

  factory AuthState.initial() {
    return const AuthState(authStatusType: AuthStatusType.unknown);
  }

  @override
  List<Object?> get props => [authStatusType, user];

  @override
  String toString() {
    return 'AuthState{' +
        ' authStatusType: $authStatusType,' +
        ' user: $user,' +
        '}';
  }

  AuthState copyWith({
    AuthStatusType? authStatusType,
    fbAuth.User? user,
  }) {
    return AuthState(
      authStatusType: authStatusType ?? this.authStatusType,
      user: user ?? this.user,
    );
  }
}
