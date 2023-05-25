import 'package:get/get.dart';
import '../class/produk.dart';

class CartController extends GetxController {
  var test = 0.obs;

  var _product = {}.obs;
  var _products2 = <Produk>[].obs;
  void increment(Produk product) {
    product.quantity = 1;
    try {
      if (_product.containsKey(product)) {
        _product[product] += 1;
        _products2.add(product);
      } else {
        print(product.deskripsi);
        _product[product] = 1;
        _products2.add(product);
      }
      Get.snackbar("Product Added", "yey berhasil nambah item",
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
    } catch (e) {
      Get.snackbar("Product Added", "yey berhasil nambah item",
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
    }
  }

  get products2 => _products2;
  get products => _product;
  get productCheck => _products2.where((element) => element.check).toList();
  get total => productCheck
      .map((e) => e.harga * e.quantity)
      .toList()
      .reduce((value, element) => value + element)
      .toString();
}
