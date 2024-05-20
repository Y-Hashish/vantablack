// ignore_for_file: constant_identifier_names, unused_local_variable, non_constant_identifier_names


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:frist_pages/core/model/cartProduct.dart';
import 'package:frist_pages/core/model/favorite.dart';
import 'package:frist_pages/core/model/product.dart';
import 'package:frist_pages/core/model/shopingItems.dart';
import 'package:frist_pages/core/model/shopping.dart';
import 'package:frist_pages/core/model/user.dart';

class DataBaseHandler {
  static Database? _db ;

  static const String dbname="proj.db";
  static const int version=1;


  
  // Table names
  static const String users_table = "users";
  static const String products_table = "products";
  static const String favorites_table = "favorites";
  static const String shopping_table = "shopping";
  static const String shopping_items_table = "shopping_items";
  

  // Column names for users table
  static const String user_id = "user_id";
  static const String user_name = "user_name";
  static const String password = "password";
  static const String email = "email";
  static const String phone = "phone";
  static const String address = "address";


  // Column names for products table
  static const String product_id = "product_id";
  static const String product_name = "product_name";
  static const String description = "description";
  static const String category = "category";
  static const String price = "price";
  static const String isFeatured = "isFeatured";
  static const String image = "image";


  // Column names for favorites table
  static const String favorite_id = "favorite_id";
  static const String favorites_user_id_fk = "user_id";
  static const String favorites_product_id_fk = "product_id";

  // Column names for shopping table
  static const String shopping_id = "shopping_id";
  static const String user_id_fk = "user_id";
  static const String isOrdard = "isOrdered"; //0
  static const String shippingAddress = "shippingAddress";
  static const String totalPrice = "totalPrice";
  static const String isFinished = "isFinished"; //0


  // Column names for shopping_items table
  static const String shopping_items_id = "shopping_items_id";
  static const String shopping_id_fk = "shopping_id";
  static const String product_id_fk = "product_id";
  static const String quantity = "quantity";



