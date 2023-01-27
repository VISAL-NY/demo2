import 'dart:convert';

import 'package:demo2/model/product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class ProductApi{
  final String URL="https://fakestoreapi.com/products";

  Future<List<Product>> fetchProduct() async{
    final response= await http.get(Uri.parse(URL));
    //print("debug : ${response.body}");
    //print(Product.fromJson(jsonDecode(response.body)));
    //return Product.fromJson(jsonDecode(response.body));
    //print(response.body);
    return compute(productList,response.body);
  }
  List<Product> productList(String responseBody){
    final parsed=json.decode(responseBody);
    //print("My debug : $parsed");
    //print(parsed.map((jsonBody)=>Product.fromJson(jsonBody)).toList());
    return parsed.map<Product>((products)=>Product.fromJson(products)).toList();

  }

  Future<List<Product>> fetchProducWithSpecificCategroy(String category) async{
    final response = await http.get(Uri.parse("https://fakestoreapi.com/products/category/$category"));

    
    return compute(productListWithSpecificCategory,response.body);
  }

  List<Product> productListWithSpecificCategory(String responseBody){
    final parsed=json.decode(responseBody);
    return parsed.map<Product>((productwithspecificcagetory)=>Product.fromJson(productwithspecificcagetory)).toList();
  }
  
}