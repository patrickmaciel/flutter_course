import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import 'connected_products.dart';

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return List.from(products.where((Product product) => product.isFavorite));
    }
    return List.from(products);
  }

  int get selectedProductIndex {
    return productIndexSelected;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }

    return products[selectedProductIndex];
  }

  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userEmail: authenticatedUser.email,
      userId: authenticatedUser.id,
    );
    products.add(newProduct);
    productIndexSelected = null;
    notifyListeners();
  }

  void updateProduct(
      String title, String description, String image, double price) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    products[productIndexSelected] = updatedProduct;
    productIndexSelected = null;
    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(productIndexSelected);
    productIndexSelected = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    productIndexSelected = index;
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = products[productIndexSelected].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavoriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    products[selectedProductIndex] = updatedProduct;
    productIndexSelected = null;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
    productIndexSelected = null;
  }
}
