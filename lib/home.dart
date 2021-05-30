import 'package:flutter/material.dart';
//import 'package:payment/qr.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Razorpay razorpay;
  TextEditingController amount = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout(){
    var options = {
      "key" : "rzp_test_V7WQ6qHKF4DGDk",
      "amount" : num.parse(amount.text)*100,
      "name" : "Metro Run",
      "description" : "Ticket Booking",
      "prefill" : {
        "contact" : " ",
        "email" : " "
      },
      "external" : {
        "wallets" : ["paytm"]
      }
    };

    try{
      razorpay.open(options);

    }catch(e){
      print(e.toString());
    }

  }

  void handlerPaymentSuccess(PaymentSuccessResponse response){
    print("Pament success");
    Toast.show("Payment success", context);
     
    //Widget build(BuildContext context) {}
   
  }
  
  void handlerErrorFailure(PaymentFailureResponse response){
    print("Pament error");
    Toast.show("Payment error", context);
  }

  void handlerExternalWallet(){
    print("External Wallet");
    Toast.show("External Wallet Error", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: amount,
              decoration: InputDecoration(
                hintText: "amount to pay"
              ),
            ),
            SizedBox(height: 12,),
            RaisedButton(
              color: Colors.blue,
              child: Text("Pay", style: TextStyle(
                color: Colors.white
              ),),
              onPressed: (){
                openCheckout();
              },
            )
          ],
        ),
      ),
    );
  }
}