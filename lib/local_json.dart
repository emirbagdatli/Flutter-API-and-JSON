import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/car_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  late Future<List<Car>> fillList;
  @override
  void initState() {
    super.initState();
    fillList = carsJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Json'),
      ),
      body: FutureBuilder<List<Car>>(
        future: fillList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Car> carList = snapshot.data!;
            return ListView.builder(
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text(carList[index].brandName),
                  subtitle: Text(carList[index].country),
                  leading: CircleAvatar(
                      child: Text(
                    carList[index].models[0].price.toString(),
                    style: const TextStyle(fontSize: 12.5),
                  )),
                );
              }),
              itemCount: carList.length,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<Car>> carsJson() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      String readString = await DefaultAssetBundle.of(context)
          .loadString('assets/data/cars.json');

      var jsonObject = jsonDecode(readString);

      List<Car> allCars =
          (jsonObject as List).map((carMap) => Car.fromMap(carMap)).toList();

      debugPrint(allCars[1].foundationDate.toString());
      debugPrint(allCars.length.toString());
      return allCars;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
