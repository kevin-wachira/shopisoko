import 'package:flutter/material.dart';
import'package:carousel_slider/carousel_slider.dart';

class courosel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    int _currentIndex=0;

    List cardList=[
      Item1(),
      Item2(),
      Item3(),
      Item4(),

    ];
    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }
    return StatefulBuilder( builder:
        ( BuildContext context,setState){
      return CarouselSlider(

        options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        items: cardList.map((card){
          return Builder(
              builder:(BuildContext context){
                return Container(
                  height: MediaQuery.of(context).size.height*0.30,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.blueAccent,
                    child: card,
                  ),
                );
              }
          );
        }).toList(),

      );


    },

    );


  }}
// ignore: camel_case_types

class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 80.0,
      margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),

      decoration:  BoxDecoration(
        /*gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
        ),*/
        image:  DecorationImage(
            image: AssetImage("asset/vegetables.png"),
            fit: BoxFit.cover
        ),
      ),

      /*    child: Container(
        margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            color: Colors.blue.shade200,
            image: DecorationImage(
                image: AssetImage("images/bag_1.png"),
                fit: BoxFit.cover
            )),
      ),*/
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff5f2c82), Color(0xff49a09d)]
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Container(
            height: 80.0,
            width: 80.0,
            margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),

            decoration:  BoxDecoration(
              /*gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
        ),*/
              image:  DecorationImage(
                  image: AssetImage("assets/vegetables.jpg"),
                  fit: BoxFit.cover
              ),
            ),

          ),
        ],
      ),
    );
  }
}
class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xffff4000),Color(0xffffcc66),]
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Image.asset(
            "assets/vegetables.jpg",
            height: 150.0,
            width: 150,
            fit: BoxFit.cover,
          ),


        ],
      ),
    );
  }
}

class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600
              )
          ),
        ],
      ),
    );
  }
}