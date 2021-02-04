import 'package:flutter/material.dart';
import'package:carousel_slider/carousel_slider.dart';

class CustomCarousels extends StatefulWidget{
  CustomCarousels({Key key}):super(key:key);

  @override
  CustomCarouselState createState()=> CustomCarouselState();
}

class CustomCarouselState extends State<CustomCarousels>{
  int _currentIndex=0;

  List<String> imageList=["https://thumbs.dreamstime.com/b/paper-bag-different-groceries-white-wooden-table-space-text-paper-bag-different-groceries-white-wooden-table-159466009.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-r_ZF8_Krk7S98Mb0_9w6q2IGQNZvbK-Y6w&usqp=CAU",
  "https://limetray.com/blog/wp-content/uploads/2020/04/nrd-D6Tu_L3chLE-unsplash-1024x768.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-EY1IZnJfVYooAeJ-1Lb3mcEaPY5vCvsgbw&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxcj5ERsayNKzaQb4vZgBK-nzryeIAo4FShQ&usqp=CAU"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CarouselSlider.builder(
      itemCount: imageList.length,
      options: CarouselOptions(
      height: 200.0,
      enlargeCenterPage: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      pauseAutoPlayOnTouch: true,
      aspectRatio: 2.0,
      viewportFraction: 1.0,
      onPageChanged: (index, reason) {
        setState(() {
          _currentIndex = index;
        });
      },
    ),
      itemBuilder: (context,index){
        return Container(
          //color: Colors.white,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageList[index])
            )
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * 1/2,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                  imageList.map((items){
                    int new_current_index=imageList.indexOf(items);
                    return Container(
                       width: 12.0,
                      height: 12.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex==new_current_index ? Colors.grey :
                              Colors.white
                      ),
                    );
                  }).toList()
                ,
              ),
            ),
          ),
        );
      },
    );
  }
}