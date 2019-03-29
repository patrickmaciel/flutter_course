import 'package:scoped_model/scoped_model.dart';
import '../models/user.dart';
import 'connected_products.dart';

mixin UsersModel on ConnectedProductsModel {
  void login(String email, String password) {
    authenticatedUser = new User(id: 1, email: email, password: password);
  }
}
