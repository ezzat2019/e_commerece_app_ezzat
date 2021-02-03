import 'dart:async';

import 'package:e_commerece_app_ezzat/local/dao/store_dao.dart';
import 'package:e_commerece_app_ezzat/local/models/product_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'main_data_base.g.dart';

@Database(version: 1, entities: [Product])
abstract class MainDataBase extends FloorDatabase {
  StoreDao get storeDao;
}
