import 'product.dart';

class BasketItem {
  final Product product;
  int quantity;

  BasketItem({required this.product, this.quantity = 1});

  double get totalItemPrice {
    double price = double.parse(product.price.replaceAll(',', ''));
    return price * quantity;
  }
}

class BasketManager {
  static final BasketManager _instance = BasketManager._internal();
  factory BasketManager() => _instance;
  BasketManager._internal();

  final List<BasketItem> _items = [];

  List<BasketItem> get items => _items;

  void addToBasket(Product product, int quantity) {
    int index = _items.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(BasketItem(product: product, quantity: quantity));
    }
  }

  void removeAt(int index) {
    _items.removeAt(index);
  }

  void clearBasket() {
    _items.clear();
  }

  double get totalAmount {
    double total = 0;
    for (var item in _items) {
      double price = double.parse(item.product.price.replaceAll(',', ''));
      total += price * item.quantity;
    }
    return total;
  }
}

class ProductManager {
  static final ProductManager _instance = ProductManager._internal();
  factory ProductManager() => _instance;
  ProductManager._internal();

  // Reference the global lists directly
  void toggleFavorite(String productId) {
    // Update in recommendedProducts
    final recIndex = recommendedProducts.indexWhere((p) => p.id == productId);
    if (recIndex != -1) {
      recommendedProducts[recIndex] = recommendedProducts[recIndex].copyWith(
        isFavorite: !recommendedProducts[recIndex].isFavorite,
      );
    }

    // Update in filteredProducts
    final filtIndex = filteredProducts.indexWhere((p) => p.id == productId);
    if (filtIndex != -1) {
      filteredProducts[filtIndex] = filteredProducts[filtIndex].copyWith(
        isFavorite: !filteredProducts[filtIndex].isFavorite,
      );
    }
  }

  bool isFavorite(String productId) {
    // Check both lists for the status
    final allProducts = [...recommendedProducts, ...filteredProducts];
    return allProducts.firstWhere((p) => p.id == productId).isFavorite;
  }
}