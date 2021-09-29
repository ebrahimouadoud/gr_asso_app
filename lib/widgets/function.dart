import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

showDialogSweet({
  required BuildContext context,
  required DialogType dialogType,
  required String title,
  required String desc,
  Function()? onCancel,
  Function()? onPresse,
}) {
  AwesomeDialog(
    context: context,
    dialogType: dialogType,
    borderSide: BorderSide(color: Colors.green, width: 2),
    // width: MediaQuery.of(context).size.width * .9,
    buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.SCALE,
    title: title,
    desc: desc,
    btnCancelText: "Annuler",
    btnOkText: "Confirme",
    showCloseIcon: true,
    btnCancelOnPress: onCancel,
    btnOkOnPress: onPresse,
  )..show();
}
