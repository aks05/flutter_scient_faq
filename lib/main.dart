import 'package:flutter/material.dart';
import 'package:flutterscientfaq/faq_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'carousel_button.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String baseUrl = "https://scient-api.herokuapp.com";
  final String url = "https://scient-api.herokuapp.com/api/projects/";

  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(Uri.encodeFull(url));
    print(response.body);

    setState(() {
      var jsonResponse = convert.jsonDecode(response.body);
      data = jsonResponse['results'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    List <Widget> myButtonList = [
      CarouselButton(icon: Icons.image,name: "Gallery",onPressed: (){
        Navigator.pushNamed(context,'/gallery');
      },),
      CarouselButton(icon: Icons.assignment ,name: "Register",onPressed: (){
        Navigator.pushNamed(context,'/registration');
      },),
      CarouselButton(icon: Icons.work,name: "Projects",onPressed: (){
        Navigator.pushNamed(context,'/projects');
      },),
    ];
    return new Scaffold(
      /*appBar: new AppBar(
          title: Text("PROJECTS PAGE!"),
        ),*/
        body: Container(
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 600,
                child:new ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FaqCard(
                      headerTitle: data[index]['title'],
                      listItems: data[index]['description'],);
                  },
                ),
              ),
              CarouselSlider(
                enlargeCenterPage: true,
                autoPlay: false,
                height: 70,
                viewportFraction: 0.4,
                items: myButtonList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.indigoAccent,

                          ),
                          child:i
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
    );
  }
}
void main() {
  runApp(new MaterialApp(
    home: new MyHomePage(),
  ));
}