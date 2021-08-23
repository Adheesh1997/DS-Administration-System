import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/main.dart';
import 'package:http/http.dart';
import 'package:line_icons/line_icons.dart';
import 'package:string_validator/string_validator.dart';
import 'package:front/utils/colors.dart';
import 'dart:convert' as convert;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _seatController = TextEditingController();
  final TextEditingController _reviewController =
      TextEditingController();

  int _emailValidator = 0;
  final bar = SnackBar(content: Text('Hello, world!'));

  @override
  Widget build(BuildContext context) {
    final appBar = Padding(
      padding: EdgeInsets.only(bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )
        ],
      ),
    );

    final pageTitle = Container(
      child: Text(
        "   Add Vehicle Details !!! ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 40.0,
        ),
      ),
    );

    final formFieldSpacing = SizedBox(
      height: 30.0,
    );

    final registerForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildFormTypeField(
                'Vehicle Type', LineIcons.car, _typeController),
            formFieldSpacing,
            _buildFormNumberField('License Plate Number',
                LineIcons.wordFile, _numberController),
            formFieldSpacing,
            _buildFormSeatField(
                'Number Of Seats', LineIcons.chair, _seatController),
            formFieldSpacing,
            buildFormReviewField(
                'Reviews', LineIcons.book, _reviewController),
            formFieldSpacing,
          ],
        ),
      ),
    );

    final submitBtn = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: Colors.white),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(7.0),
          color: primaryColor,
          elevation: 10.0,
          shadowColor: Colors.white70,
          child: MaterialButton(
            //onPressed: () => Navigator.of(context).pushNamed(homeViewRoute),
            onPressed: () async {
              _emailValidator = 0;
              if (_formKey.currentState!.validate()) {
                _registerVehicle();
              }
            },
            child: Text(
              'Submit Details',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
        body: Row(children: <Widget>[
      Expanded(
        flex: 5,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              children: <Widget>[
                appBar,
                Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      pageTitle,
                      registerForm,
                      Divider(),
                      submitBtn,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Expanded(
        flex: 5,
         child: Container(
            height: 500.0,
            width: 700.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/images.jfif'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          )
      )
    ])

    );
  }

  Widget _buildFormTypeField(
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
        return "Please enter the vehicle type";
      },
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
  }

  Widget _buildFormNumberField(
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
          if (!!isNumeric(_textController.text) &&
              !isAlpha(_textController.text)) {
            return 'Please ! fill this use correct vehicle number';
          }
          return null;
        }
        return _emailValidator != 1
            ? " This vehicle number is Already used "
            : "Please Enter the vehicle number";
      },
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
  }

  Widget _buildFormSeatField(
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
        print(_textController);
        if (value!.isNotEmpty) {
          if (!isNumeric(_textController.text)) {
            return 'Use Numbers';
          }
          return null;
        }
        return 'Please enter the Number of seat';
      },
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
  }

  Widget buildFormReviewField(
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
        print(_textController);
        if (value!.isNotEmpty) {
          if (!isLength(_textController.text, 3)) {
            return 'Use characters more than 8';
          }
          return null;
        }
        return 'Please enter the Review';
      },
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
  }

  Future<void> _registerVehicle() async {

    var urlVehicleReg = Uri.parse('http://localhost:9090/api/category-service/vehicle/create');
    Map vehicleData = {
      "licensePlateNumber": "${_numberController.text}",
      "category":"${_typeController.text.toLowerCase()}",
      "numberOfSeats":"${_seatController.text}"
    };
    //encode Map to JSON
    var bodyVehicle = json.encode(vehicleData);

    var responseVehicle = await post(urlVehicleReg,
        headers: {"Content-Type": "application/json"},
        body: bodyVehicle
    );
    print('Response status: ${responseVehicle.statusCode}');
    print('Response body: ${responseVehicle.body}');
    var vehicleTypeResponseJson = convert.jsonDecode(responseVehicle.body);
     int id = vehicleTypeResponseJson['id'];

    var reviewUrl = Uri.parse(
        'http://localhost:9090/api/review-service/rv/by/createReview');
    Map reviewData = {
      "id" : "$id",
      "reviewList": ["${_reviewController.text}"]
    };
    var reviewBody = json.encode(reviewData);
    var reviewResponse = await post(reviewUrl,
        headers: {"Content-Type": "application/json"}, body: reviewBody);
    print('Response status: ${reviewResponse.statusCode}');
    print('Response body: ${reviewResponse.body}');


    var availabilityUrl = Uri.parse(
        'http://localhost:9090/api/availability-service/availability/setAvailability');
    Map availabilityData = {
      "id" : "$id",
      "availability": "In Stock"
    };
    var availabilityBody = json.encode(availabilityData);
    var availabilityResponse = await post(availabilityUrl,
        headers: {"Content-Type": "application/json"}, body: availabilityBody);
    print('Response status: ${availabilityResponse.statusCode}');
    print('Response body: ${availabilityResponse.body}');


    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return MyApp();
    }));
  }
}
