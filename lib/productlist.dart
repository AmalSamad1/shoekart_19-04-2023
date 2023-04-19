import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Home_Page/product_detail.dart';
import 'package:untitled/model/ProductsCall.dart';
import 'package:untitled/utils/cartProvider.dart';
import 'model/shoes_product.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>implements passHistory {
List<Products> productsdetials=[];
Products? currentProcessingHistory=null;
  void initState() {

    setState(() {

     productsCall;
     productsdetials.length;
     productsCall.firebaseCalls(databaseReference);
    });
    super.initState();
  }
  List<Products> pro=[];
  bool isLoading = true;
final databaseReference = FirebaseDatabase.instance.ref();
final productsCall= new ProductsCall();
bool noFir=false;


  int quantity = 0;

  @override
  Widget build(BuildContext context,) {
    Firebase.initializeApp();
    // final cart = Provider.of<CartProvider>(context);
    FutureBuilder futureBuilder=new FutureBuilder(
      future: productsCall.firebaseCalls(databaseReference), // async work
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot.connectionState);
        if(snapshot.connectionState==ConnectionState.done) {
          if (!snapshot.hasData || snapshot.data.length == 0) {
            return Center(child: new Text("No History"));
          } else {
            productsdetials.clear();
            productsdetials.addAll(snapshot.data);
            return listA();
          }
        }else return Center(child: CircularProgressIndicator());
      },
    );


    return Scaffold(
      body: noFir?listA():futureBuilder,

    );



  }

  dynamic  listA(){
    return  GridView.builder(
      itemCount: productsdetials.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0
      ),
      itemBuilder: (BuildContext context, int index,){

        return InkWell(
            onTap: () {
              currentProcessingHistory=productsdetials.elementAt(index);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) => ProductDetailPage(currentProcessingHistory!, this)));

            },


            child: new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      child: Container(
                        width: 200,
                        height: 150,
                        color: Colors.white,
                        child: Center(
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage("${productsdetials.elementAt(index).image??""}"),
                            )
                        ),
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),

                  Text("${productsdetials.elementAt(index).name??""}"),
                ],
              ),
              elevation: 2.0,
              margin: EdgeInsets.all(5.0),
            )
        );
      },
    );
  }
@override
void addCard(Products products) {
  noFir=true;
  setState(() {
    heroTag: "st1";
    productsdetials.insert(0,products);
  });
}

@override
void localRefresh() {
  setState(() {
    heroTag: "st2";
    noFir=true;
    print(productsdetials[0].toString());
  });
}

@override
Products? getCurrentHistory() {
  return currentProcessingHistory;
}
}
class passHistory {
  void addCard(Products products){}
  void localRefresh(){}
  Products? getCurrentHistory(){
  }

}