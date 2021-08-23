import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:front/add_vehicle.dart';
import 'package:front/list.dart';
import 'package:front/utils/utils.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: '👈 Vehicle List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> pageChangeFunction(var vehicleType) async {
    final vehicleTypeResponse = await get(Uri.parse(
        'http://localhost:9090/api/category-service/vehicle/category?category=$vehicleType'));
    var vehicleTypeResponseJson = convert.jsonDecode(vehicleTypeResponse.body);
    var vehicleTypeResponseMap = vehicleTypeResponseJson.asMap();
    print(vehicleTypeResponseJson);
    //print(vehicleTypeResponseMap);
    // vehicleTypeResponseMap.values.forEach((value) {
    //   print(value);
    // });
    // vehicleTypeResponseMap.keys.forEach((value) {
    //   print(value);
    // });
    //Map vehicleTypeResponseMapData = Map();
    //print(vehicleTypeResponseMap.runtimeType);
    //vehicleTypeResponseMap.forEach((key, value) {
    //print(key);
    //print(value.runtimeType);
    //print(value['licensePlateNumber']);
    //print(value['licensePlateNumber'].runtimeType);

    //vehicleTypeResponseMapData[key] = value;
    //});
    //print(vehicleTypeResponseMap[0]);
    //print(vehicleTypeResponseMapData);
    //(vehicleTypeResponseMapData.runtimeType);
    final vehicleReviewResponse = await get(
        Uri.parse('http://localhost:9090/api/review-service/rv/getAll'));
    var vehicleReviewResponseJson =
        convert.jsonDecode(vehicleReviewResponse.body);
    var vehicleReviewResponseMap = vehicleReviewResponseJson.asMap();
    //print(vehicleReviewResponseMap);
    final vehicleAvailability = await get(Uri.parse(
        'http://localhost:9090/api/availability-service/availability/getAll'));
    var vehicleAvailabilityJson = convert.jsonDecode(vehicleAvailability.body);
    Map vehicleAvailabilityMap = vehicleAvailabilityJson.asMap();

    print(vehicleAvailabilityMap);
    //

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PageListChange(vehicleTypeResponseMap, vehicleReviewResponseMap,
          vehicleAvailabilityMap);
    }));

    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (BuildContext context) {
    //   return RegisterPage();
    // }));
  }

  _makeGetRequest() async {
    //  final vehicleResponse = await get(
    //      Uri.parse('http://localhost:9090/api/review-service/rv/getAll'));
    //  var jsonResponse = convert.jsonDecode(vehicleResponse.body);
    //  print(jsonResponse.runtimeType);
    //  Map myData = jsonResponse.asMap();
    //  print(jsonResponse);
    //  myData.values.forEach((value) {
    //    print(value);
    //  });
    //  myData.keys.forEach((value) {
    //    print(value);
    //  });
    // // print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    //  print(myData[0]['reviewList']);
    //  print(myData[0]['reviewList'].runtimeType);
    //  var dddd = myData[0]['reviewList'].asMap();
    //  print(dddd.runtimeType);
    // // print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    //  myData.forEach((key, value) {
    //    print(key);
    //    print(value['reviewList']);
    //    print(value['id']);
    //    print(value['reviewList'].runtimeType);
    //    Map mmyData = value['reviewList'].asMap();
    //    mmyData.forEach((key1, value1) {
    //      print(value1);
    //    });
    //  });

    //print(vehicleResponse.body);
    // sample info available in response
    // final statusCode = response.statusCode;
    // final headers = response.headers;
    // final contentType = headers['content-type'];
    // final json = response.body;

    //
    // final vehicleAvailability = await get(
    //     Uri.parse('http://localhost:9090/api/availability-service/availability/getAll'));
    // var vehicleAvailabilityJson = convert.jsonDecode(vehicleAvailability.body);
    // Map vehicleAvailabilityMap = vehicleAvailabilityJson.asMap();

    // TODO convert json to object...

    //var url = Uri.parse('http://localhost:9090/api/category-service/vehicle/create');
    //var response = await post(url, body: {'name': 'doodle', 'color': 'blue'});
    // var response = await post(url, body: {
    //   "licensePlateNumber": "AB-9999",
    //   "category":"car",
    //   "numberOfSeats":"5"});
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    final vehicleTypeResponse = await get(Uri.parse(
        'http://localhost:9090/api/category-service/vehicle/category?category=car'));
    var vehicleTypeResponseJson = convert.jsonDecode(vehicleTypeResponse.body);
    var vehicleTypeResponseMap = vehicleTypeResponseJson.asMap();
    print(vehicleTypeResponseMap);
    final vehicleReviewResponse = await get(
        Uri.parse('http://localhost:9090/api/review-service/rv/getAll'));
    var vehicleReviewResponseJson =
        convert.jsonDecode(vehicleReviewResponse.body);
    var vehicleReviewResponseMap = vehicleReviewResponseJson.asMap();
    print(vehicleReviewResponseMap);
    final vehicleAvailability = await get(Uri.parse(
        'http://localhost:9090/api/availability-service/availability/getAll'));
    var vehicleAvailabilityJson = convert.jsonDecode(vehicleAvailability.body);
    Map vehicleAvailabilityMap = vehicleAvailabilityJson.asMap();
    print(vehicleAvailabilityMap);

    // var url = Uri.parse('http://localhost:9090/api/availability-service/availability/setAvailability');
    // Map data = {
    //     "availability": "In Stock",
    //     "quantity": "10",
    // };
    // //encode Map to JSON
    // var body = json.encode(data);
    //
    // var response = await post(url,
    //     headers: {"Content-Type": "application/json"},
    //     body: body
    // );
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    //
    // final vehicleAvailability1 = await get(
    //     Uri.parse('http://localhost:9090/api/availability-service/availability/getAll'));
    // var vehicleAvailabilityJson1 = convert.jsonDecode(vehicleAvailability1.body);
    // Map vehicleAvailabilityMap1 = vehicleAvailabilityJson1.asMap();
    // print(vehicleAvailabilityMap1);

    // var url = Uri.parse('http://localhost:9090/api/category-service/vehicle/create');
    // Map data = {
    //   "licensePlateNumber": "AB-9999",
    //   "category":"car",
    //   "numberOfSeats":"5"
    // };
    // //encode Map to JSON
    // var body = json.encode(data);
    //
    // var response = await post(url,
    //     headers: {"Content-Type": "application/json"},
    //     body: body
    // );
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    //
    // final vehicleTypeResponse1 = await get(Uri.parse(
    //     'http://localhost:9090/api/category-service/vehicle/category?category=car'));
    // var vehicleTypeResponseJson1 = convert.jsonDecode(vehicleTypeResponse1.body);
    // var vehicleTypeResponseMap1 = vehicleTypeResponseJson1.asMap();
    // print(vehicleTypeResponseMap1);
//************************************************************************************************************************
    vehicleReviewResponseMap[1]["reviewList"].add("bbbbbbb");
    print(vehicleReviewResponseMap[1]["reviewList"]);
    var url = Uri.parse('http://localhost:9090/api/review-service/rv/by/6');
    Map data = {
      "id": "6",
      "reviewList": ["Good"]
    };
    //encode Map to JSON
    print(data.runtimeType);

    var body = json.encode(vehicleReviewResponseMap[1]);

    var response = await put(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final vehicleAvailability1 = await get(
        Uri.parse('http://localhost:9090/api/review-service/rv/getAll'));
    var vehicleAvailabilityJson1 =
        convert.jsonDecode(vehicleAvailability1.body);
    Map vehicleAvailabilityMap1 = vehicleAvailabilityJson1.asMap();
    print(vehicleAvailabilityMap1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
      ),
      body: Row(children: <Widget>[
        Expanded(
          flex: 5,
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      'GrandeHire',
                      style: TextStyle(
                          fontSize: 80,
                          foreground: Paint()
                            ..shader = ui.Gradient.linear(
                              const Offset(0, 20),
                              const Offset(450, 20),
                              <Color>[
                                Colors.red,
                                Colors.yellow,
                              ],
                            )
                      ),
                    ),
                    Text(
                      ' WebApp',
                      style: TextStyle(
                          fontSize: 60,
                          foreground: Paint()
                            ..shader = ui.Gradient.linear(
                              const Offset(0, 20),
                              const Offset(450, 20),
                              <Color>[
                                Color(0xFF880E4F),
                                Color(0xFFF8BBD0),
                              ],
                            ),
                      ),
                    ),
                    Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/images.jfif'),
                          fit: BoxFit.fitWidth,
                        ),
                        shape: BoxShape.circle,
                      ),
                    )
                  ])),
        ),
        Expanded(
          flex: 5,
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Container(
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AvailableImages.homePage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'This app can be used in an administration system of a vehicle renting',
                      style: TextStyle(
                        fontSize: 20,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.4
                          ..color = Color(0xFF880E4F),
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'This app can be used in an administration system of a vehicle renting',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFF48FB1).withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'service. The microservices within it are used to register new ',
                      style: TextStyle(
                        fontSize: 22,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.45
                          ..color = Color(0xFF880E4F),
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'service. The microservices within it are used to register new ',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFFF48FB1).withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'vehicles, search for the vehicles to be rented out, ',
                      style: TextStyle(
                        fontSize: 24,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.5
                          ..color = Color(0xFF880E4F),
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'vehicles, search for the vehicles to be rented out, ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFFF48FB1).withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'edit their availability and other information,',
                      style: TextStyle(
                        fontSize: 26,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.5
                          ..color = Color(0xFF880E4F),
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'edit their availability and other information,',
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFFF48FB1).withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'and view and edit the reviews ',
                      style: TextStyle(
                        fontSize: 28,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.5
                          ..color = Color(0xFF880E4F),
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'and view and edit the reviews ',
                      style: TextStyle(
                        fontSize: 28,
                        color: Color(0xFFF48FB1).withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'given by the customers.',
                      style: TextStyle(
                        fontSize: 30,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.5
                          ..color = Color(0xFF880E4F),
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'given by the customers.',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFFF48FB1).withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ])),
        )
      ]),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return RegisterPage();
        })),
        // _incrementCounter(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),
      drawer: Drawer(
        elevation: 4,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: new Color(0xFF0062ac),
              ),
              accountName: Text("Admin",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  )),
              accountEmail: Text("admin@gmail.com",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  )),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? new Color(0xFF0062ac)
                        : Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Color(0xFF0062ac),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Car',
                textScaleFactor: 1.5,
              ),
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (BuildContext context) {
                //   return MapLoadBluetooth(userPersonalData);
                // }));
                pageChangeFunction('car');
              },
            ),
            ListTile(
              title: Text(
                'Truck',
                textScaleFactor: 1.5,
              ),
              onTap: () {
                // setupSignOut(_firebaseUser);
                pageChangeFunction('truck');
              },
            ),
            ListTile(
              title: Text(
                'Van',
                textScaleFactor: 1.5,
              ),
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (BuildContext context) {
                //   return MapLoadBluetooth(userPersonalData);
                // }));
                pageChangeFunction('van');
              },
            ),
            ListTile(
              title: Text(
                'Lorry',
                textScaleFactor: 1.5,
              ),
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (BuildContext context) {
                //   return MapLoadBluetooth(userPersonalData);
                // }));
                pageChangeFunction('lorry');
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// zuul.routes.availability-service.path=/availability-service/**
// zuul.routes.availability-service.service-id=AVAILABILITY-SERVICE
//
// zuul.routes.review-service.path=/review-service/**
// zuul.routes.review-service.service-id=REVIEW-SERVICE
//
// zuul.routes.category-service.path=/category-service/**
// zuul.routes.category-service.service-id=CATEGORY-SERVICE

// final vehicleTypeResponse = await get(Uri.parse(
// 'http://localhost:9090/api/category-service/vehicle/category?category=car'));
// print(vehicleTypeResponse.body);
// var vehicleTypeResponseJson = convert.jsonDecode(vehicleTypeResponse.body);
// print(vehicleTypeResponseJson.runtimeType);
// Map vehicleTypeResponseMap = vehicleTypeResponseJson.asMap();
// print(vehicleTypeResponseJson);
// vehicleTypeResponseMap.values.forEach((value) {
// print(value);
// });
// vehicleTypeResponseMap.keys.forEach((value) {
// print(value);
// });
// vehicleTypeResponseMap.forEach((key, value) {
// print(key);
// print(value['licensePlateNumber']);
// print(value['licensePlateNumber'].runtimeType);
// // Map mmyData = value['licensePlateNumber'].asMap();
// // mmyData.forEach((key1, value1) {
// //   print(value1);
// // });
// });
// final vehicleReviewResponse = await get(Uri.parse('http://localhost:9090/api/review-service/rv/getAll'));
// // print(vehicleReviewResponse.body);
// // Navigator.of(context)
// //     .push(MaterialPageRoute(builder: (BuildContext context) {
// //   return PageChange(vehicleTypeResponse,vehicleReviewResponse);
// // }));
