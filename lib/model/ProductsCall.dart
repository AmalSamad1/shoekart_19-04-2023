import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/model/shoes_product.dart';


class ProductsCall {


  Future<List<Products>> firebaseCalls(
      DatabaseReference databaseReference) async {
    List<Products> list = [];
    DatabaseEvent event = await databaseReference.child(
        "pruductlist").once();
    for (var element in event.snapshot.children) {
      Map<dynamic, dynamic> jsonResponse = element.value as Map<dynamic,
          dynamic>;
      Products h = Products.fromMap(jsonResponse);

      list.insert(0, h);
      print(jsonResponse.toString());
    }
    return list;
  }
}