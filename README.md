# myfatoorah_flutter

> 📘 Flutter SDK New Version
>
> Starting from version '3.0.0', MyFatoorah has uploaded a new plugin that depends directly on the native implementation. The following link is the migration guideline: [Migration to the new Flutter SDK](doc:flutter-migration)

_Demo project _

**Flutter Plugin**: <https://pub.dev/packages/myfatoorah_flutter>  
**Flutter Plugin Demo**: <https://dev.azure.com/myfatoorahsc/_git/MF-SDK-Cross-Platforms-Demos>

## Installation /Usage

1. Add the MyFatoorah plugin to your `pubspec.yaml` file.

```text
dependencies:
  myfatoorah_flutter: ^3.2.3
```

2. Install the plugin by running the following command.

   **$ flutter pub get**

3. Import the plugin like this:

```d
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
```

4. Initiate the MyFatoorah Plugin with the following line:

```d
MFSDK.init("Add Your API Key", MFCountry.KUWAIT, MFEnvironment.TEST);
```

5. (Optional)

```d
// Use the following lines if you want to set up the properties of AppBar.
  setUpActionBar() {
    MFSDK.setUpActionBar(
        toolBarTitle: 'Company Payment',
        toolBarTitleColor: '#FFEB3B',
        toolBarBackgroundColor: '#CA0404',
        isShowToolBar: true);
  }
```

> 📘 After testing
>
> Once your testing is finished, simply replace environment from TEST to LIVE and the API URL with the live, click [here ](doc:live-account)for more information.

## Initiate / Execute Payment

As described earlier for the [Gateway Integration](doc:gateway-integration), we are going to have the SDK integrated with the same steps to make a successful integration with the SDK

> 🚧 Initiate Payment
>
> As a good practice, you don't have to call the [Initiate Payment](doc:initiate-payment) function every time you need to execute payment, but you have to call it at least once to save the PaymentMethodId that you will need to call [Execute Payment]\(doc:execute-payment

```d Dart
// Initiate Payment
  initiatePayment() async {
    MFInitiatePaymentRequest request = MFInitiatePaymentRequest(
        invoiceAmount: 10, currencyIso: MFCurrencyISO.SAUDIARABIA_SAR);
    await MFSDK
        .initiatePayment(request, MFLanguage.ENGLISH)
        .then((value) => debugPrint(value.toString()))
        .catchError((error) => {debugPrint(error.message)});
  }

  
  // executePayment 
  
	// The value "1" is the paymentMethodId of KNET payment method.
  // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
  executePayment() async {
    MFExecutePaymentRequest request = MFExecutePaymentRequest(invoiceValue: 10);
    request.paymentMethodId = 1;

    await MFSDK
        .executePayment(request, MFLanguage.ENGLISH, (invoiceId) {
          debugPrint(invoiceId);
        })
        .then((value) => debugPrint(value.toString()))
        .catchError((error) => {debugPrint(error.message)});
  }
```

## Send Payment

We have explained in the [Send Payment](doc:send-payment) section earlier, the different usage cases for it and how it works, here we are going to embed some sample code for calling it through the SDK on the different platforms

```d Dart
  sendPayment() async {
    MFSendPaymentRequest request = MFSendPaymentRequest();
    request.customerName = "TEESST";
    request.invoiceValue = 10;
    request.notificationOption = MFNotificationOption.EMAIL;

    await MFSDK
        .sendPayment(request, MFLanguage.ENGLISH)
        .then((value) => debugPrint(value.toString()))
        .catchError((error) => {debugPrint(error.message)});
  }
```

## Payment Enquiry

We have explained the main usage for the [Payment Inquiry](doc:payment-inquiry) function, which will enable your application to get the full details about a certain invoice/payment. You can use this function within your application on the different platforms as well. Here we are explaining some samples of its usage through the SDK.

```d Dart
  getPaymentStatus() async {
    MFGetPaymentStatusRequest request = MFGetPaymentStatusRequest(
        key: '2593740', keyType: MFKeyType.INVOICEID.name);
    await mfSDK
        .getPaymentStatus(request, MFLanguage.ENGLISH.name)
        .then((value) => debugPrint(value.toString()))
        .catchError((error) => {debugPrint(error.message)});
  }
```

## Embedded Payment Usage

**_Step 1:_**

Create an instance of `MFPaymentCardView` and add it to your `build()` function like the following:

```d Dart
class _MyAppState extends State<MyApp> {
  ...
  late MFCardPaymentView mfCardView;
  ...
}
```

`Note:` you could custom a lot of properties of the payment card view like the following:

```d Dart
  MFCardViewStyle cardViewStyle() {
    MFCardViewStyle cardViewStyle = MFCardViewStyle();
    cardViewStyle.cardHeight = 200;
    cardViewStyle.hideCardIcons = false;
    cardViewStyle.input?.inputMargin = 5;
    cardViewStyle.label?.display = true;
    cardViewStyle.input?.fontFamily = MFFontFamily.Monaco;
    cardViewStyle.label?.fontWeight = MFFontWeight.Heavy;
    return cardViewStyle;
  }

@override
Widget build(BuildContext context) {
  mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());
 	...
}

Widget embeddedCardView() {
  return Column(
    children: [
      SizedBox(
        height: 200,
        child: mfCardView,
      ),
    ],
  );
}
```

