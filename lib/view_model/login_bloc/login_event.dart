part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginApiEvent extends LoginEvent{
  final BuildContext context;
  final String email;
  final String password;
  final bool rememberMe;
  const LoginApiEvent( this.email, this.password, this.context,this.rememberMe);
  @override
  List<Object?> get props => [];
}


class ForgetPasswordEvent extends LoginEvent{
  final String email;
  final BuildContext context;
  const ForgetPasswordEvent(this.email,this.context);
  @override
  List<Object?> get props => throw UnimplementedError();

}