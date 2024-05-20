import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:frist_pages/core/model/dataBase.dart';
import 'package:frist_pages/core/model/favorite.dart';
import 'package:frist_pages/core/model/product.dart';
import 'package:frist_pages/core/model/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  int? userId;
  DataBaseHandler db=DataBaseHandler();
  

  UserCubit() : super(UserInitialState());
  

  Future<void> signUp(User user) async {
    try {
      User signedUpUser = await db.signUp(user);
      emit(UserSingUpState());
    } catch (e) {
      emit(UserErrorState('Failed to sign up'));
    }
  }


  Future<void>login(String email, String password) async {
    try {
      int userId = await db.login(email, password);
      if (userId != 0) {
        emit(UserLoginDoneState(userId));
      } else {
        emit(UserErrorState('Invalid email or password'));
      }
    } catch (e) {
      emit(UserErrorState('Failed to log in'));
    }
  }
  
}
