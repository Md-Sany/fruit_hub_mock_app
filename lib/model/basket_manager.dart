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
  var items = <BasketItem>[].obs;

  void addToBasket(Product product, int quantity) {
    int index = items.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      items[index].quantity += quantity;
      items.refresh();
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
  // Observables for the UI
  var recommended = <Product>[].obs;
  var filtered = <Product>[].obs;

  // Track the active filter index
  var selectedFilterIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize recommended with top sellers
    recommended.value = allProducts.where((p) => p.totalSells > 100).take(5).toList();
    // Start with the "Hottest" filter applied
    updateFilter(0);
  }

  // Logic to automatically sort based on the selected tab
  void updateFilter(int index) {
    selectedFilterIndex.value = index;
    List<Product> tempList = List.from(allProducts);

    switch (index) {
      case 0: // Hottest: Sort by sales in last 24 hours
        tempList.sort((a, b) => b.sellsLast24Hours.compareTo(a.sellsLast24Hours));
        break;
      case 1: // Popular: Sort by favorite count
        tempList.sort((a, b) => b.favoriteCount.compareTo(a.favoriteCount));
        break;
      case 2: // New Combo: Sort by most recently added
        tempList.sort((a, b) => b.addedDate.compareTo(a.addedDate));
        break;
      case 3: // Top: Sort by total lifetime sales
        tempList.sort((a, b) => b.totalSells.compareTo(a.totalSells));
        break;
    }
    filtered.value = tempList;
  }

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

    // Also update the source data (optional but good for consistency)
    int sourceIndex = allProducts.indexWhere((p) => p.id == productId);
    if (sourceIndex != -1) {
      allProducts[sourceIndex] = allProducts[sourceIndex].copyWith(
        isFavorite: !allProducts[sourceIndex].isFavorite,
      );
    }
  }

  bool isFavorite(String productId) {
    return allProducts.firstWhere((p) => p.id == productId).isFavorite;
  }
}