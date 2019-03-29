import 'package:scoped_model/scoped_model.dart';

import 'products.dart';
import 'users.dart';
import 'connected_products.dart';

class MainModel extends Model
    with ConnectedProductsModel, UsersModel, ProductsModel {}
