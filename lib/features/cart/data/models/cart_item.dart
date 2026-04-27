import 'package:beer_store_app/features/products/data/models/product_model.dart';

class CartItem {
  final ProductModel product;
  int qty;

  CartItem({
    required this.product,
    this.qty = 1,
  });

  double get total => product.price * qty;
}