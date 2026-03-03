import 'package:get/get.dart';
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

class BasketController extends GetxController {
  // Reactive list of basket items
  var items = <BasketItem>[].obs;

  void addToBasket(Product product, int quantity) {
    int index = items.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      items[index].quantity += quantity;
      items.refresh(); // Manually trigger update for list item change
    } else {
      items.add(BasketItem(product: product, quantity: quantity));
    }
  }

  void removeAt(int index) {
    items.removeAt(index);
  }

  void clearBasket() {
    items.clear();
  }

  double get totalAmount {
    double total = 0;
    for (var item in items) {
      total += item.totalItemPrice;
    }
    return total;
  }
}

class ProductController extends GetxController {
  // Reactive lists of products
  var recommended = recommendedProducts.obs;
  var filtered = filteredProducts.obs;

  void toggleFavorite(String productId) {
    // Update in recommended list
    int recIndex = recommended.indexWhere((p) => p.id == productId);
    if (recIndex != -1) {
      recommended[recIndex] = recommended[recIndex].copyWith(
        isFavorite: !recommended[recIndex].isFavorite,
      );
    }

    // Update in filtered list
    int filtIndex = filtered.indexWhere((p) => p.id == productId);
    if (filtIndex != -1) {
      filtered[filtIndex] = filtered[filtIndex].copyWith(
        isFavorite: !filtered[filtIndex].isFavorite,
      );
    }
  }

  bool isFavorite(String productId) {
    final all = [...recommended, ...filtered];
    return all.firstWhere((p) => p.id == productId).isFavorite;
  }
}