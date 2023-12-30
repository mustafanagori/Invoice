import 'package:billing_app/controller/bill_controller.dart';
import 'package:billing_app/view/bill.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BillController billController = Get.find<BillController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Shopping Cart"),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 9,
              child: GetBuilder<BillController>(builder: (controlller) {
                return ListView.builder(
                  itemCount: billController.cart.length,
                  itemBuilder: (context, index) {
                    final cartItem =
                        billController.cart.values.elementAt(index);
                    return ListTile(
                      leading: Text("${index + 1} )"),
                      title: Text(cartItem.product.name),
                      subtitle: Text("Price: ${cartItem.product.price}"),
                      trailing: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.29,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                billController.cal();
                                billController.dec(cartItem.product.name);
                                if (billController.cart.isEmpty) {
                                  Get.back(); // Navigate back when the cart is empty
                                }
                              },
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              "${cartItem.quantity}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            IconButton(
                              onPressed: () {
                                billController.cal();
                                billController.inc(cartItem.product.name);
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              })),
          Expanded(
            child: Container(
              color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => Text(
                      "Total Amount : ${billController.total.toString()}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Get.to(PrintSlipScreen(
                          items: billController.cart.values
                              .map((cartItem) =>
                                  '${cartItem.product.name}    Qty: ${cartItem.quantity}   Price: ${cartItem.product.price}')
                              .toList(),
                          totalAmount: billController.total.toString(),
                        ));
                      },
                      icon: const Icon(Icons.catching_pokemon_outlined),
                      label: const Text(
                        "Confirm",
                        style: TextStyle(fontSize: 17),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // }
}
