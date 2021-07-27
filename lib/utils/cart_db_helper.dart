import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart'; 
import '../models/Cart.dart'; 
 
class CartDatabaseHelper extends ChangeNotifier{
  static final CartDatabaseHelper _instance = new CartDatabaseHelper.internal();

  factory CartDatabaseHelper() => _instance;
  final String table         = "cart";
  final String id            = "id";
  final String productId     = "productId";
  final String name          = "name";
  final String nameEn        = "nameEn";
  final String image         = "image";
  final String price         = "price";
  final String sellingPrice  = "sellingPrice";
  final String rating        = "rating";
  final String quantity      = "quantity";


  Future <Database> get db async {
    Database _db ;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    //deleteDB();
    Directory  documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,"maindb.db");
    var ourDb = await openDatabase(path,version: 1,onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async{
    await db.execute(
      "CREATE TABLE $table($id INTEGER PRIMARY KEY AUTOINCREMENT, $productId INTEGER, $name TEXT, $nameEn TEXT, $image TEXT , $price TEXT, $sellingPrice TEXT,  $rating TEXT, $quantity INTEGER)");
  }

  /*================== CRUD ===================*/ 

  addToCart({required Map<String, dynamic> cartData}) async {
    var dbClient = await db;
    var id = cartData['productId'];
    var result = await dbClient.rawQuery(
      "SELECT id , quantity FROM $table WHERE $productId = $id"
    );
    if(result.length == 0){
      saveItem(cartData: cartData);
    }else {
      int itemId = result[0]['id'] as int;
      int quantity = result[0]['quantity'] as int ;
      cartData['quantity'] += quantity;
      updateQuantity(cartData: cartData, itemId: itemId);
    }

  }


  // INSERTIONG
  Future <int> saveItem({required Map<String, dynamic> cartData}) async{
    var dbClient = await db; 
    try{
      int item = await dbClient.insert('$table', cartData);
      notifyListeners();
      return item;
    }catch(e){ 
      print("problem Insert item === ${e}");
      throw(e);
    } 
  }

  // Selecting
  Future<List> getItems() async{
    var dbclient = await db;
    try{ 
      List<Map<String, dynamic>> maps = await dbclient.query("$table",columns: ["$id","$productId","$name","$nameEn", "$image","$price","$sellingPrice","$rating","$quantity"]);
      List<Cart> products = [];
      if(maps.length > 0){
        for(int i = 0; i < maps.length; i++){
          products.add(Cart.fromMap(maps[i]));
        }
      }
      return products;
    }catch(e){
      print("problem selecting all items == ${e}");
      throw(e);
    }
  }

  Future<double> getCartTotal() async{
    var dbclient = await db;
    var total = 0.0;
    var cartData = [];
    try{
      cartData = await dbclient.rawQuery("SELECT * FROM $table");
      for(var i = 0; i<cartData.length; i++){
        Cart cart = Cart.fromMap(cartData[i]);
        total += double.parse(cart.sellingPrice) * cart.quantity;
      } 
    }catch(e){
      print("problem selecting all items == ${e}");
      throw(e);
    }
    return total;
  } 


  // GETTING COUNT
  Future <int> getCount() async {
    var dbClient = await db;
    var numOfItems = 0;
    try{
        numOfItems = Sqflite.firstIntValue(
          await dbClient.rawQuery("SELECT COUNT(*) FROM $table")
        )!;
      }catch(e){
        print("problem getting count == ${e}");
        throw(e);
      }
    return numOfItems;
  }


  // DELETEING ITEM
  Future<int> deleteItem(int itemId) async { 
    var dbClient = await db;
    try{
      int deleteItem = await dbClient.delete("$table",where: "$id = ?" , whereArgs: [itemId] );
      notifyListeners();
      return deleteItem;
    }catch(e){
      print("problem deleteing Item == ${e}");
      throw(e);
    }
  }
 
  // UPDATING 
  Future <int> updateQuantity({required Map<String, dynamic> cartData, required int itemId}) async {
    var dbClient = await db;
    print(cartData['quantity']);
    try{
      int updateItem =  await dbClient.update(table, cartData,
        where: '$id = ?', whereArgs: [itemId]);
      notifyListeners();
      return updateItem;
    }catch(e){
      print("problem updating Item quantity == ${e}");
      throw(e);
    }
  }  

  // DELETEING DATABASE
  deleteDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'maindb.db');
    try{
      await deleteDatabase(path);
    }catch(e){
      print("problem deleting database == ${e}");
      throw(e);
    }
  }

  // CLOSING CONNECTION
  Future close () async {
    var dbClient = await db;
    return dbClient.close();
  }


  CartDatabaseHelper.internal();
}