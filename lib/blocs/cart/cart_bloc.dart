import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Map<int, Product> cartItems = {};
  final Map<int, int> quantities = {};

  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      int productId = event.product.id;

      if (cartItems.containsKey(productId)) {
        quantities[productId] = (quantities[productId] ?? 0) + 1;
      } else {
        cartItems[productId] = event.product;
        quantities[productId] = 1;
      }
      emit(CartUpdated(cartItems: Map.from(cartItems), quantities: Map.from(quantities), totalPrice: _calculateTotal()));
    });

    on<RemoveFromCart>((event, emit) {
      int productId = event.product.id;

      if (cartItems.containsKey(productId)) {
        if (quantities[productId]! > 1) {
          quantities[productId] = quantities[productId]! - 1;
        } else {
          cartItems.remove(productId);
          quantities.remove(productId);
        }
      }

      if (cartItems.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartUpdated(cartItems: Map.from(cartItems), quantities: Map.from(quantities), totalPrice: _calculateTotal()));
      }
    });
  }

  double _calculateTotal() {
    return cartItems.entries.fold(
        0,
            (sum, entry) => sum + (entry.value.finalPrice * quantities[entry.key]!),
    );
  }
}