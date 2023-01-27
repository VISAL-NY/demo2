//import 'dart:developer';

import 'package:demo2/model/convert_to_currency.dart';
import 'package:demo2/model/couter_provider.dart';
import 'package:demo2/model/get_value.dart';
import 'package:demo2/model/product.dart';
//import 'package:demo2/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';
import 'package:demo2/global.dart' as global;

class ItemProductWidget extends StatefulWidget {
  final String image;
  final String title;
  final double price;
  final String description;
  final String category;
  final double rating;

  

  ItemProductWidget(
      {required this.image,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.rating});

  @override
  State<ItemProductWidget> createState() => _ItemProductWidgetState();
}

class _ItemProductWidgetState extends State<ItemProductWidget> {
  //ItemProductWidget.detail({required this.image,required this.title,required this.price,required this.description});
  final myCurrency = NumberFormat.simpleCurrency();
  //int count=0;
  // List<int> cart_number=[];
  // int _index=0;
  GetValue _getValue=GetValue();

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context);
    final cart_provider=Provider.of<GetValue>(context);
    // int count = counter.count;
    return InkWell(
      onTap: () {
        //OPEN DETAIL PRODUCT SCREEN
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(
        //   image: image,
        //   title: title,
        //   price: price,
        //   description: description,
        //   category: category,
        // )));

        // _buildModalBottomSheet(context);
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            context: context,
            builder: (_) {
              return StatefulBuilder(builder: (context, setState) {
                return Container(
                  decoration: const BoxDecoration(
                      //color: Colors.grey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  height: 600,
                  child: Column(
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.only(top: 8.0),
                                height: 100,
                                child: Image.network(widget.image)),
                            Text(
                              widget.title,
                              style: const TextStyle(fontSize: 16),
                            ),
                            Row(
                              //mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ConvertToCurrency.convertCurrency(
                                            widget.price)
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.green),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              counter.decrement();
                                              setState(() {});
                                              // setState(() {
                                              //   //count=count-1;
                                              //   counter.decrement();
                                              //   print(
                                              //       "counter is - : ${counter.count}");
                                              // });
                                            },
                                            child: Container(
                                              child: const Text(
                                                "-",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Text(counter.count.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          InkWell(
                                            onTap: () {
                                              counter.increment();
                                              setState(() {});
                                              // setState(() {
                                              //   //ount=count+1;
                                              //   counter.increment();
                                              //   print(
                                              //       "counter is + : ${counter.count}");
                                              // });
                                            },
                                            child: Container(
                                              child: const Text("+",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          )
                                        ]),
                                  ),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                "DESCRIPTION",
                    
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                widget.description,
                                textAlign: TextAlign.justify,
                                style:const TextStyle(
                                  height: 1.3,
                                  fontSize: 14
                                  ),
                                ),
                            )
                          ],
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: InkWell(
                          onTap: (){

                              // widget.cart_number.insert(widget._index, counter.count);
                              // widget._index=widget._index+1;
                              //  print(widget.cart_number);
                              cart_provider.setValue(counter.count);
                              global.productList.add(Product.cart(0, widget.title, widget.price, widget.description, widget.category, widget.image));
                              Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Text(
                              "Add to Cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
            });// show Modal Bottom sheet
      },
      child: Card(
        elevation: 4,
        shadowColor: Colors.black87,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Text(counter.count.toString()),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Card(
                elevation: 0,
                child: Container(
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    placeholder: (context, url) => Center(
                        //color: Colors.green,

                        child: LoadingAnimationWidget.threeRotatingDots(
                            color: Colors.green, size: 20.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1, left: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${myCurrency.format(widget.price)}',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.green)),
                  //RatingStars(
                  //   value: rating,
                  //   maxValue: 5,
                  //   starColor: Colors.amber,
                  //   starSize: 10,
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
