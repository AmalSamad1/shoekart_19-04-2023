// import 'dart:convert';
// import 'dart:js_util';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:untitled/model/shoes_product.dart';
//
// class CartProvider extends ChangeNotifier{
// Products? products;
//
// // Future<String> getJsonFromFirebaseRestAPI() async {
// //   String url = "https://shoes-kart-default-rtdb.firebaseio.com/"+"pruductlist.json";
// //   http.Response response = await http.get(Uri.parse(url));
// //   return response.body;
// // }
// // List<Products> productsdetials = [];
//
// // Future classRead() async {
// //   String jsonString = await getJsonFromFirebaseRestAPI();
// //   final jsonResponse = json.decode(jsonString);
// //
// //     for (Map<String, dynamic> i in jsonResponse)
// //       productsdetials.add(Products.fromMap(i));
// // }
//   Future<void>readData() async {
//     // Please replace the Database URL
//     // which we will get in “Add Realtime Database”
//     // step with DatabaseURL
//     var url = "https://shoes-kart-default-rtdb.firebaseio.com/"+"pruductlist.json";
//     // Do not remove “data.json”,keep it as it is
//     try {
//       final response = await http.get(Uri.parse(url));
//       final extractedData = json.decode(response.body) as Map<String, dynamic>;
//       if (extractedData == null) {
//         return;
//       }
//          extractedData.map((key, value) => Products.)
//       extractedData.forEach((blogId, blogData) {
//         products!.name.add(blogData["name"]);
//         image.add(blogData["image"]);
//         description.add(blogData["description"]);
//       });
//       // setState(() {
//       //   isLoading = false;
//       // });
//     } catch (error) {
//
//     }
//   }
//   }
