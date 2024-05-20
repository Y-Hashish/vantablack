part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitialState extends UserState {}

final class UserSingUpState extends UserState {}

//final class UserLoadingState extends UserState {}

final class UserErrorState extends UserState {
   final String errorMessage;

  UserErrorState(this.errorMessage);
}

final class UserLoginDoneState extends UserState {
  int userId;
 UserLoginDoneState(this.userId);
}


final class UserLoginFailedState extends UserState {}
