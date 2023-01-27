import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo2/api/product_api.dart';
import 'package:demo2/model/couter_provider.dart';
import 'package:demo2/widget/item_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
 import 'package:intl/intl.dart';
 import 'package:demo2/model/product.dart';
import 'package:provider/provider.dart';
import 'global.dart' as global;
// import 'package:marquee/marquee.dart';

class ProductDetail extends StatefulWidget {
  final String image="";
  final String titl="";
  final double price=0.0;
  String description="";
  final String category;

  ProductDetail({required this.category});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final myCurrency=NumberFormat.simpleCurrency();
  ProductApi productApi=ProductApi();

@override
  void initState() {
    productApi.fetchProducWithSpecificCategroy(widget.category);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding:const EdgeInsets.only(left: 5,right: 5),
          child: Text(widget.category,style: TextStyle(color: Colors.black87),),
          //child:title.length<=20?Text((title),style: TextStyle(color: Colors.black87)):Marquee(
            // text: title,
            // style: TextStyle(color: Colors.black87),
            // velocity: 50.0,
          //)

        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black87,size: 20,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10,top: 15),
            child: Badge(
              position: BadgePosition.topEnd(top: -6,end: -1),
              badgeContent: Text(Provider.of<CounterProvider>(context).count.toString(),style: const TextStyle(color: Colors.white),),
              child: IconButton(
                onPressed: (){
                   print(global.productList);
                },
                icon:const Icon(Icons.shopping_cart,color: Colors.black,)
                ),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: productApi.fetchProducWithSpecificCategroy(widget.category),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return GridView.builder(
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 10,crossAxisCount: 2),
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return ItemProductWidget(image: snapshot.data![index].image, title: snapshot.data![index].title, price: snapshot.data![index].price, description: snapshot.data![index].description, category: snapshot.data![index].category, rating: snapshot.data![index].rating.rate);
            })
            );
          }
          else if(snapshot.hasError){
            //const Text("");
            //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("connection time out")));
            

          }
          return Center(
            child: LoadingAnimationWidget.hexagonDots(color: Colors.blue, size: 60.0),
          ); 
          
        }
        
        )
    );
  }
}
