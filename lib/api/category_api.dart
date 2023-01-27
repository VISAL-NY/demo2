import 'dart:core';

import 'package:http/http.dart' as http;
class CategoryApi{
  String URL="https://fakestoreapi.com/products/categories";
  
  Future<String> fetchCategory() async{
      final response= await http.get(Uri.parse(URL));
      //print(response.body.toString());

      return response.body;
  } 

  
}