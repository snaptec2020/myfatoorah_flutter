// ignore_for_file: constant_identifier_names, file_names

class MFConstants {
  static const String MFModuleNAME = "MFModule";
  static const String MFCardViewModuleNAME = "MFCardView";
  static const String MFGooglePayButtonModuleNAME = "MFGooglePayButton";
  static const String MFApplePayModuleNAME = "MFApplePay";
  static const String MFEventChannelName = "onEventChannel";
  static final ChannelName channelName = ChannelName();
  static const BufferType bufferType = BufferType();
}

class ChannelName {
  final String loadConfig = "MF.MFSDKHelper.loadConfig";
  final String setUpActionBar = "MF.MFSDKHelper.setUpActionBar";
  final String initiatePayment = "MF.MFSDKHelper.initiatePayment";
  final String sendPayment = "MF.MFSDKHelper.sendPayment";
  final String getPaymentStatus = "MF.MFSDKHelper.getPaymentStatus";
  final String executePayment = "MF.MFSDKHelper.executePayment";
  final String executePaymentWithSavedToken =
      "MF.MFSDKHelper.executePaymentWithSavedToken";
  final String executeDirectPayment = "MF.MFSDKHelper.executeDirectPayment";
  final String cancelToken = "MF.MFSDKHelper.cancelToken";
  final String cancelRecurringPayment = "MF.MFSDKHelper.cancelRecurringPayment";
  final String initSession = "MF.MFSDKHelper.initSession";
  final String load = "MF.MFSDKHelper.load";
  final String initiateSession = "MF.MFSDKHelper.initiateSession";
  final String pay = "MF.MFSDKHelper.pay";
  final String validate = "MF.MFSDKHelper.validate";
  final String googlePayPayment = "MF.MFSDKHelper.googlePayPayment";
  final String applePayPayment = "MF.MFSDKHelper.applePayPayment";
  final String applePayLoad = "MF.MFSDKHelper.applePayLoad";
  final String displayApplePayButton = "MF.MFSDKHelper.displayApplePayButton";
  final String executeApplePayButton = "MF.MFSDKHelper.executeApplePayButton";
  final String setupApplePay = "MF.MFSDKHelper.setupApplePay";
  final String openPaymentSheet = "MF.MFSDKHelper.openPaymentSheet";
  final String executeApplePayPayment = "MF.MFSDKHelper.executeApplePayPayment";
  final String updateApplePayAmount = "MF.MFSDKHelper.updateApplePayAmount";
}

class BufferType {
  const BufferType();
  static const int MFPaymentWithSavedTokenRequest = 130;
  static const int MFDirectPaymentRequest = 131;
  static const int MFDirectPaymentResponse = 132;
  static const int MFExecutePaymentRequest = 133;
  static const int MFGetPaymentStatusRequest = 134;
  static const int MFGetPaymentStatusResponse = 135;
  static const int MFInitiatePaymentRequest = 136;
  static const int MFInitiatePaymentResponse = 137;
  static const int MFInitiateSessionRequest = 138;
  static const int MFInitiateSessionResponse = 139;
  static const int MFSendPaymentRequest = 144;
  static const int MFSendPaymentResponse = 145;
  static const int MFCallbackResponse = 146;
  static const int MFGooglePayRequest = 147;
  static const int MFError = 999;
}
