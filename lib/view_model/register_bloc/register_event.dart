part of 'register_bloc.dart';

abstract class RegisterUserEvent extends Equatable {
  const RegisterUserEvent();
}

class RegisterUserEventApi extends RegisterUserEvent{
  final BuildContext context;
  final String email ;
  final String name ;
  final String password ;
  const RegisterUserEventApi( this.email, this.context, this.name,this.password);
  @override
  List<Object?> get props => [];
}


class RegisterVerifyEmailEvent extends RegisterUserEvent{
  final BuildContext context;
  const RegisterVerifyEmailEvent(this.context);
  @override
  List<Object?> get props => [];
}
