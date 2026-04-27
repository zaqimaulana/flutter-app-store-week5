import 'package:flutter/material.dart';
import 'package:beer_store_app/features/cart/data/models/cart_item.dart';
import 'package:beer_store_app/features/products/data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.total);

  int get totalItems =>
      _items.fold(0, (sum, item) => sum + item.qty);

  void addToCart(ProductModel product) {
    final index = _items.indexWhere(
      (e) => e.product.id == product.id,
    );

    if (index >= 0) {
      _items[index].qty++;
    } else {
      _items.add(CartItem(product: product));
    }

    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.removeWhere(
      (e) => e.product.id == productId,
    );

    notifyListeners();
  }

  void increaseQty(int productId) {
    final item = _items.firstWhere(
      (e) => e.product.id == productId,
    );

    item.qty++;
    notifyListeners();
  }

  void decreaseQty(int productId) {
    final item = _items.firstWhere(
      (e) => e.product.id == productId,
    );

    if (item.qty > 1) {
      item.qty--;
    } else {
      removeFromCart(productId);
    }

    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}