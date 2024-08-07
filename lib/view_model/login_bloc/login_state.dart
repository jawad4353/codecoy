part of 'login_bloc.dart';

abstract class LoginState extends Equatable{
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}


class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLodedState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginApiErrorState extends LoginState{
  final String errorMessage;
  const LoginApiErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class ForgotPasswordLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordLoadedState extends LoginState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordErrorState extends LoginState {
  @override
  List<Object> get props => [];
}

