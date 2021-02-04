import 'dart:math';
import 'package:sms/sms.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:nikeshi/app_utils/CustomTextStyle.dart';
import 'package:shopisoko/models/cart.dart';
import 'package:shopisoko/models/orders.dart';
import 'package:shopisoko/models/place.dart';
import 'package:shopisoko/models/api.dart';
import 'package:shopisoko/services/order_repository.dart';
import 'package:shopisoko/widgets/cart_component.dart';
import 'package:provider/provider.dart';
import 'package:shopisoko/services/places_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopisoko/models/models.dart';
import 'package:shopisoko/pages/user_information.dart';
class UserContainer extends StatefulWidget{
  UserContainer({Key key, this.title}) : super(key: key);
  final String title;

  @override
  UserContainerState createState() => UserContainerState();


}

class UserContainerState extends State<UserContainer> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  int _payment_value = 1;
  TextEditingController mpesaController;
  TextEditingController nameController;
  TextEditingController locationController;
 // PlacesRepository placesRepository;

  List<Place> listPlace = [];
  double longitude = 0.0;
  double latitude = 0.0;
  String location = '';
  double total_amount = 0;
  bool stk_push_enabled = false;
  Future<Map<String,dynamic>> selectedLocation;
  int location_selected=1;
  int final_amount=0;
  OrderRepository orderRepository=new OrderRepository();
  PlacesRepository placesRepository=new PlacesRepository();
  String confirmed_amount,confirmed_message,confirmed_date;

  SmsReceiver receiver=new SmsReceiver();


  int database_parsed=0;
  String error_message='';
  String transaction_status='';
  int transaction_state=0;
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();

  @override
  void initState() {
    mpesaController = new TextEditingController();
    locationController = new TextEditingController();
    placesRepository = new PlacesRepository();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: createHeader(),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Color.fromRGBO(0,0,139,1)
        ),

      ),
      body:Container(
        width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: Colors.white,
    child: SingleChildScrollView(
    child: Column(
    children: <Widget>[

    standardDelivery(),
    Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
      child: Divider(),
    ),
    selectedAddressSection(),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
        child: Divider(),
      ),
    checkoutListItem(),
    ],
    ),
    ),
    ),
    );
  }

  // Future<String> getDistance() {}

  fetchMapData() async {}



  standardDelivery() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1 / 6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(3.0, 3.0),
                    blurRadius: 5.0,
                    spreadRadius: 3.0,
                    color: Colors.black12)
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Personal Information",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400), //66, 7, 91, 1
                      ),
                    ),
                    GestureDetector(
                      child: Hero(
                        tag: 'personalInfoHero',
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.deepPurple,
                          size: 20,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return UserInformation();
                        }));
                      },
                    )
                  ],
                ),
                Provider.of<User>(context).username.isNotEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 10),
                      child: Text(
                        Provider.of<User>(context).username,
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        Provider.of<User>(context).email,
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 10.0),
                      child: Text(
                        'mobile-' + Provider.of<User>(context).phone,
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ): Text('(Tap to enter personal information)'),
              ],),
          )),
    );
  }

  //

  selectedAddressSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
      child: Container(
        //     margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(3.0, 3.0),
                  blurRadius: 5.0,
                  spreadRadius: 3.0,
                  color: Colors.black12)
            ]),

        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Delivery details",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w400),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_location_alt,
                      color: Colors.deepPurple,
                      size: 20.0,
                    ),
                    onPressed: () {
                      showPlacesDialog();
                    },
                    color: Colors.white,
                  )
                ],
              ),

              Provider.of<User>(context,listen:false).location.isNotEmpty
                  || Provider.of<Orders>(context,listen: false).service_charge.isNotEmpty ?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  createAddressText(
                      'Delivery Address: ' + Provider.of<Orders>(context,listen: false).customer_address, 16),
                  createAddressText("Delivery Fee: Ksh" + Provider.of<Orders>(context,listen: false).service_charge,6),
                  createAddressText("Contact info :" + Provider.of<User>(context,listen: false).phone,6),
                ],) : Text('(Tap to key in shipping/delivery information)'),
              SizedBox(
                height: 6,
              ),

              SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(strAddress,
          style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w600)),
    );
  }

  createHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Checkout information',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontFamily: 'Open Sans',
                  color: Colors.deepPurple,),
              ),
              Text(
                '' + Provider.of<Cart>(context).total_amount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontFamily: 'Open Sans',
                  color: Colors.deepPurple,),
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  checkoutItem() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: Colors.grey.shade200)),
        padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return checkoutListItem();
          },
          itemCount: 1,
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }

  checkoutListItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 3 / 5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(3.0, 3.0),
                  blurRadius: 5.0,
                  spreadRadius: 3.0,
                  color: Colors.black12)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Billing details',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w400),
                  ),
                  Divider(
                    color: Colors.black12,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _payment_value,
                        iconEnabledColor: Color.fromRGBO(0, 0, 0, 1),
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Select Mode Of Payment',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "LIPA NA MPESA(STK Push)",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(0,0,139,1)),
                            ),
                            value: 2,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _payment_value = value;
                            transaction_state=value;
                          });
                        },
                      ))
                ],
              ),
            ),
            transaction_state==2
                ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 2/5,
                child: receiptBreakdownStk())
                :
            transaction_state==3 ?
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
              child: createWaitingWidget(),
            )
                :
            transaction_state==4 ?

            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
              child: transactionSuccessful(confirmed_amount,confirmed_message,confirmed_date),
            )
                :
            Container()
          ],
        ),
      ),
    );
  }

  Widget transactionSuccessful(String amount,String user_order_no,String user_date){
    //Future.delayed(duration:Duration(milliseconds: 5)),
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.green.shade400,
        borderRadius: BorderRadius.circular(20),

      ),

      child: Column(
        children: [
          Center(
            child: Text("Transaction Successful!",style: TextStyle(color: Colors.white),),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
            child: Text(
              "You have sent Ksh " + amount + " to \n Fashion World for "
                  "order no " + user_order_no + "on " + user_date,
              style: TextStyle(color: Colors.white,fontFamily: 'Open Sans',),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: RaisedButton(onPressed: (){

            }, child: Text('OK',style: TextStyle(color: Color.fromRGBO(214,24,195,1)),),
              color: Colors.white,),
          )
        ],
      ),
    );
  }

  Widget receiptBreakdownStk(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 10.0),
            child: Text(
              'Receipt breakdown:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.deepPurple,),
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 3/4,
            child:  Divider(),
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 3.0, horizontal: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 3/4,
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(214,24,195,0.1),

                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      createAddressText('Total',6),
                      createAddressText(Provider.of<Cart>(context,listen: false).total_amount.toDouble().toString(),6),
                    ],
                  ),
                )),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 3.0, horizontal: 10.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 3/4,
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 2.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange.shade50
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        createAddressText('Delivery Fee',6),
                        Provider.of<Orders>(context,listen: false).service_charge.isNotEmpty ?
                        Padding(
                          padding: EdgeInsets.only(top: 6.0),
                          child: Text(int.parse(Provider.of<Orders>(context,listen:false).service_charge.toString()).toDouble().toString(),
                            style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),),
                        ) :
                        Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Container(
                              width: 130,
                              height: 40,
                              child: OutlineButton.icon(
                                onPressed: () {
                                  showPlacesDialog();
                                },
                                // color: Color.fromRGBO(214, 24, 195, 1),
                                icon: Icon(
                                  Icons.add_location_alt,
                                  color: Colors.deepPurple,
                                  size: 10.0,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                borderSide: BorderSide(  color: Colors.deepPurple,),
                                label: Text('Click to add \n delivery location',
                                  style: TextStyle(fontWeight: FontWeight.w500,
                                      color: Colors.deepPurple,
                                      fontFamily: 'roboto',fontSize: 10),),
                              ),
                            )
                        )
                        ,
                      ],
                    )
                )),
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: 3.0, horizontal: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 3/4,
              height: MediaQuery.of(context).size.height * 1/9,
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                      color: Color.fromRGBO(214,24,195,0.1)
                  )

              ),
              child:  Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gross Total',style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600),),
                      Text( Provider.of<Orders>(context,listen:false).service_charge.isNotEmpty ? int.parse(Provider.of<Cart>(context,listen: false).calculate_gross_total(
                          Provider.of<Orders>(context,listen: false).service_charge.toString()).toString()).toDouble().toString() :
                      int.parse(Provider.of<Cart>(context,listen: false).total_amount.toString()).toDouble().toString(),
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('discount',style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),),

                        ],
                      ),
                      Text(Provider.of<Orders>(context,listen: false).discount,
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('VAT',style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600),),
                      Text(Provider.of<Orders>(context).vat_charge_rate,
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Net Total',style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 12,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w600),),
                      Text(
                        int.parse(Provider.of<Cart>(context,listen: false).total_amount.toString()).toDouble().toString(),
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 12,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w600),),
                    ],
                  ),
                ],
              ),
            )),
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 3/4,
              height: 50,
              child: RaisedButton(
                child: Text(
                  "Confirm Payment",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white),
                ),
                color: confirmUserInfo()
                    ? Colors.lightGreen
                    : Colors.greenAccent.shade100,
                elevation: confirmUserInfo() ? 1 : 0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20)),
                onPressed: () {
                  confirmUserInfo()
                      ?
                  startCheckout(
                      userPhone:
                      Provider.of<User>(context,listen: false)
                          .phone
                          .replaceFirst(
                          '0', '254'),
                      amount: convertTotalAmount(
                          Provider.of<Cart>(context,listen: false)
                              .total_amount
                              .toString())) : null;
                },
              ),
            ))
      ],
    );
  }

  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
          ),
          Text(
            value,
            style: TextStyle(color: color, fontSize: 12),
          )
        ],
      ),
    );
  }

  Future<void> startCheckout({String userPhone, double amount}) async {
    MpesaFlutterPlugin.setConsumerKey('zpTyoAc3DKWGc7N8AyEozevzIz15Eshg');
    MpesaFlutterPlugin.setConsumerSecret('ijAFnZN43WT1oeaz');
    transaction_status='';
    dynamic transactionInitialisation;
    try {
      transactionInitialisation =
      await MpesaFlutterPlugin.initializeMpesaSTKPush(
        //     businessShortCode: '174379',
          businessShortCode: '174379',
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: 1.0,
          partyA: userPhone,
          partyB: '174379',
          callBackURL: Uri(
              scheme: "https",
              host: "myshopilyv.com",
              path: '/shopisoko/stkconfirmation.php'),
          //    callBackURL: Uri(scheme: "http",host:'myshopilyv.com',path: '/trans/ecomstk'),
          accountReference: 'shopisoko',
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: 'shopisoko',
          passKey:
          'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');
      var result=transactionInitialisation as Map<String,dynamic>;

      if(result.keys.contains("ResponseCode")){
        String mResponseCode=result["ResponseCode"];
        if(mResponseCode=='0'){
          setState(() {
            transaction_state=3;
          });
          await listenForMpesaMessage(context);
        }
      }
      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      // return transactionInitialisation;
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }



  showPlacesDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, updateState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Stack(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            left: 20, top: 20, right: 20, bottom: 45),
                        margin: EdgeInsets.only(top: 45),
                        height: MediaQuery.of(context).size.height * 1/2,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 5,
                                  spreadRadius: 5)
                            ]),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  " Delivery location details",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.deepPurple,

                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: TextField(
                                  style: TextStyle(fontSize: 14.0),
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  controller: locationController,
                                  onEditingComplete: (){
                                    if(locationController.text.isEmpty){
                                      updateState((){
                                        selectedLocation=null;
                                        listPlace.clear();
                                        listPlace=[];
                                        locationController.text='';
                                        location='';
                                        final_amount=0;
                                      });
                                    }

                                    else if(locationController.text.isNotEmpty){
                                      updateState((){
                                        getPlaces(locationController.text);

                                      });
                                    }
                                  },
                                  onChanged: (text) {
                                    if (text.length > 0) {
                                      //listPlace=getPlaces(text);
                                      updateState(() {
                                        getPlaces(text);
                                      });
                                    } else if (text.length ==0 || text.isEmpty) {
                                      updateState(() {
                                        selectedLocation=null;
                                        listPlace.clear();
                                        listPlace = [];
                                        locationController.text='';
                                        location='';
                                        final_amount=0;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter drop of location',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    filled: true,
                                    fillColor:
                                    Color.fromRGBO(220, 153, 89, 0.1),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.deepPurple,),
                                        borderRadius:
                                        BorderRadius.circular(20.0)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                        BorderRadius.circular(20.0)),
                                    suffixIcon: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 0.0),
                                      child: Icon(Icons.add_location_alt,
                                        color: Colors.deepPurple,
                                        // color:last_name_enabled ? Color.fromRGBO(214,24,195,1):Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              listPlace.length > 0
                                  ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height:
                                  MediaQuery.of(context).size.height *
                                      .20,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(
                                          220, 153, 89, 0.1),
                                      borderRadius:
                                      BorderRadius.circular(25)),
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Row(
                                            children: [
                                              Icon(Icons.location_on,
                                                color: Colors.deepPurple,),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  listPlace[index].name !=
                                                      null
                                                      ? listPlace[index]
                                                      .name
                                                      : '',
                                                  overflow:
                                                  TextOverflow.fade,
                                                  softWrap: true,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                .90,
                                            child: Text(
                                              listPlace[index]
                                                  .formattedAddress !=
                                                  null
                                                  ? listPlace[index]
                                                  .formattedAddress
                                                  : ' ',
                                              overflow: TextOverflow.fade,
                                              softWrap: true,
                                              maxLines: 1,
                                            ),
                                          ),
                                          onTap: () {
                                            updateState(() {
                                              selectedLocation=decodeLocation(
                                                  listPlace[index]
                                                      .locationId);
                                              locationController.text =
                                                  listPlace[index].name;
                                              location =
                                                  locationController.text;
                                              listPlace.clear();
                                              listPlace = [];
                                              print('The location is ' +
                                                  location);
                                            });
                                          },
                                        );
                                      },
                                      separatorBuilder:
                                          (context, index) => Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 10,
                                            right: 10),
                                        child: Divider(
                                          height: 1,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                      itemCount: listPlace.length),
                                ),
                              )
                                  : Container(),
                              SizedBox(
                                height: 15,
                              ),

                              selectedLocation!=null ?
                              Container(
                                child: FutureBuilder(
                                  future: selectedLocation,
                                  builder: (context,snapshot){
                                    if(snapshot.hasData && snapshot.data!=null){
                                      location_selected=0;
                                      print('the selected location is ' + selectedLocation.toString());
                                      final_amount=(calculateDistance(-1.0387569, 37.0833753, latitude, longitude)).toInt();
                                      return Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height *1/9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.0),
                                              color: Color.fromRGBO(220, 153, 89, 0.1)),

                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('Destination: ',style: TextStyle(color: Colors.black54,
                                                          fontFamily: 'Open Sans',fontWeight: FontWeight.w600),),
                                                      Text(location,style: TextStyle(  color: Colors.deepPurple,
                                                          fontFamily: 'Open Sans',fontWeight: FontWeight.w600),)
                                                    ],
                                                  )
                                              ),
                                              Divider(),
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 30.0,top: 2.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('Delivery fee: ',
                                                        style: TextStyle(color: Colors.black45,
                                                            fontFamily: 'Open Sans',fontWeight: FontWeight.w600)),
                                                    Text('Ksh ' + final_amount.toString(),
                                                        style: TextStyle(  color: Colors.deepPurple,
                                                            fontFamily: 'Open Sans',fontWeight: FontWeight.w600))
                                                  ],
                                                ),
                                              ),


                                            ],
                                          ),
                                        ),
                                      );
                                    }

                                    /*else if(snapshot.data==null){
                                      return Text('No data yet');
                                    }*/
                                    else if(snapshot.hasError){
                                      locationController.text='';
                                      location='';
                                      final_amount=0;
                                      location_selected=2;

                                      return Container(
                                        child: Text('error loading data'),
                                      );
                                    }
                                    else{
                                      return Container(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            valueColor: new AlwaysStoppedAnimation<Color>(
                                                Color.fromRGBO(214, 24, 195, 1)),
                                            strokeWidth: 5,),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ) : Container(),
                              SizedBox(
                                height: 22,
                              ),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0.0,
                                            horizontal: 2.0),
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          child: RaisedButton(
                                            onPressed: () {
                                              saveDeliveryDetails();
                                              updateState((){
                                                flushUIdetails();
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            color: Colors.deepPurple,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24))),
                                            child: Text(
                                              "Save",
                                              style: TextStyle(color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0.0,
                                            horizontal: 2.0),
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          child:  OutlineButton(
                                            onPressed: () {
                                              updateState((){
                                                flushUIdetails();
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            // color: Color.fromRGBO(214, 24, 195, 1),

                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24))),
                                            child: Text(
                                              "Cancel",style: TextStyle(color: Colors.black45,fontSize: 14),),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              );
            },
          );
        });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    print('The distance is ${12742 * asin(sqrt(a))}');
    return CalculatePrice(12742 * asin(sqrt(a)));
  }

  getPlaces(String query) async {
    String url2 =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=${Config.apiKey}&input=${Uri.encodeQueryComponent(query)}";
    Response response = await Dio().get(url2);
    listPlace = Place.parseLocationList(response.data);
    return listPlace;
  }

  Future<Map<String,dynamic>> decodeLocation(String id) async {
    Map<String,dynamic> placeLatLng;
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?key=${Config.apiKey}&placeid=" +
            Uri.encodeQueryComponent(id);
    //Uri.encodeQueryComponent(query)
    Response response = await Dio().get(url)
    // ignore: missing_return
        .then((Response results) async {
      placeLatLng =
      results.data['result']['geometry']['location'];
      setState(() {
        latitude = double.parse(placeLatLng['lat'].toString());
        longitude = double.parse(placeLatLng['lng'].toString());
        print('The latitude is ' + latitude.toString());
        print('The longitude is ' + longitude.toString());
      });
    });

    return placeLatLng;
  }


  bool confirmUserInfo() {
    if (Provider.of<User>(context,listen: false).fname.length > 0 &&
        Provider.of<User>(context,listen: false).lname.length > 0 &&
        Provider.of<User>(context,listen: false).phone.length > 0 &&
        Provider.of<User>(context,listen: false).email.length > 0) {
      setState(() {
        stk_push_enabled = true;
      });
      return stk_push_enabled;
    } else {
      setState(() {
        stk_push_enabled = false;
      });
      return stk_push_enabled;
    }
  }

  double convertTotalAmount(String amount) {
    double final_Amount = double.parse(amount);
    return final_Amount;
  }


  double CalculatePrice(double distance){
    if(distance < 10.0){
      final_amount=100;
    }
    else if(distance >= 10.0 && distance < 20){
      final_amount=200;
    }

    else if(distance >= 20.0 && distance < 30){
      final_amount=300;
    }

    else if( distance > 30){
      final_amount=1000;
    }
    return final_amount.toDouble();
  }



  saveDeliveryDetails(){
    if(locationController.text.isNotEmpty && final_amount > 0 && location_selected==0){
      setState(() {
        Provider.of<Orders>(context,listen: false).customer_address=locationController.text;
        Provider.of<Orders>(context,listen: false).service_charge=final_amount.toString();
        print('The location is ' + Provider.of<Orders>(context,listen: false).customer_address +
            'The amount is ' + Provider.of<Orders>(context,listen: false).service_charge + 'the error code is ' +
            location_selected.toString());
        locationController.text='';
        final_amount=0;
        location_selected=1;

      });

    }

    else{
      setState(() {
        print('The location is ' + Provider.of<Orders>(context,listen: false).customer_address +
            'The amount is ' + Provider.of<Orders>(context,listen: false).service_charge + 'the error code is ' +
            location_selected.toString());
        //  location_selected=2;

      });
    }
  }

  Widget createWaitingWidget(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: Center(
        child: Text("Waiting for Mpesa confirmation....",
          style: TextStyle(color: Colors.green.shade400,fontWeight: FontWeight.w500),),
      ),
    );
  }
  Future<void> listenForMpesaMessage(BuildContext context) async{
    receiver.onSmsReceived.listen((SmsMessage message) async {
      if(message.sender=="MPESA"){
        if(message.body.contains('shopisoko')){
          bool is_saved=await saveOrder().then((value){
            if(value){
              return true;
            }
            else{
              return false;
            }
          });
          if(is_saved){
            transaction_status='done';
          }
          return is_saved;
        }

        else{
          return false;
        }
      }

    });
  }

  flushUIdetails(){
    setState((){
      selectedLocation=null;
      listPlace.clear();
      listPlace = [];
      locationController.text='';
      location='';
      final_amount=0;
    });
  }

  Future<bool> createOrder(String generatedId) async{
    createUserPreferences();
    Provider.of<Orders>(context,listen: false).bill_no='0000001';
    Provider.of<Orders>(context,listen: false).customer_name=Provider.of<User>(context,listen: false).username;
    Provider.of<Orders>(context,listen: false).customer_phone=Provider.of<User>(context,listen: false).phone;
    Provider.of<Orders>(context,listen: false).gross_amount=int.parse(Provider.of<Cart>(context,listen: false).total_amount.toString()).toDouble().toString();
    Provider.of<Orders>(context,listen: false).net_amount=int.parse(Provider.of<Cart>(context,listen: false).total_amount.toString()).toDouble().toString();
    print('The generated Id is ' + generatedId);
    Provider.of<Orders>(context,listen: false).type='MpesaSTK';
    Provider.of<Orders>(context,listen: false).receipt_no=generatedId;
    Provider.of<Orders>(context,listen: false).invoice_no=generatedId;
    Provider.of<Orders>(context,listen: false).paid_status='0';
    Provider.of<Orders>(context,listen:false).user_id='1';
    bool order_created=await orderRepository.insertOrders(Provider.of<Orders>(context,listen: false)).then((value){
      if(value=='OK'){
        print('Order creation process is ' + true.toString());
        return true;
      }
      else{
        print('Order creation process is ' + false.toString());
        return false;
      }
    });
    return order_created;
  }

  Future<bool>checkExistingCustomer(String generatedId) async{
    bool userExists=await orderRepository.checkUser(Provider.of<User>(context,listen: false).phone);
    if(userExists){
      print('User exists');
      bool order_inserted=await createOrder(generatedId).then((value_first) async{
        if(value_first){
          //insert order Items
          bool final_order_items;
          for(int i=0;i<Provider.of<Cart>(context,listen: false).cart_size;i++){
            bool insert_order_item= await orderRepository.insertOrderItems(
                Provider.of<Cart>(context,listen: false).cart_items_data.elementAt(i), Provider.of<Orders>(context,listen: false)).then((value1){
              if(value1=='OK'){
                print('order Items inserted');
                return true;
              }
              else{
                print('Order Items not inserted');
                return false;
              }
            });
            final_order_items=insert_order_item;
          }
          return final_order_items;
        }
        else{
          return false;
        }
      });
      return order_inserted;
    }
    else{
      print('User doesnt exist');
      bool customer_inserted=await orderRepository.insertCustomer(Provider.of<User>(context,listen: false)).then((value) async {
        if(value){
          bool order_inserted=await createOrder(generatedId).then((value) async{
            if(value){
              //insert order Items
              bool final_order_items;
              for(int i=0;i<Provider.of<Cart>(context,listen: false).cart_size;i++){
                bool insert_order_item= await orderRepository.insertOrderItems(
                    Provider.of<Cart>(context,listen: false).cart_items_data.elementAt(i), Provider.of<Orders>(context)).then((value){
                  if(value=='OK'){
                    return true;
                  }
                  else{
                    print('Order Items not inserted');
                    return false;
                  }
                });
                final_order_items=insert_order_item;
              }
              return final_order_items;
            }
            else{
              return false;
            }
          });
          print ('The value of order inserted is ' + order_inserted.toString());
          return order_inserted;
        }
        else{
          print('The value of order inserted is ' + false.toString() + 'Outside loop');
          return false;
        }
      });
      print('The value of customer inserted is ' + customer_inserted.toString());
      return customer_inserted;
    }
  }


  Future<void> createUserPreferences() async{
    final SharedPreferences pref=await _prefs;
    pref.setString('username',Provider.of<User>(context,listen: false).username);
    pref.setString('email',Provider.of<User>(context,listen: false).email);
    pref.setString('phone',Provider.of<User>(context,listen: false).phone);
  }

  createReceiptNo(String previous_receipt_id){
    //NumberFormat formatter=new NumberFormat('000000');
    int temp_receipt_id=int.parse(previous_receipt_id);

  }

  int calculate_gross_total(int total_amount,String delivery_fee){
    double temp_total=total_amount.toDouble();
    double temp_delivery_fee=int.parse(delivery_fee).toDouble();
    double final_amount=temp_total + temp_delivery_fee;
    total_amount=final_amount.toInt();
    //notifyListeners();
    return total_amount;
  }


  String generateOrderId(String from_database){
    print('The string to be used is ' + from_database);
    String sub_from_database=from_database;
    database_parsed=int.parse(sub_from_database);
    database_parsed++;
    String k=database_parsed.toString().padLeft(4,'0');
    String gen_doc=k;
    return gen_doc;
  }

  Future<bool> saveOrder() async{
    bool orderStatus=await this.orderRepository.getPreviousReceiptNo().then((value) async{
      String generatedId='';
      if(value=='no result'){
        generatedId=generateOrderId('0000000');
      }
      else{
        generatedId=generateOrderId(value);
      }
      bool customer_profile_created=await checkExistingCustomer(generatedId);
      if(customer_profile_created){
        print('profile created');
        return true;
      }
      else{
        print('profile not created');
        return false;
      }
    });
    return orderStatus;
  }



}