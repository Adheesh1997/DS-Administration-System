import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front/main.dart';
import 'package:front/utils/colors.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert' as convert;

import 'package:line_icons/line_icons.dart';
import 'package:string_validator/string_validator.dart';

class PageListChange extends StatefulWidget {
  PageListChange(this.vehicleTypeResponse, this.vehicleReviewResponse,
      this.vehicleAvailability);
  final vehicleReviewResponse;
  final vehicleTypeResponse;
  final vehicleAvailability;
  @override
  _PageListChangeState createState() => _PageListChangeState();
}

class _PageListChangeState extends State<PageListChange> {
  int validate = 0;
  int reviewValidate = 0;
  int reviweID = -1;
  int availabilityValidate = 0;
  var reviewComment = '';
  int availabilityId = -1;
  int openButton = 0;
  var vehicleNumber = '';

  @override
  Widget build(BuildContext context) {
    const title = '   🟥 - Not Available     ⬜ - Available';
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();

    Widget _buildFormNameField(
        String label, IconData icon, TextEditingController _textController) {
      return TextFormField(
        controller: _textController,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(
            icon,
            color: Colors.black38,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
        ),
        validator: (var value) {
          if (value!.isNotEmpty) {
            if (!isAlpha(_textController.text) &&
                !contains(_textController.text, '')) {
              return 'Please ! fill this using only letters';
            }
            return null;
          }
          return "Please enter the vehicle Review";
        },
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
      );
    }

    Future<void> pageChangeFunction(var vehicleType) async {
      final vehicleTypeResponse = await get(Uri.parse(
          'http://localhost:9090/api/category-service/vehicle/category?category=$vehicleType'));
      var vehicleTypeResponseJson =
          convert.jsonDecode(vehicleTypeResponse.body);
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
      var vehicleAvailabilityJson =
          convert.jsonDecode(vehicleAvailability.body);
      Map vehicleAvailabilityMap = vehicleAvailabilityJson.asMap();

      print(vehicleAvailabilityMap);
      //

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return PageListChange(vehicleTypeResponseMap, vehicleReviewResponseMap,
            vehicleAvailabilityMap);
      }));
    }

    int checkAvailability(int idd) {
      int id = 0;
      widget.vehicleAvailability.forEach((key, value) {
        if (idd.toString() == value['id']) {
          if (value['availability'] == "In Stock") {
            id = 1;
          }
        }
      });
      return id;
    }

    void validateData(int id) {
      setState(() {
        openButton = 1;
        availabilityId = id;
        reviewValidate = 0;
        validate = 0;
        reviweID = -1;
        widget.vehicleReviewResponse.forEach((key, value) {
          if (id.toString() == value['id']) {
            reviewValidate = 1;
            validate = 1;
            reviweID = key;
          }
        });
        availabilityValidate = checkAvailability(id);
      });
    }

    Future<void> updateAvailabilityId() async {
      print(availabilityId);
      print(availabilityValidate);
      var url = Uri.parse(
          'http://localhost:9090/api/availability-service/availability/updateAvailability/$availabilityId');
      var body;
      if (availabilityValidate == 0) {
        Map data = {"id": "$availabilityId", "availability": "In Stock"};
        body = json.encode(data);
      } else {
        Map data = {"id": "$availabilityId", "availability": "Out of Stock"};
        body = json.encode(data);
      }
      var response = await put(url,
          headers: {"Content-Type": "application/json"}, body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return MyApp();
      }));
    }

    Future<void> deleteReview(var reviweIDD) async {
      int id = int.parse(reviweIDD);
      final vehicleReviewResponse = await delete(
          Uri.parse('http://localhost:9090/api/review-service/rv/by/$id'));
      pageChangeFunction('car');
    }

    Future<void> updateReview() async {

      if(reviweID == -1){
        var reviewUrl = Uri.parse(
            'http://localhost:9090/api/review-service/rv/by/createReview');
        Map reviewData = {
          "id" : "$availabilityId",
          "reviewList": ["${_nameController.text}"]
        };
        var reviewBody = json.encode(reviewData);
        var reviewResponse = await post(reviewUrl,
            headers: {"Content-Type": "application/json"}, body: reviewBody);
        print('Response status: ${reviewResponse.statusCode}');
        print('Response body: ${reviewResponse.body}');
        pageChangeFunction('car');
      }
      else{
        var url = Uri.parse('http://localhost:9090/api/review-service/rv/by/$availabilityId');
        var body;
        widget.vehicleReviewResponse[reviweID]["reviewList"]
            .add(_nameController.text);

        print(_nameController.text);
        body = json.encode(widget.vehicleReviewResponse[reviweID]);
        var response = await put(url,
            headers: {"Content-Type": "application/json"}, body: body);
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        pageChangeFunction('car');
      }
    }

    Future<void> deleteOneReview(String reviewDelete) async {
      var id = widget.vehicleReviewResponse[reviweID]['id'];
      var url = Uri.parse('http://localhost:9090/api/review-service/rv/by/$id');

      widget.vehicleReviewResponse[reviweID]["reviewList"].remove(reviewDelete);
      print(_nameController.text);
      var body = json.encode(widget.vehicleReviewResponse[reviweID]);

      var response = await put(url,
          headers: {"Content-Type": "application/json"}, body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      pageChangeFunction('car');
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      color: Colors.black,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return MyApp();
                  })),
                  child: Icon(
                    Icons.home,
                    size: 26.0,
                    color: Colors.black,
                  ),
                )),
          ],
        ),
        body: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                  child: ListView.separated(
                    itemCount: widget.vehicleTypeResponse.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          tileColor: checkAvailability(widget
                                      .vehicleTypeResponse[index]['id']) ==
                                  1
                              ? Colors.white30
                              : Colors.red,
                          title: Text(
                              "Plate No     =   ${widget.vehicleTypeResponse[index]['licensePlateNumber'].toString()}"),
                          subtitle: Text(
                              "No.of Seats  =   ${widget.vehicleTypeResponse[index]['numberOfSeats'].toString()}"),
                          onTap: () {
                            vehicleNumber = widget.vehicleTypeResponse[index]['licensePlateNumber'].toString();
                            validateData(
                                widget.vehicleTypeResponse[index]['id']);
                          },
                          onLongPress: () {
                            validateData(
                                widget.vehicleTypeResponse[index]['id']);
                            deleteReview(
                                widget.vehicleReviewResponse[reviweID]['id']);
                          });
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.black,
                      );
                    },
                  ),
                )),
            Expanded(
              flex: 5,
              child: Container(
                child: validate != 0 && reviewValidate != 0
                    ? ListView.separated(
                        itemCount: widget
                            .vehicleReviewResponse[reviweID]['reviewList']
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              "${widget.vehicleReviewResponse[reviweID]['reviewList'][index].toString()}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            //onTap: validateData,
                            onLongPress: () => deleteOneReview(widget
                                .vehicleReviewResponse[reviweID]['reviewList']
                                    [index]
                                .toString()),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.black,
                          );
                        },
                      )
                    : Container(),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: openButton == 1
                    ? Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '   $vehicleNumber  ',
                                style:
                                TextStyle(fontSize: 30, color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Container(
                                margin:
                                    EdgeInsets.only(top: 10.0, bottom: 20.0),
                                height: 60.0,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: availabilityValidate == 1
                                      ? primaryColor
                                      : Colors.red,
                                  elevation: 10.0,
                                  shadowColor: Colors.white70,
                                  child: MaterialButton(
                                    //onPressed: () => Navigator.of(context).pushNamed(homeViewRoute),
                                    onPressed: () => updateAvailabilityId(),
                                    child: availabilityValidate == 1
                                        ? Text(
                                            'ALLOW',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20.0,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            'RECEIVED',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              '   Enter the Review to Update !!!',
                              style:
                                  TextStyle(fontSize: 40, color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    _buildFormNameField('Review', LineIcons.car,
                                        _nameController),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  updateReview();
                                }
                              },
                              child: const Text('Update Review'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ]))
                    : Container(),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          elevation: 4,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: new Color(0xFF0062ac),
                ),
                accountName: Text("Admin"),
                accountEmail: Text("admin@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? new Color(0xFF0062ac)
                          : Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
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
        ),
      ),
    );
  }
}
