import 'package:buy_it/constants.dart';
import 'package:buy_it/screens/admin/OrdersScreen.dart';
import 'package:buy_it/screens/admin/addProduct.dart';
import 'package:buy_it/screens/admin/home.dart';
import 'package:buy_it/screens/admin/manageProduct.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white24, actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: Icon(
                Icons.login_outlined,
                color: kMainColor,
              )),
        )
      ]),
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, HomePage22.id);
            },
            child: Text('لوحة التحكم'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text('Edit Product'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, OrdersScreen.id);
            },
            child: Text('View orders'),
          )
        ],
      ),
    );
  }
}