**_Step 2:_**

You need to call `initSession()` function to create a session. You need to do this for each payment separately. The session is valid for only one payment. and inside its success state, call `load()` function and pass it the session response, to load the payment card view on the screen, like the following:

`Note:` If you want to use the saved card option with embedded payment, send the parameter customerIdentifier in the `MFInitiateSessionRequest` with a unique value for each customer. This value cannot be used for more than one Customer. Check the commented lines in the following code.

```d Dart
  initSession() async {
    /*
      If you want to use saved card option with embedded payment, send the parameter
      "customerIdentifier" with a unique value for each customer. This value cannot be used
      for more than one Customer.
     */
    // var request = MFInitiateSessionRequest("12332212");
    /*
      If not, then send null like this.
     */
    MFInitiateSessionRequest initiateSessionRequest = MFInitiateSessionRequest();

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
        .then((value) => loadEmbeddedPayment(value))
        .catchError((error) => {debugPrint(error.message)});
  }

  loadEmbeddedPayment(MFInitiateSessionResponse session) {
    loadCardView(session);
    if (Platform.isIOS) applePayPayment(session);
  }

  loadCardView(MFInitiateSessionResponse session) {
    mfCardView.load(session, (bin) {debugPrint(bin)});
  }
```

`Note:` The `initSession()` function should called after `MFSDK.init()` function (that we mentioned above).

**_Step 3:_**

Finally, you need to handle your `Pay` button to call the `pay()` function, copy the below code to your pay event handler section:

```d Dart
  pay() async {
    var executePaymentRequest = MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.sessionId = sessionId;

    await mfCardView
        .pay(executePaymentRequest, MFLanguage.ENGLISH, (invoiceId) {
          debugPrint(invoiceId);
        })
        .then((value) => {debugPrint(value.toString())})
        .catchError((error) => {debugPrint(error.message)});
  }
```

## Apple Pay Embedded Payment (new for iOS only)

To provide a better user experience to your Apple Pay users, MyFatoorah is providing the Apple Pay embedded payment. Follow these steps:

**_Step 1:_**

Create an instance of `MFApplePayButton` and add it to your `build()` function like the following:

```d Dart
class _MyAppState extends State<MyApp> {
  ...
  late MFApplePayButton mfApplePayButton;
  ...
}

@override
Widget build(BuildContext context) {
  mfApplePayButton = MFApplePayButton(applePayStyle: MFApplePayStyle());
 	...
}

Widget applePayView() {
  return Column(
    children: [
      SizedBox(
        height: 50,
        child: mfApplePayButton,
      )
    ],
  );
}
```

**_Step 2:_**

You need to call `applePayPayment()` function to create a session. You need to do this for each payment separately. `Session` is valid for only one payment. and inside its success state.

```d Dart
  applePayPayment(MFInitiateSessionResponse session) async {
    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.KUWAIT_KWD;

    await mfApplePayButton
        .displayApplePayButton(session, executePaymentRequest, MFLanguage.ENGLISH)
        .then((value) => {
              mfApplePayButton
                  .executeApplePayButton(null, (invoiceId) => {debugPrint(invoiceId)})
                  .then((value) => {debugPrint(value.toString())})
                  .catchError((error) => {debugPrint(error.message)})
            })
        .catchError((error) => {debugPrint(error.message)});
  }
```

`Note:` The `applePayPayment()` function should called after `MFSDK.init()` function (that we mentioned above).

## Direct Payment / Tokenization

As we have explained earlier in the [Direct Payment](doc:direct-payment) integration and how it works, it also has the same scenario for the SDK implementation, you have to know the following steps to understand how it works:

- Get the payment method that allows Direct Payment by calling initiatePayment to get paymentMethodId
- Collect card info from user **_MFCard(cardHolderName: 'myFatoorah', number: '5454545454545454',  expiryMonth: '10', expiryYear: '23', securityCode: '000')_**
- If you want to save your credit card info and get a token for your next payment you have to set **_saveToken: true_ ** and you will get the token in the response read more in [Tokenization](doc:tokenization)
- Now you are ready to execute the payment, please check the following sample code

```Text dart
  executeDirectPayment() async {
    var executePaymentRequest = MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.paymentMethodId = 20;

    var mfCardRequest = MFCard(
            cardHolderName: 'myFatoorah',
            number: '5454545454545454',
            expiryMonth: '10',
            expiryYear: '23',
            securityCode: '000',
          );

    var directPaymentRequest = MFDirectPaymentRequest(
        executePaymentRequest: executePaymentRequest,
        token: null,
        card: mfCardRequest);

    await MFSDK
        .executeDirectPayment(directPaymentRequest, MFLanguage.ENGLISH,
            (invoiceId) {
          debugPrint(invoiceId);
        })
        .then((value) => debugPrint(value.toString()))
        .catchError((error) => {debugPrint(error.message)});
  }
```

