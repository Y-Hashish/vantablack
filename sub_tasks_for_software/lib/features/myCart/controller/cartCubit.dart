// cart_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_pages/core/model/product.dart';
import 'package:frist_pages/core/model/dataBase.dart';

import 'package:frist_pages/features/myCart/view/page/cart_page.dart';
import 'cartState.dart';


class CartCubit extends Cubit<CartState> {
  final DataBaseHandler _databaseHandler;
  final int userId;

  CartCubit(this._databaseHandler, this.userId) : super(CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final cartItems = await _databaseHandler.showCart(userId);
      emit(CartLoaded(cartItems.cast<CartItem>()));
    } catch (e) {
      emit(CartError('Failed to load cart.'));
    }
  }

  Future<void> addToCart(Product product) async {
  if (state is CartLoaded) {
    final List<CartItem> updatedCart = List.from((state as CartLoaded).cartItems);
    final int index = updatedCart.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      await _databaseHandler.updateCartItemQuantity(1, userId, product.id!);
      updatedCart[index] = CartItem(product: product, quantity: updatedCart[index].quantity + 1);
    } else {
      await _databaseHandler.addToCart(userId, product.id!, 1); // Ensure addToCart inserts the item if not present
      updatedCart.add(CartItem(product: product, quantity: 1));
    }
    emit(CartLoaded(updatedCart));
  } else {
    await _databaseHandler.addToCart(userId, product.id!, 1);
    emit(CartLoaded([CartItem(product: product, quantity: 1)]));
  }
}


  Future<void> removeFromCart(Product product) async {
    if (state is CartLoaded) {
      final List<CartItem> updatedCart = List.from((state as CartLoaded).cartItems);
      await _databaseHandler.deleteFromcart(userId, product.id!);
      updatedCart.removeWhere((item) => item.product.id == product.id);
      emit(CartLoaded(updatedCart));
    }
  }

  Future<void> updateQuantity(Product product, int quantity) async {
    if (state is CartLoaded) {
      final List<CartItem> updatedCart = List.from((state as CartLoaded).cartItems);
      final int index = updatedCart.indexWhere((item) => item.product.id == product.id);

      if (index != -1 && quantity > 0) {
        await _databaseHandler.updateCartItemQuantity(quantity - updatedCart[index].quantity, userId, product.id!);
        updatedCart[index] = CartItem(product: product, quantity: quantity);
      } else if (index != -1 && quantity == 0) {
        await _databaseHandler.deleteFromcart(userId, product.id!);
        updatedCart.removeAt(index);
      }
      emit(CartLoaded(updatedCart));
    }
  }

  Future<void> clearCart() async {
    // Clear cart implementation is not provided in the original code
    // Assuming clearing the cart would involve setting all item quantities to 0 or removing all items
    if (state is CartLoaded) {
      final List<CartItem> updatedCart = [];
      // Logic to clear the cart in the database should be added here
      emit(CartLoaded(updatedCart));
    }
  }
}