  Future<Database?> get db async {
    if (_db == null) {
      String path=join(await getDatabasesPath(),dbname);
      _db=await openDatabase(path , version: version , onCreate:_onCreate , onUpgrade:_onUpgrade );
    }
    return _db;
  }



    Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $users_table (
        $user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        $user_name TEXT,
        $password TEXT,
        $email TEXT UNIQUE,
        $phone TEXT,
        $address TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $products_table (
        $product_id INTEGER PRIMARY KEY,
        $product_name TEXT,
        $description TEXT,
        $category TEXT,
        $price REAL,
        $isFeatured INTEGER,
        $image TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $favorites_table (
        $favorite_id INTEGER PRIMARY KEY,
        $favorites_user_id_fk INTEGER,
        $favorites_product_id_fk INTEGER,
        FOREIGN KEY ($favorites_user_id_fk) REFERENCES $users_table($user_id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        FOREIGN KEY ($favorites_product_id_fk) REFERENCES $products_table($product_id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE $shopping_table (
        $shopping_id INTEGER PRIMARY KEY,
        $user_id_fk INTEGER,
        $isOrdard INTEGER DEFAULT 0,
        $shippingAddress TEXT,
        $totalPrice REAL,
        $isFinished INTEGER DEFAULT 0,
        FOREIGN KEY ($user_id_fk) REFERENCES $users_table($user_id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE $shopping_items_table (
        $shopping_items_id INTEGER PRIMARY KEY,
        $shopping_id_fk INTEGER,
        $product_id_fk INTEGER,
        $quantity INTEGER,
        FOREIGN KEY ($shopping_id_fk) REFERENCES $shopping_table($shopping_id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        FOREIGN KEY ($product_id_fk) REFERENCES $products_table($product_id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
      )
    ''');
  }

   _onUpgrade(Database db , int oldversion , int newversion) async {
     
  }




  //////////////////////// user functions ////////////////////////////
  // Future<User> signUp(User user) async {
  //   Database? dbc=await db;
  //   int id=await dbc!.insert(users_table,{'user_id':user.id , 'user_name':user.name , 
  //     'password':user.password , 'email':user.email, 'phone':user.phone , 'address':user.address});
  //   user.id=id;
  //   emptyCart(id);
  //   return user;
  // }

Future<User> signUp(User user) async {
  Database? dbc = await db;
  try {
    int id = await dbc!.insert(users_table, {
      'user_name': user.name,
      'password': user.password,
      'email': user.email,
      'phone': user.phone,
      'address': user.address
    });
    user.id = id;
    // Assuming `emptyCart` is defined elsewhere
    emptyCart(id);
    return user;
  } catch (e) {
    print('Error in signUp: $e');
    throw Exception('Sign up failed');
  }
}


//return USER_ID if the email and password are exist
//else return 0
  Future<int> login(String email , String password) async {
    Database? dbc=await db;
    List<Map> result = await dbc!.query(users_table, where: 'email= ? AND password =?',
     whereArgs: [email , password],);

     if (result.isNotEmpty) {
       return result[0]['user_id'];
     }
     else {
       return 0;
     }
  } 
  

  Future<void> deleteUser(int userId) async {
    Database? dbc=await db;
    await dbc!.delete( users_table, where: '$user_id = ?', whereArgs: [userId],);
  }

  
  Future<List<User>> allUsers() async{
    Database? d=await db;
    List<Map> data=await d!.query(users_table);

    List<User> users=[];
    if(data.isNotEmpty)
    {
      for (var i = 0; i < data.length; i++) {
        Map item=data[i];
        User u=User(item['user_id'],item['user_name'], item['password'], item['email'] , item['phone'] , item['address']);
        users.add(u);
      }
    }
    return users;
    
  }







 ///////////////////////////// product function //////////////////////////////////
  //add ,, get in category ,, get isFeatured ,, get all
    Future<Product> addProduct(Product p) async {
    Database? dbc=await db;
    int id=await dbc!.insert(products_table,{'product_id':p.id , 'product_name':p.name , 'description':p.description ,
     'category':p.category, 'price':p.price, 'isFeatured':p.isFeatured , 'image':p.image});
    p.id=id;
    return p;
  }


  Future<List<Product>> categoryProducts(String categoryName) async{
    Database? d=await db;
    List<Map> data=await d!.query(products_table , where: '$category = ?', whereArgs: [categoryName],);

    List<Product> products=[];
    if(data.isNotEmpty)
    {
      for (var i = 0; i < data.length; i++) {
        Map item=data[i];
        Product p=Product(item['product_id'],item['product_name'], item['description'], 
        item['category'] , item['price'] , item['isFeatured'],item['image'] );
        products.add(p);
      }
    }
    return products;
  }

  
  Future<List<Product>> featuredProducts() async{
    Database? d=await db;
    int featured=1;
    List<Map> data=await d!.query(products_table , where: '$isFeatured = ?', whereArgs: [featured],);

    List<Product> products=[];
    if(data.isNotEmpty)
    {
      for (var i = 0; i < data.length; i++) {
        Map item=data[i];
        Product p=Product(item['product_id'],item['product_name'], item['description'], 
        item['category'] , item['price'] , item['isFeatured'],item['image'] );
        products.add(p);
      }
    }
    return products;
  }

  
  Future<List<Product>> allProducts() async{
    Database? d=await db;
    List<Map> data=await d!.query(products_table);

    List<Product> products=[];
    if(data.isNotEmpty)
    {
      for (var i = 0; i < data.length; i++) {
        Map item=data[i];
        Product p=Product(item['product_id'],item['product_name'], item['description'], 
        item['category'] , item['price'] , item['isFeatured'],item['image'] );
        products.add(p);
      }
    }
    return products;
  }
  


//////////////////////////////// user's favorites ///////////////////////////////////////
//add , delete , select user favorites
 Future<Favorite> addToFavorites(Favorite f) async {
    Database? dbc=await db;
    int id=await dbc!.insert(favorites_table,{'favorite_id':f.id , 'user_id':f.u_id , 'product_id':f.p_id,});
    f.id=id;
    return f;
  }

  Future<void> daleteFromFavorites(int userId , int productId ) async {
    Database? dbc=await db;
    await dbc!.delete( favorites_table, where: '$favorites_user_id_fk = ?  AND  $favorites_product_id_fk=? ', whereArgs: [userId , productId] ,);
  }


  Future<List<Product>>userFavoriteProducts(int userId) async {
    Database? d = await db;
    List<Map> data = await d!.rawQuery('''
      SELECT $products_table.*
      FROM $products_table
      INNER JOIN $favorites_table
      ON $products_table.$product_id = $favorites_table.$favorites_product_id_fk
      WHERE $favorites_table.$favorites_user_id_fk = ?
    ''', [userId]);

    List<Product> products = [];
    if (data.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        Map item = data[i];
        Product p = Product(
          item['product_id'],
          item['product_name'],
          item['description'],
          item['category'],
          item['price'],
          item['isFeatured'],
          item['image'],
        );
        products.add(p);
      }
    }
    return products;
  }


//for test
  Future<List<Favorite>>testAlluserFavorites() async{
    Database? d=await db;
    List<Map> data=await d!.query(favorites_table);

    List<Favorite> Favorites=[];
    if(data.isNotEmpty){
      for (var i = 0; i < data.length; i++) {
        Map item=data[i];
        Favorite f=Favorite(item['favorite_id'],item['user_id'], item['product_id'],  );
        Favorites.add(f);
      }
    }
    return Favorites;
  }





///////////////////////////////////// shoping table ///////////////////////////////////////////
//order(updata: isOrderd=1 , total price , shiping address ) ,, 
Future<int>emptyCart(int userId) async {
    Database? d = await db;
    int? shId=null;
    int id=await d!.insert(shopping_table, { 'shopping_id':shId, 'user_id':userId,});
    return id;
  }


Future<void>order(int userId , String shippingAddress , double totalPrice) async {
    Database? d = await db;
    int id=await d!.update(shopping_table, { 'isOrdered': 1, 'shippingAddress':shippingAddress, 'totalPrice':totalPrice},
     where: 'user_id = ? AND isOrdered = ?',
      whereArgs: [userId , 0],);

    emptyCart(userId);
  }

/*
Future<List<Shopping>>testorders() async{
    Database? d=await db;
    int? x=1;
    List<Map> data=await d!.query(shopping_table , where: ' isOrdered = $x');
    
    if(data.isEmpty){
      return [];
    }

    List<Shopping> sh=[];
    if(data.isNotEmpty){
      for (var i = 0; i < data.length; i++) {
        Map item=data[i];
        Shopping s=Shopping(item['shopping_id'],item['user_id'], item['isOrdered'],
        item['shippingAddress'],item['totalPrice'],item['isFinished'],  );
        sh.add(s);
      }
    }
    return sh;
  }*/


//////////////////////////////////// shopping_items table /////////////////////////////////////////
//addTocart(insert) , deleteFromcart(delete) , changeQuantity(update quantity)

Future<ShoppingItem> addToCart(int userId, int productId, int quantity) async {
    Database? d = await db;

    List<Map> shopping = await d!.query(
      shopping_table,
      columns: ['shopping_id'],
      where: 'user_id=? AND isOrdered=0',
      whereArgs: [userId],
    );

    int shopping_id = 0;
    if (shopping.isNotEmpty) {
      shopping_id = shopping[0]['shopping_id'];
    }

    //if the product already exists in the cart
    List<Map> existingProduct = await d.query(
      shopping_items_table,
      columns: ['quantity'],
      where: 'shopping_id = ? AND product_id = ?',
      whereArgs: [shopping_id, productId],
    );

    if (existingProduct.isNotEmpty) {
      // If the product exists, update quantity
      int newQuantity = existingProduct[0]['quantity'] + quantity;
      await d.update(
        shopping_items_table,
        {'quantity': newQuantity},
        where: 'shopping_id = ? AND product_id = ?',
        whereArgs: [shopping_id, productId],
      );
      return ShoppingItem(null, shopping_id, productId, newQuantity);

    } else {
      // If the product does not exist, add it to the cart
      ShoppingItem item = ShoppingItem(null, shopping_id, productId, quantity);

      int id = await d.insert(
        shopping_items_table,
        {
          'shopping_items_id': item.id,
          'shopping_id': shopping_id,
          'product_id': productId,
          'quantity': quantity
        },
      );

      item.id = id;
      return item;
    }
}


//for test
Future<List<ShoppingItem>> showshopingItemstaple(int userId) async {
  Database? d = await db;
  
  
  List<Map> shoppingIds = await d!.query(shopping_table , 
      columns: ['shopping_id'],
      where: 'user_id=? AND isOrdered=?' , 
      whereArgs: [userId , 0]);

//if the user's cart is empty
    if (shoppingIds.isEmpty) {
    return [];
  }

  int shoppingId = shoppingIds[0]['shopping_id'] as int;

  List<Map<String, dynamic>> data = await d.rawQuery(
    '''SELECT * FROM $shopping_items_table
     INNER JOIN $shopping_table ON $shopping_items_table.$shopping_id_fk = $shopping_table.$shopping_id 
     WHERE $shopping_table.$user_id_fk = ?''',
    [userId],
  );

  List<ShoppingItem> products = [];
  for (var item in data) {
    ShoppingItem p = ShoppingItem(
      item['shopping_items_id'],
      item['shopping_id'],
      item['product_id'],
      item['quantity'],
    );
    products.add(p);
  }
  return products;
}

Future<List<cartProduct>> showCart(int userId) async {
  Database? d = await db;

  List<Map> shoppingIds = await d!.query(shopping_table,
      columns: ['shopping_id'],
      where: 'user_id=? AND isOrdered=?',
      whereArgs: [userId, 0]);

  // If the user's cart is empty
  if (shoppingIds.isEmpty) {
    return [];
  }

  int shoppingId = shoppingIds[0]['shopping_id'] as int;

  List<Map<String, dynamic>> data = await d.rawQuery(
    '''SELECT * FROM $shopping_items_table
     INNER JOIN $products_table ON $shopping_items_table.product_id = $products_table.product_id 
     WHERE $shopping_items_table.$shopping_id_fk = ?''',
    [shoppingId],
  );

  List<cartProduct> products = [];
  for (var item in data) {
    int quantity=await itemQuantity(userId, item['product_id']);
    cartProduct p = cartProduct(
        item['product_id'],
          item['product_name'],
          item['description'],
          item['category'],
          item['price'],
          item['isFeatured'],
          item['image'],
          quantity
      
    );
    products.add(p);
  }
  return products;
}

Future<void> deleteFromcart(int userId , int productId) async {
    Database? d = await db;

  List<Map> shoppingIds = await d!.query(shopping_table,
      columns: ['shopping_id'],
      where: 'user_id=? AND isOrdered=?',
      whereArgs: [userId, 0]);

      int shoppingId = shoppingIds[0]['shopping_id'] as int;

      await d!.delete('shopping_items',where: 'shopping_id = ? AND product_id= ? ', whereArgs: [shoppingId , productId ],);
  }
  
Future<int> updateCartItemQuantity(int num, int userId , int productId) async {
  Database? d = await db;

     
  List<Map> shoppingIds = await d!.query(shopping_table,
      columns: ['shopping_id'],
      where: 'user_id=? AND isOrdered=?',
      whereArgs: [userId, 0]);

  if (shoppingIds.isEmpty) {
    // Handle the case where no shopping cart exists for the user
    return 0; // or throw an appropriate error
  }

  int shoppingId = shoppingIds[0]['shopping_id'] as int;
  
    List<Map> item = (await d!.query('shopping_items',columns: ['quantity'],
      where: 'shopping_id = ? AND  product_id = ? ',whereArgs: [shoppingId , productId], )) ;

  
     int currentQuantity = item[0]['quantity'];
     int newQuantity = currentQuantity + num;


      return await d!.update('shopping_items',{'quantity': newQuantity},
        where: 'shopping_id = ? AND  product_id = ? ',whereArgs: [shoppingId , productId], );
  }

Future<int> itemQuantity(int userId , int productId) async {
    Database? d = await db;
  
  List<Map> shoppingIds = await d!.query(shopping_table,
      columns: ['shopping_id'],
      where: 'user_id=? AND isOrdered=?',
      whereArgs: [userId, 0]);

  int shoppingId = shoppingIds[0]['shopping_id'] as int;

   List<Map> item = (await d!.query('shopping_items', columns: ['quantity'],
    where: 'shopping_id = ? AND product_id = ? ', whereArgs: [shoppingId , productId], )) ;

int currentQuantity = item[0]['quantity'];

     return currentQuantity;
}
}

