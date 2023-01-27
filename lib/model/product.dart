
class Product{
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  late Rating rating;

  //ConvertIntToDouble _convertIntToDouble=ConvertIntToDouble();


  Product.cart(this.id,this.title,this.price,this.description,this.category,this.image);

  Product({required this.id,required this.title,required this.price,required this.description,required this.category,required this.image,required this.rating});
  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
        id: json['id'],
        title: json['title'],
        //price: double.parse(json['price'].toString()) ,
        //price: ConvertIntToDouble.convertToDouble(json['price']),
        price: json['price'].runtimeType==double?json['price']: double.parse(json['price'].toString()),
        description: json['description'],
        category: json['category'],
        image: json['image'],
        rating: Rating.fromJson(json['rating'])

        //rating:Rating.fromJson(json['rating']).runtimeType==double?Rating.fromJson(json['rating']):double.parse(Rating.fromJson(json['rating']));
    );

  }
}

class Rating{
  final double rate;
  final int count;
  Rating({required this.rate,required this.count});
  factory Rating.fromJson(dynamic json){
    return Rating(rate: json['rate'].runtimeType==double?json['rate']:double.parse(json['rate'].toString()), count: json['count']);
  }
}

