import 'dart:convert';
import 'package:http/http.dart' as http;

Future<ApiData> getData() async {
  final http.Response response = await http.get(Uri.parse(
      'https://omst5afyma.execute-api.ap-south-1.amazonaws.com/production/app/home'));
  if (response.statusCode == 200) {
    return ApiData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failed to load data');
  }
}

class ApiData {
  //final String message;
  final List<Categories> category;
  final List<City> city;
  final String status;
  final List<Slidr> slider;
  final List<ProductDeal> product_deal;
  //final List<ProductFile> productFile;
  final List<Featured> featured;

  // final List best_seller;
  // final List special;
  // final List featured;

  ApiData({
    required this.category,
    required this.city,
    required this.status,
    required this.slider,
    required this.product_deal,
    //required this.productFile
    required this.featured,
    // required this.best_seller,
    // required this.special,
    // required this.featured,
  });

  factory ApiData.fromJson(Map<String, dynamic> parsedJson) {
    var listCat = parsedJson['category'] as List;
    var listCity = parsedJson['city'] as List;
    var listSlidr = parsedJson['slider'] as List;
    var listProductDeal = parsedJson['product_deal'] as List;
    //var listProductFile = parsedJson['location'] as List;
    //var listFeatured = parsedJson['featured'] as List;

    List<Categories> categoryList =
        listCat.map((i) => Categories.fromJson(i)).toList();
    List<City> cityList = listCity.map((i) => City.fromJson(i)).toList();
    List<Slidr> sliderList = listSlidr.map((i) => Slidr.fromJson(i)).toList();
    List<ProductDeal> productDealList =
        listProductDeal.map((i) => ProductDeal.fromJson(i)).toList();
    //List<ProductFile> productFileList = listProductFile.map((i) => ProductFile.fromJson(i)).toList();
    //List<Featured> featuredList = listFeatured.map((i) => Featured.fromJson(i)).toList();

    // var listFile = parsedJson['file'] as List;
    // List<File> fileList = listFile.map((i) => File.fromJson(i)).toList();

    return ApiData(
      status: parsedJson['status'],
      category: categoryList,
      city: cityList,
      slider: sliderList,
      product_deal: productDealList,
      //productFile: productFileList
      featured: List<Featured>.from(
          parsedJson['featured'].map((i) => Featured.fromJson(i))),
      //file: fileList
    );
  }
}

class Categories {
  final String name;
  final String description;

  Categories({required this.name, required this.description});

  factory Categories.fromJson(Map<String, dynamic> categoryJson) {
    return Categories(
        name: categoryJson['name'], description: categoryJson['description']);
  }
}

class City {
  final String name;
  final String file;

  City({
    required this.name,
    required this.file,
  });

  factory City.fromJson(Map<String, dynamic> cityJson) {
    return City(name: cityJson['name'], file: cityJson['file']);
  }
}

class Slidr {
  final String name;
  final String file;

  Slidr({required this.name, required this.file});
  factory Slidr.fromJson(Map<String, dynamic> slidrJson) {
    return Slidr(name: slidrJson['name'], file: slidrJson['file']);
  }
}

class ProductDeal {
  final String name;
  final String discounted_price;
  //final List<ProductFile> productFile;

  ProductDeal({
    required this.name,
    required this.discounted_price,
    //required this.productFile
  });
  factory ProductDeal.fromJson(Map<String, dynamic> productDealJson) {
    //var listProductFile = productDealJson['location'] as List;
    //List<ProductFile> productFileList = listProductFile.map((i) => ProductFile.fromJson(i)).toList();
    return ProductDeal(
      name: productDealJson['name'],
      discounted_price:
          productDealJson['discounted_price'], //productFile: productFileList
    );
  }
}

// class ProductFile {
//   final String location;
//   ProductFile({required this.location});
//
//   factory ProductFile.fromJson(Map<String, dynamic> productFileJson){
//     return ProductFile(location: productFileJson['location']);
//   }
// }
class Featured {
  final String name;
  final String short_desc;
  final String price;
  final List<File> file;

  Featured({required this.name, required this.short_desc,required this.price, required this.file});
  factory Featured.fromJson(Map<String, dynamic> featuredjson) {
    return Featured(
      name: featuredjson['name'],
      short_desc: featuredjson['short_desc'],
      price: featuredjson['price'].toString(),
      file: List<File>.from(featuredjson['file'].map((i) => File.fromJson(i))),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'short_desc': short_desc,
        'file': List<dynamic>.from(file.map((i) => i.toJson())),
      };
}

class File {
  final String location;
  File({required this.location});
  factory File.fromJson(Map<String, dynamic> fileJson) {
    return File(location: fileJson['location']);
  }
  Map<String, dynamic> toJson() => {'location': location};
}
