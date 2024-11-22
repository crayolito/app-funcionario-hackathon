import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<OnChangeStatusViewInfo>((event, emit) {
      emit(state.copyWith(
        viewInfoSearch: event.viewInfoSearch ?? state.viewInfoSearch,
        viewInfoCapas: event.viewInfoCapas ?? state.viewInfoCapas,
      ));
    });

    on<OnChangeStatusViewInfoDetails>((event, emit) {
      emit(state.copyWith(viewInfoDetails: !state.viewInfoDetails));
    });
  }
}
