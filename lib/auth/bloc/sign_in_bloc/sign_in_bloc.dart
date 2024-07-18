import 'package:a_group/auth/auth_repository/auth_repository.dart';
import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _userRepository;

  SignInBloc(this._userRepository) : super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
      } catch (e) {
        emit(SignInFailure(error: e.toString()));
      }
    });

    on<SignOutRequired>((event, emit) async => await _userRepository.logOut());
    on<DeleteUserRequired>((event, emit) async => await _userRepository.deleteUser(event.user));
  }
}
