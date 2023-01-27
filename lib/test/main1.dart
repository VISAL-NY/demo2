import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

void main(){
  runApp(
    MaterialApp(
      home: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LazyLoadScrollView(
        onEndOfPage:()=>LoadMore() ,
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context,index){
            return Text("Item$index");
          }
          ),
      ),
    );
  }
   LoadMore(){
    return CircularProgressIndicator();
  }
}