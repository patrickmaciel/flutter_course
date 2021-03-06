import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  int _productIndexSelected;
  User _authenticatedUser;
  bool _isLoading = false;

  Future<Null> addProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://ovicio.com.br/wp-content/uploads/dragon-ball-super-vegeta.jpeg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
    };
    return http
        .post('https://flutter-products-bd653.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
      _isLoading = false;
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          price: price,
          image: image,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      notifyListeners();
    });
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return List.from(
          _products.where((Product product) => product.isFavorite));
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _productIndexSelected;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }

    return _products[selectedProductIndex];
  }

  Future<Null> updateProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    final Map<String, dynamic> updateDate = {
      'title': title,
      'description': description,
      'price': price,
      'image':
          'https://ovicio.com.br/wp-content/uploads/dragon-ball-super-vegeta.jpeg',
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId,
    };

    return http
        .put(
            'https://flutter-products-bd653.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updateDate))
        .then(
      (http.Response response) {
        _isLoading = false;
        final Product updatedProduct = Product(
            id: selectedProduct.id,
            title: title,
            description: description,
            price: price,
            image: image,
            userEmail: selectedProduct.userEmail,
            userId: selectedProduct.userId);
        _products[_productIndexSelected] = updatedProduct;
        notifyListeners();
      },
    );
  }

  void deleteProduct() {
    _products.removeAt(_productIndexSelected);
    notifyListeners();
  }

  void selectProduct(int index) {
    _productIndexSelected = index;
    if (index != null) {
      notifyListeners();
    }
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite =
        _products[_productIndexSelected].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavoriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
    _productIndexSelected = null;
  }

  void fetchProducts() {
    _isLoading = true;
    notifyListeners();
    http
        .get('https://flutter-products-bd653.firebaseio.com/products.json')
        .then((http.Response response) {
      final List<Product> fetchProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          image: productData['image'],
          userId: productData['userId'],
          userEmail: productData['userEmail'],
          price: productData['price'],
        );
        fetchProductList.add(product);
      });
      _products = fetchProductList;
      _isLoading = false;
      notifyListeners();
    });
  }
}

mixin UsersModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = new User(id: 1, email: email, password: password);
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
