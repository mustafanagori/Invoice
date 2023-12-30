import 'package:billing_app/model/cart_model.dart';
import 'package:billing_app/model/product_model.dart';
import 'package:get/get.dart';

class BillController extends GetxController {
  RxMap<String, CartItem> cart = RxMap<String, CartItem>();
  List<Product> items = [
    Product(name: "zinger Burger", price: 360),
    Product(name: "chicken tikkah", price: 240),
    Product(name: "chicken broast", price: 420),
    Product(name: "Club sandwich", price: 280),
    Product(name: "Chicken Roll", price: 120),
    Product(name: "Fresh Fries", price: 100),
    Product(name: "Leg Broast", price: 420),
    Product(name: "Pizza Fries", price: 560),
    Product(name: "khabab Roll", price: 90),
    Product(name: "Chicken Boti", price: 140),
    Product(name: "Mali Boti", price: 120),
    Product(name: "beef Roll", price: 560),
    Product(name: "Grill burger", price: 500),
    Product(name: "pepsi 30 ML", price: 140),
    Product(name: "masala fries", price: 160),
    Product(name: "raita", price: 30),
    Product(name: "Chicken Karai", price: 1000),
    Product(name: "chicken burger", price: 250),
    Product(name: "zinger roll", price: 360),
  ];

  RxDouble total = 0.0.obs;

  void cal() {
    total.value = 0.0; // Reset total before recalculating

    // Iterate through each item in the cart
    for (var cartItem in cart.values) {
      // Add the price of each item to the total
      total.value += cartItem.product.price * cartItem.quantity;
    }
    update();
  }

  void clear() {
    cart.clear();
    total.value = 0.0;
  }

  void addToCart(int index) {
    String productName = items[index].name;

    // Check if the item is already in the cart
    if (cart.containsKey(productName)) {
      Get.snackbar("Alert", "The product is already added");
    } else {
      // If not in the cart, add it with count 1
      cart[productName] = CartItem(product: items[index]);
      print(cart.length.toString());
      cal();
    }

    // Update the UI
    update();
  }

  void inc(String productName) {
    if (cart.containsKey(productName)) {
      cart[productName]!.quantity++;
      cal(); // Update the total amount
      update(); // Trigger a reactivity update
    }
  }

  bool isProductInCart(String productName) {
    return cart.containsKey(productName);
  }

  void dec(String productName) {
    if (cart.containsKey(productName)) {
      if (cart[productName]!.quantity > 1) {
        cart[productName]!.quantity--;
      } else {
        // If quantity is 1 or less, remove the item from the cart
        cart.remove(productName);
      }
      cal(); // Update the total amount
      update(); // Trigger a reactivity update
    }
  }
}
