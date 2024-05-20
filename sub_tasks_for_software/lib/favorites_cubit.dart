import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:frist_pages/core/model/dataBase.dart';
import 'package:frist_pages/core/model/favorite.dart';
import 'package:frist_pages/core/model/product.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  DataBaseHandler db = DataBaseHandler();

  void loadUserFavoriteProducts(int userId) async {
    emit(FavoriteLoadingState());
    List<Product> userFavorites = await db.userFavoriteProducts(userId);
    emit(FavoriteLoadedState(userFavorites));
  }

  void userAddToFavorites(Favorite f) async {
    emit(FavoriteLoadingState());
    await db.addToFavorites(f);
    List<Product> userFavorites = await db.userFavoriteProducts(f.u_id);
    emit(FavoriteLoadedState(userFavorites));
  }

  void userRemoveFromFavorites(int userId, int productId) async {
    emit(FavoriteLoadingState());
    await db.daleteFromFavorites(userId, productId);
    List<Product> userFavorites = await db.userFavoriteProducts(userId);
    emit(FavoriteLoadedState(userFavorites));
  }
}
