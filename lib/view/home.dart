import 'package:badges/badges.dart' as bages;
import 'package:badges/badges.dart';
import 'package:billing_app/controller/bill_controller.dart';
import 'package:billing_app/view/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BillController billController = Get.put(BillController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Billing App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              //itemCount: billController.items.length,
              itemCount: billController.items.length,
              itemBuilder: (context, index) {
                final product = billController.items[index];
                final productName = product.name;
                // to change icon
                bool isInCart = billController.isProductInCart(product.name);

                return ListTile(
                  leading: IconButton(
                    onPressed: () {
                      if (isInCart) {
                        // Show some feedback or navigate to the cart
                        Get.to(const CartScreen());
                      } else {
                        billController.addToCart(index);
                      }
                    },
                    icon: Icon(
                      isInCart ? Icons.done : Icons.add,
                      color: Colors.green,
                    ),
                  ),
                  title: Text(product.name.toString()),
                  trailing: Text(
                    product.price.toString().split('.')[0],
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w300),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: bages.Badge(
        position: BadgePosition.topEnd(top: -6, end: -2),
        badgeContent: Obx(
          () => Text(
            billController.cart.length.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            billController.cal();
            if (billController.cart.isNotEmpty) {
              Get.to(const CartScreen());
            } else {
              Get.snackbar("Alert", "Kinldy add product");
            }
          },
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
