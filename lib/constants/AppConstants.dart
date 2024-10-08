// ignore: file_names
// ignore: file_names
import 'package:ecomorse/model/get_all_prodacts.dart';
import 'package:ecomorse/model/get_cart.dart';
import 'package:ecomorse/model/get_desc.dart';
import 'package:ecomorse/model/get_details.dart';
import 'package:ecomorse/model/get_jewelery.dart';
import 'package:ecomorse/model/user_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//! ======================= var ==================

double hightoffiald = 50;
double radius = 10;

const Color blue = Color(0xff7d99fd);
const Color liteBlue = Color(0xffecf0ff);
const Color white = Color(0xffffffff);
const Color black = Color(0xff01030a);

bool isLogin = false;
String selectedCategory = 'All';
String selectedSize = 'S';
String selectedCategoryLevel2 = 'Electronics';
String dropdownValue = '';
bool sortState = true;
int quantity = 1;
int colorselected = -1; // No color selected by default
bool ifcolorSelected = false;

String? getedName;
String? getedPassword;

//!=================== fun ========================

Future<void> initializePrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  getedName = prefs.getString('name');
  getedPassword = prefs.getString('password');
  isLogin = getedName != null;
}

setprefs(
  String username,
  String password,
  // int id,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', username);
  prefs.setString('password', password);
  //prefs.setInt('id', id);
}

// !================= the list ================
List<Cart> listOfCart = [];
List<AllProducts> listOfAllProducts = [];
List<DescProduct> listOfDesc = [];
List<Jewelery_Electronics> listOfJeEleMenWomen = [];
List<String> listOfCategories = [];
List<Details> listOfDetails = [];
List<UserDetails> userDetail = [];
// List<UserDetails> userDetail = [];
final List<String> category = [
  'All',
  'Man',
  'Women',
  'Other',
];
final List<String> listOfSize = [
  'S',
  'M',
  'L',
  'XL',
  'XXL',
];
final List<String> electronicsandjewelery = ['Electronics', 'Jewelery'];

final List colors = [
  const Color(0xff51c51c),
  const Color(0xff7a0808),
  black,
  const Color.fromARGB(255, 236, 236, 236),
  const Color(0xff1510db),

  // Colors.green,
  // const Color.fromARGB(255, 214, 89, 67),
  // Colors.black,
  // Color.fromARGB(255, 214, 205, 118),
  // //white,
  // Color.fromARGB(255, 12, 70, 117),
];
