import 'dart:convert';

Car carFromMap(String str) => Car.fromMap(json.decode(str));

String carToMap(Car data) => json.encode(data.toMap());

class Car {
  Car({
    required this.brandName,
    required this.country,
    required this.foundationDate,
    required this.models,
  });

  final String brandName;
  final String country;
  final int foundationDate;
  final List<Model> models;

  factory Car.fromMap(Map<String, dynamic> json) => Car(
        brandName: json["brand_name"],
        country: json["country"],
        foundationDate: json["foundation_date"],
        models: List<Model>.from(json["models"].map((x) => Model.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "brand_name": brandName,
        "country": country,
        "foundation_date": foundationDate,
        "models": List<dynamic>.from(models.map((x) => x.toMap())),
      };
}

class Model {
  Model({
    required this.modelName,
    required this.price,
    required this.gas,
  });

  final String modelName;
  final int price;
  final bool gas;

  factory Model.fromMap(Map<String, dynamic> json) => Model(
        modelName: json["model_name"],
        price: json["price"],
        gas: json["gas"],
      );

  Map<String, dynamic> toMap() => {
        "model_name": modelName,
        "price": price,
        "gas": gas,
      };
}
