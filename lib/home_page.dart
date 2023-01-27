import 'dart:convert';
import 'package:demo2/api/product_api.dart';
import 'package:demo2/main.dart';
import 'package:demo2/model/convert_to_currency.dart';
import 'package:demo2/model/product.dart';
import 'package:demo2/product_detail.dart';
import 'package:intl/intl.dart';
import 'package:demo2/api/category_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CategoryApi categoryApi = CategoryApi();
  ProductApi productApi=ProductApi();

  

  @override
  void initState() {
    categoryApi.fetchCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "asset/images/store.png",
              fit: BoxFit.cover,
            )),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ImageSlideshow(
                initialPage: 0,
                isLoop: true,
                autoPlayInterval: 3500,
                indicatorRadius: 5,
                indicatorColor: Colors.amber,
                indicatorBackgroundColor: Colors.white,
                children: [
                  Image.asset(
                    "asset/images/slide1.jpeg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "asset/images/slide2.jpeg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "asset/images/slide3.webp",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "asset/images/slide4.jpg",
                    fit: BoxFit.cover,
                  ),
                ],
                
              ),
            ),
          ),
        ),
        Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "CATEGORIES",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
        Expanded(
          child: Container(
            //color: Colors.blue,
            child: FutureBuilder<String>(
                future: categoryApi.fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List items = json.decode(snapshot.data!);
                    List ItemsImage = [
                      "asset/images/001-electronic.png",
                      "asset/images/002-jewelry.png",
                      "asset/images/003-male-clothes.png",
                      "asset/images/004-woman-clothes.png"
                    ];
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return _buildCategoryItem(
                              items[index], ItemsImage[index]);
                        });
                  } else if (snapshot.hasError) {
                    return Text("Error");
                  }
                  return Text("");
                }),
          ),
        ),
        Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  alignment: Alignment.centerLeft,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "FEATURED PRODUCTS",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                      }, child: const Text("SEE MORE"))
                    ],
                  )),
        Expanded(
          flex: 2,
          //child: Container(),
          child: Container(
            child: FutureBuilder<List<Product>>(
              future: productApi.fetchProduct(),
              builder:(context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context,index){
                      return _buildProductItem(
                        snapshot.data![index].image, 
                        snapshot.data![index].title, 
                        snapshot.data![index].price, 
                        snapshot.data![index].rating.rate
                        );
                    }
                    );
                }
                else return Text("");
              }) ,
          )
          )
      ]),
    ));
  }

//BUILD CATEGORY ITEM
  _buildCategoryItem(String name, String image) {
    return InkWell(
      onTap: (){
        //productApi.fetchProducWithSpecificCategroy(name);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(category: name,)));
      },
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              image,
              width: 50,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                name,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }

//BUILD PRODUCT ITEM
Widget _buildProductItem(String image,String title,double price,double rate){
  return Padding(
    padding: const EdgeInsets.all(10),
    child: SizedBox(
      height: 200,
      width: 200,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(image,height: 100,width: 100,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title,style:const TextStyle(fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(ConvertToCurrency.convertCurrency(price).toString(),style: TextStyle(color: Colors.green),),
                  Container(
                    child: Row(
                      children: [
                        Text(rate.toString()),
                        const Icon(Icons.star,size: 16,color: Colors.amber,)
                        ]
                      ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );

}
}
