import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  String _name, _price, _description, _category, _pimage;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  hint: 'Product Name',
                  onClick: (value) {
                    _name = value;
                  }, icon: null,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _price = value;
                  },
                  hint: 'Product Price', icon: null,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _description = value;
                  },
                  hint: 'Product Description', icon: null,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _category = value;
                  },
                  hint: 'Product Category', icon: null,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _pimage = value;
                  },
                  hint: 'Product Location', icon: null,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();

                      _store.editProduct({
                        kProductName: _name,
                        kProductLocation: _pimage,
                        kProductCategory: _category,
                        kProductDescription: _description,
                        kProductPrice: _price
                      }, product.pId);
                    }
                  },
                  child: Text('Edit Product'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
