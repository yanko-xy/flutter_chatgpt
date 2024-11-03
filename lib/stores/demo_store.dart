import 'package:get/get.dart';

class DemoController extends GetxController {
  RxInt counter = 0.obs;

  void inc() {
    counter.value++;
    update();
  }

  void dec() {
    counter.value--;
    update();
  }
}
