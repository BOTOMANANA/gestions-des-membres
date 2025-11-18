import 'package:association_appli/presentation/widgets/button_widgets/custom_button_cancel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowQrCodeDialog {
  static Future<bool?> showDialog({
    required BuildContext context,
    required String data,
  }) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: _createBodyOfDialog(context: context, data: data),
          ),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  static Widget _createBodyOfDialog({
    required BuildContext context,
    required String data,
  }) {
    return Container(
      height: 360.0,
      width: 320.0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: customButtonCancel(context: context),
          ),
          _buildQrCodeImage(data: data),
        ],
      ),
    );
  }

  static Widget _buildQrCodeImage({required String data}) {
    return Positioned(
      top: 30,
      right: 0,
      left: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: QrImageView(data: data, version: QrVersions.auto, size: 140.0),
      ),
    );
  }
}
