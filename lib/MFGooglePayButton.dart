// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:myfatoorah_flutter/MFConstants.dart';
import 'dart:async';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

interface class IGooglePayButtonProps {}

abstract class IMFGooglePayButton {
  Future<MFGetPaymentStatusResponse> setupGooglePayHelper(
      String sessionId,
      MFGooglePayRequest googlePayRequest,
      Function(String invoiceId) onInvoiceCreated);
}

// ignore: must_be_immutable
class MFGooglePayButton extends StatefulWidget
    implements IGooglePayButtonProps, IMFGooglePayButton {
  const MFGooglePayButton({super.key});

  @override
  State<MFGooglePayButton> createState() => _MFGooglePayButton();

  @override
  Future<MFGetPaymentStatusResponse> setupGooglePayHelper(
      String sessionId,
      MFGooglePayRequest googlePayRequest,
      Function(String invoiceId) onInvoiceCreated) async {
    return await MFSDK.setupGooglePayHelper(
        sessionId, googlePayRequest, onInvoiceCreated);
  }
}

class _MFGooglePayButton extends State<MFGooglePayButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = MFConstants.MFGooglePayButtonModuleNAME;
    // Pass parameters to the platform side.
    Map<String, dynamic> creationParams = <String, dynamic>{};

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return PlatformViewLink(
          viewType: viewType,
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<
                  OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }
}