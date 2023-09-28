import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:meeting_scheduler/Util/palette.dart';
import 'package:intl/intl.dart';

class CommonUi {
  static DateFormat modifiedDateFormat = DateFormat('dd-MM-yyyy hh:mm a');

  static DateFormat dateAloneFormat = DateFormat('yyyy-MM-dd');
  static DateFormat timeAloneFormat = DateFormat('HH:mm');
  showLoadingDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 40,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: whiteColor, size: 50))),
        );
      },
    );
  }
}
