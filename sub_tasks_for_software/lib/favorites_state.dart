part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

class FavoriteLoadingState extends FavoritesState {}

class FavoriteLoadedState extends FavoritesState {
  List<Product>userFavorites;
  FavoriteLoadedState(this.userFavorites);
}


