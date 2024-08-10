// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'dart:math';

import 'package:ecomorse/model/get_all_prodacts.dart';
import 'package:ecomorse/model/get_desc.dart';
import 'package:ecomorse/model/get_details.dart';
import 'package:ecomorse/model/get_jewelery.dart';
import 'package:ecomorse/model/user_details.dart';
import 'package:flutter/material.dart';

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

// !================= the list ================
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

class Size extends StatelessWidget {
  final double h;
  final double w;

  const Size({this.h = 0, this.w = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
      height: h,
    );
  }
}

int getRandomInt(int x) {
  x = x - 1;

  return Random().nextInt(x) + 1;
}
