import 'package:flutter_easyloading/flutter_easyloading.dart';

void showLoading({String message = ''}) {
  EasyLoading.show(status: message);
}

void hideLoading() {
  EasyLoading.dismiss();
}

void showSuccess({String message = ''}) {
  EasyLoading.showSuccess(message);
}

void showError({String message = ''}) {
  EasyLoading.showError(message);
}
