import 'product.dart';

class BasketItem {
  final Product product;
  int quantity;

  BasketItem({required this.product, this.quantity = 1});
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