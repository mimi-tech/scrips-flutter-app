part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// this state ensures that the previous state is fetched when application starts
class AuthInit extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested(this.email, this.password, this.device);
  final String email;
  final String password;
  final String device;

  @override
  List<Object> get props => [email, password, device];
}

class AuthRefreshRequested extends AuthEvent {
  const AuthRefreshRequested(this.token, this.device, this.user);
  final String token;
  final String device;
  final User user;

  @override
  List<Object> get props => [token, device, user != null];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested(this.token);
  final String token;

  @override
  List<Object> get props => [token];
}

class Authenticated extends AuthEvent {
  const Authenticated(this.token, this.user);
  final String token;
  final User user;

  @override
  List<Object> get props => [token, user != null];
}

class AuthRegisterRequested extends AuthEvent {
  const AuthRegisterRequested(this.email, this.password, this.device);
  final String email;
  final String password;
  final String device;

  @override
  List<Object> get props => [email, password, device];
}

class AuthVerifyEmailRequested extends AuthEvent {
  const AuthVerifyEmailRequested(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class AuthVerifyEmailCodeRequested extends AuthEvent {
  const AuthVerifyEmailCodeRequested(this.emailCode);
  final String emailCode;

  @override
  List<Object> get props => [emailCode];
}

class AuthUpdatePasswordRequested extends AuthEvent {
  const AuthUpdatePasswordRequested(this.password);
  final String password;


  @override
  List<Object> get props => [password];
}