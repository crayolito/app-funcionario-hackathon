part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool viewInfoSearch;
  final bool viewInfoCapas;

  final bool viewInfoDetails;

  const AuthState(
      {this.viewInfoSearch = false,
      this.viewInfoCapas = false,
      this.viewInfoDetails = false});

  AuthState copyWith({
    bool? viewInfoSearch,
    bool? viewInfoCapas,
    bool? viewInfoDetails,
  }) {
    return AuthState(
      viewInfoSearch: viewInfoSearch ?? this.viewInfoSearch,
      viewInfoCapas: viewInfoCapas ?? this.viewInfoCapas,
      viewInfoDetails: viewInfoDetails ?? this.viewInfoDetails,
    );
  }

  @override
  List<Object> get props => [
        viewInfoSearch,
        viewInfoCapas,
        viewInfoDetails,
      ];
}
