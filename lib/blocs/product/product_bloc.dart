import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      try {
        emit(ProductLoading());

        final products = await productRepository.fetchProducts(limit: event.limit, skip: event.skip);
        emit(ProductLoaded(products: products, hasMore: products.length >= event.limit));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
