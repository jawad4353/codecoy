part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginApiEvent extends LoginEvent{
  final BuildContext context;
  final Map map;
  final bool fromSplash;
  final bool rememberMe;
  const LoginApiEvent( this.map, this.context, this.fromSplash,this.rememberMe);
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