import '../../models/product_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final Map<int, Product> cartItems;
  final Map<int, int> quantities;
  final double totalPrice;

  CartUpdated({
    required this.cartItems,
    required this.quantities,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [cartItems, quantities, totalPrice];
}

class CartEmpty extends CartState {}