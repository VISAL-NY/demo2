import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo2/api/product_api.dart';
import 'package:demo2/cart_item.dart';
import 'package:demo2/home_page.dart';
import 'package:demo2/model/couter_provider.dart';
import 'package:demo2/model/get_value.dart';
import 'package:demo2/model/product.dart';
import 'package:demo2/product_detail.dart';
import 'package:demo2/widget/item_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart' ;
import 'global.dart' as global;
void main(){
  Provider.debugCheckInvalidValueType=null;
  global.productList=[];
  runApp(
    //  ChangeNotifierProvider(
    //   create: (context)=>CounterProvider(),
    //   child: MaterialApp(
    //   home: MyApp(),
    // ) ,
    //  )

    MultiProvider(providers: [
      Provider<CounterProvider>(create: (context)=>CounterProvider(),),
      Provider<GetValue>(create: (contex)=>GetValue(),)
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
    )
    // const MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: HomePage(),
    // )
   
  );
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ProductApi productApi=ProductApi();
  //int cart_number=0;
  //GetValue _getValue=GetValue();

  @override
  void initState() {
    productApi.fetchProduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //final cart_provider=Provider.of<GetValue>(context);
    //final counter=Provider.of<CounterProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.blueAccent,),
          onPressed: (){
            Navigator.pop(context);
          },
          ),
        backgroundColor: Colors.white.withOpacity(0.9),
        title: const Text("Shopping",style: TextStyle(color: Colors.black87),),
        actions:[       
          Badge(
            position: BadgePosition.topEnd(top: -6,end: -1),
            badgeContent: Text(Provider.of<GetValue>(context).getValue.toString(),style:const TextStyle(color: Colors.white),),
            onTap: (){
              
            },
            child: IconButton(
              onPressed: (){
                //global.title.add();
                Navigator.push(context,MaterialPageRoute(builder: (context)=>const CartItem()));
                print(global.productList);
              },
              icon:const Icon(Icons.shopping_cart),
              color: Colors.black,),
            
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: productApi.fetchProduct(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return GridView.builder(

              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5),
              itemCount: snapshot.data!.length,
              itemBuilder: (context,index){
                  return AnimationConfiguration.staggeredGrid(
                      columnCount: 2,
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          //child:ItemProductWidget(image: snapshot.data![index].image, title: snapshot.data![index].title, price: snapshot.data![index].price,description: snapshot.data![index].description,category: snapshot.data![index].category,rating: snapshot.data![index].rating.rate,),
                          child: ItemProductWidget(image: snapshot.data![index].image, title: snapshot.data![index].title, price: snapshot.data![index].price,description: snapshot.data![index].description,category: snapshot.data![index].category,rating: snapshot.data![index].rating.rate,)
                          
                        ),
                      )
                  );
            },
            );
          }
          else if(snapshot.hasError){
            return  Center(
              child: _errorScreen(),
            );
          }
          return Center(
            child: LoadingAnimationWidget.hexagonDots(color: Colors.blue, size: 60.0),
          );
        },
      ),
    );
  }
  _errorScreen(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:const  [
        Icon(Icons.warning_outlined,size: 50,),
        Padding(
          padding: EdgeInsets.only(top: 10),
            child: Text("Unable to Load Data",style: TextStyle(color: Colors.black,fontSize: 20),
            )),
        Padding(
          padding: EdgeInsets.only(top: 10,left: 10,right: 10),
          child: Text("This can happen if you are not connected to the internet . or if an underlying system or component is not available",textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17
            ),
          ),
        )
      ],
    );
  }
}
