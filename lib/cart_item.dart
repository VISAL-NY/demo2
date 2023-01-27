

import 'package:demo2/model/convert_to_currency.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'global.dart' as global;

class CartItem extends StatelessWidget {
const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,
          )),
        title:const Text("Cart",style: TextStyle(color: Colors.black),),
      ),
      body: ListView.builder(
        itemCount: global.productList.length,
        itemBuilder: (context,index){
          return _buildCartItem(
            global.productList[index].image,
            global.productList[index].title,
            global.productList[index].price
            );
        }
        
        ),
    );
  }

  _buildCartItem(String image,String title,double price){
    return Card(
      elevation: 2,
      child: ListTile(
        leading: SizedBox(
          height: 80,
          width: 80,
          child: Image.network(image)
          ),
        title: Text(title),
        subtitle: Text(ConvertToCurrency.convertCurrency(price),style: const TextStyle(color: Colors.green,fontSize: 16),),
      ),
    );
  }
}