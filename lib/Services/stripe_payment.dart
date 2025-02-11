import 'package:dio/dio.dart';
import 'package:ecommerencewithproviderstripe/Services/const.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
class StripeService{
  StripeService._();
  static final StripeService instance=StripeService._();

  Future<void> makepayment(int value) async{
    try
    {
      String? paymentIntentClientSecret= await _createPaymentIntent(value,"usd");
      print(paymentIntentClientSecret.toString());
      if(paymentIntentClientSecret==null){
        return;
      }
      else{
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntentClientSecret,
                merchantDisplayName: "Asim"
            ));
      }
      await _processPayment();

    } catch(e){

      print(e.toString());
    }

  }
  Future<String?> _createPaymentIntent(int amount,String currency) async {
    try
    {
      final Dio dio=Dio();
      Map<String,dynamic> data ={
        "amount":calculateAmount(amount),
        "currency":currency,

      };
      var response= await dio.post("https://api.stripe.com/v1/payment_intents",data: data,
          options: Options(contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Bearer ${SecretKey}",
                "Content-Type": "application/x-www-form-urlencoded",
              }));
      if(response.data!=null){
        print(response.data.toString());
        return response.data["client_secret"];
      }
    } catch(e){

      print(e.toString());
    }
  }
  Future<void> _processPayment() async{
    try{
      await Stripe.instance.presentPaymentSheet();

    }
    catch(e){
      print(e.toString());
    }
  }
  String calculateAmount(int amount){
    final calculatedAmount=amount*100;
    return calculatedAmount.toString();
  }
}