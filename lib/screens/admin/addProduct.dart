import 'dart:io';

import 'package:buy_it/services/store.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:buy_it/models/product.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/widgets/custom_textfield.dart';

import '../../constants.dart';
import '../../models/product.dart';
import '../../widgets/custom_textfield.dart';
import 'adminHome.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String _name, _price, _description, _category, _pimage;
  String choseValue;
  List<String> category = [
    'jackets',
    'trousers',
    't-shirts',
    'shoes',
  ];

  File _image;
  String _url;
  bool isloading = false;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        title: Text(
          "اضافة منتج جديد",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  hint: 'Product Name',
                  onClick: (value) {
                    _name = value;
                  },
                  icon: null,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _price = value;
                  },
                  hint: 'Product Price',
                  icon: null,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _description = value;
                  },
                  hint: 'Product Description',
                  icon: null,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: DropdownButton(
                            focusColor: Colors.grey,
                            elevation: 10,
                            isExpanded: true,
                            value: _category,
                            items: category.map(
                              (value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (String value) {
                              setState(() {
                                _category = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // CustomTextField(
                //   onClick: (value) {
                //     _category = value;
                //   },
                //   hint: 'Product Category', icon: null,
                // ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap: pickImage, child: Icon(Icons.camera_alt)),
                    CircleAvatar(
                      backgroundImage:
                          _image == null ? null : FileImage(_image),
                      radius: 80,
                    ),
                    GestureDetector(
                        onTap: getImageGallery, child: Icon(Icons.get_app)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Builder(
                      builder: (context) => RaisedButton(
                        onPressed: () {
                          uploadImage(context);
                        },
                        child: Text('اضافه االمنتج  '),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();
                      _store.addProduct(Product(
                          pName: _name,
                          pPrice: _price,
                          pimage: _url,
                          pDescription: _description,
                          pCategory: _category));

                      Navigator.pushNamed(context, AdminHome.id);
                    }
                  },
                  child: Text('استمر'),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void loadImage() async {
    var imageId = await ImageDownloader.downloadImage(_url);
    var path = await ImageDownloader.findPath(imageId);
    File image = File(path);
    setState(() {
      _image = image;
    });
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  void uploadImage(context) async {
    try {
      FirebaseStorage storage =
          FirebaseStorage(storageBucket: 'gs://shope12-168ef.appspot.com');
      StorageReference ref = storage.ref().child(_image.path);

      StorageUploadTask storageUploadTask = ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('تم الاضافة بنجاح'),
      ));
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url $url');
      setState(() {
        _url = url;
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
}
