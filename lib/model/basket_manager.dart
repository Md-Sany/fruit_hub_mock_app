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
  var recommended = <Product>[].obs;
  var filtered = <Product>[].obs;
  var selectedFilterIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    recommended.value = allProducts.where((p) => p.totalSells > 100).take(5).toList();
    updateFilter(0);
  }

  void updateFilter(int index) {
    selectedFilterIndex.value = index;
    List<Product> tempList = List.from(allProducts);

    switch (index) {
      case 0:
        tempList.sort((a, b) => b.sellsLast24Hours.compareTo(a.sellsLast24Hours));
        break;
      case 1:
        tempList.sort((a, b) => b.favoriteCount.compareTo(a.favoriteCount));
        break;
      case 2:
        tempList.sort((a, b) => b.addedDate.compareTo(a.addedDate));
        break;
      case 3:
        tempList.sort((a, b) => b.totalSells.compareTo(a.totalSells));
        break;
    }
    filtered.value = tempList;
  }

  void toggleFavorite(String productId) {
    int sourceIndex = allProducts.indexWhere((p) => p.id == productId);

    if (sourceIndex != -1) {
      final updatedProduct = allProducts[sourceIndex].copyWith(
        isFavorite: !allProducts[sourceIndex].isFavorite,
      );

      allProducts[sourceIndex] = updatedProduct;

      int recIdx = recommended.indexWhere((p) => p.id == productId);
      if (recIdx != -1) recommended[recIdx] = updatedProduct;

      int filtIdx = filtered.indexWhere((p) => p.id == productId);
      if (filtIdx != -1) filtered[filtIdx] = updatedProduct;

      recommended.refresh();
      filtered.refresh();
    }
  }

  bool isFavorite(String productId) {
    final inRec = recommended.any((p) => p.id == productId && p.isFavorite);
    final inFilt = filtered.any((p) => p.id == productId && p.isFavorite);

    final inMaster = allProducts.firstWhere((p) => p.id == productId).isFavorite;

    return inRec || inFilt || inMaster;
  }
}