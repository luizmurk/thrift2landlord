part of '../index.dart';

class CustomSnackbar {
  static void show(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? "Error" : "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
    );
  }
}
