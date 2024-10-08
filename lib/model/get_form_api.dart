import 'dart:convert';
import 'package:ecomorse/constants/AppConstants.dart';
import 'package:ecomorse/model/get_all_prodacts.dart';
import 'package:ecomorse/model/get_cart.dart';
import 'package:ecomorse/model/get_desc.dart';
import 'package:ecomorse/model/get_details.dart';
import 'package:ecomorse/model/get_jewelery.dart';
import 'package:ecomorse/model/user_details.dart';
import 'package:http/http.dart' as http;

Future<List<AllProducts>> fetchAllProducts() async {
  try {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final productList = (data as List<dynamic>)
          .map((item) => AllProducts.fromJson(item))
          .toList();

      listOfAllProducts = productList;

      return productList;
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}

Future<List<DescProduct>> funGetDesc() async {
  try {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products?sort=desc'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final productList = (data as List<dynamic>)
          .map((item) => DescProduct.fromJson(item))
          .toList();

      listOfDesc = productList;
      //print(productList);
      return productList;
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}

Future<List<String>> funGetCategories() async {
  try {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final categoryList =
          (data as List<dynamic>).map((item) => item.toString()).toList();

      listOfCategories = categoryList;

      //print(categoryList);
      return categoryList;
    } else {
      throw Exception('Failed to load categories');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}

Future<List<Jewelery_Electronics>> funGetJewelery(String thecategore) async {
  late String x;
  if (thecategore == 'j') {
    x = 'jewelery';
  } else if (thecategore == 'e') {
    x = 'electronics';
  } else if (thecategore == 'm') {
    x = "men's clothing";
  } else if (thecategore == 'w') {
    x = "women's clothing";
  }

  try {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/category/$x'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final productList = (data as List<dynamic>)
          .map((item) => Jewelery_Electronics.fromJson(item))
          .toList();

      listOfJeEleMenWomen = productList;

      // print(data);
      // print('=================================================\n\n\n\n\n\n\n\n\n\n');
      // print(listOfJeEleMenWomen.length);
      // print('=================================================\n\n\n\n\n\n\n\n\n\n');

      //print(productList);
      return productList;
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}

//List<Details> listOfDetails = [];
Future<List<Details>> fenGetDetails(int id) async {
  try {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is Map<String, dynamic>) {
        final product = Details.fromJson(data);
        listOfDetails = [product];
      } else {
        throw Exception('Unexpected data format');
      }

      //print(listOfDetails);
      //print('=================================\n\n\n\n\n\n\n\n\n\n');

      return listOfDetails;
    } else {
      throw Exception('Failed to load product');
    }
  } catch (e) {
    print('Erroziadr: $e');
    throw e;
  }
}

Future<int> login(String username, String password) async {
  final url = Uri.parse('https://fakestoreapi.com/auth/login');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );
  // print('\x1B[34mhelllllpppppppppppppppppp\x1B[0m');
  // print(response.statusCode);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    // print('----------------------------------');
    // print(responseData);

    return 0;
  } else {
    return 1;
    //throw Exception('Failed to login');
  }
  //return response.statusCode;
}

Future<void> fetchUserDetils(int x) async {
  try {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/users/$x'));
    final data = json.decode(response.body);
    if (data is Map<String, dynamic>) {
      final product = UserDetails.fromJson(data);
      userDetail = [product];

      print(UserDetails());
    } else {
      throw Exception('Unexpected data format');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}

Future<void> createUser(
  String email,
  String username,
  String password,
  String firstname,
  String lastname,
  String city,
  String street,
  String number,
  String zipcode,
  String lat,
  String long,
  String phone,
) async {
  final url = Uri.parse('https://fakestoreapi.com/users');

  final Map<String, dynamic> body = {
    "email": email,
    "username": username,
    "password": password,
    "name": {
      "firstname": firstname,
      "lastname": lastname,
    },
    "address": {
      "city": city,
      "street": street,
      "number": number,
      "zipcode": zipcode,
      "geolocation": {
        "lat": lat,
        "long": long,
      },
    },
    "phone": phone,
  };

  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    final jsonResponse = jsonDecode(response.body);
    print('User created successfully: $jsonResponse');
  } else {
    print('Failed to create user: ${response.statusCode}');
  }
}

Future<List<dynamic>> fungetcart() async {
  final url = Uri.parse('https://fakestoreapi.com/carts/user/1');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final productList =
        (data as List<dynamic>).map((item) => Cart.fromJson(item)).toList();
    listOfCart = productList;
    return productList;
  } else {
    throw Exception('Failed to load cart');
  }
}


Future<void> addCart(
  int productId,
  int quantity,
) async {
  final url = Uri.parse('https://fakestoreapi.com/carts');

  final Map<String, dynamic> body = {
    "userId": 3,
    "date": DateTime.now().toString(),
    "products": [
      {"productId": productId, "quantity": quantity},
      
    ],
  };

  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    final jsonResponse = jsonDecode(response.body);
    print('Cart created successfully: $jsonResponse');
  } else {
    print('Failed to create cart: ${response.statusCode}');
  }
}




// Future<List<dynamic>> funaddnewcart(
//     int userId, String date, List<Map<String, dynamic>> products) async {
//   final url = Uri.parse('https://fakestoreapi.com/carts');
//   final Map<String, dynamic> body = {
//     "userId": 5,
//     "date": "2022-02-03",
//     "products": [
//       {"productId": 5, "quantity": 1},
//       {"productId": 1, "quantity": 5},
//     ],
//   };

//   final response = await http.post(
//     url,
//     headers: {
//       "Content-Type": "application/json",
//     },
//     body: jsonEncode(body),
//   );

//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     final productList =
//         (data as List<dynamic>).map((item) => Cart.fromJson(item)).toList();
//     listOfCart = productList;
//     return productList;
//   } else {
//     throw Exception('Failed to load cart');
//   }
// }
