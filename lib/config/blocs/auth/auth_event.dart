part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnChangeStatusViewInfo extends AuthEvent {
  final bool? viewInfoSearch;
  final bool? viewInfoCapas;

  const OnChangeStatusViewInfo({this.viewInfoSearch, this.viewInfoCapas});
}

class OnChangeStatusViewInfoDetails extends AuthEvent {
  const OnChangeStatusViewInfoDetails();
}
