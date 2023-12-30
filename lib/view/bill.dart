import 'package:billing_app/controller/bill_controller.dart';
import 'package:billing_app/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrintSlipScreen extends StatelessWidget {
  final List<String> items;
  final String totalAmount;

  const PrintSlipScreen({
    required this.items,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    BillController billController = Get.find<BillController>();
    // Assuming 'items' is a List<Map<String, dynamic>> where each map represents an item
    List<DataRow> itemRows = billController.cart.values.map((cartItem) {
      return DataRow(cells: [
        DataCell(
            Text(cartItem.product.name, style: const TextStyle(fontSize: 14))),
        DataCell(Text(cartItem.quantity.toString(),
            style: const TextStyle(fontSize: 14))),
        DataCell(Text('${cartItem.product.price}',
            style: const TextStyle(fontSize: 14))),
        DataCell(Text('${cartItem.product.price * cartItem.quantity}',
            style: const TextStyle(fontSize: 14))),
      ]);
    }).toList();

// Create the DataTable
    DataTable dataTable = DataTable(
      columns: const [
        DataColumn(
            label: Text('Item',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('Qty',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('Price',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('Total',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      ],
      rows: itemRows,
    );

    var date = DateTime.now();
    var formatedate = date.toLocal().toIso8601String().split('T')[0];
    var formateTime =
        '${date.toLocal().hour}:${date.toLocal().minute}:${date.toLocal().second}';
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                billController.clear();
                Get.to(const Home());
              },
              icon: const Icon(CupertinoIcons.printer))
        ],
        centerTitle: true,
        title: const Text('Billing Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // resturent name
            const Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                'Dua Fast Food & BBQ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: h * 0.01),
            // date and time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Date: ${formatedate}',
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  'Time: ${formateTime}',
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: h * 0.01),
            // number of item and total amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'No of Item : ${billController.cart.length}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Total Bill: ${totalAmount.split('.')[0]}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: h * 0.01),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    dataTable,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: h * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone),
                  SizedBox(
                    width: w * 0.01,
                  ),
                  const Text(" 0333 02 04 111"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> printDoc() async {
  //   BillController billController = Get.find<BillController>();
  //   List<DataRow> itemRows = billController.cart.values.map((cartItem) {
  //     return DataRow(cells: [
  //       DataCell(
  //         Text(cartItem.product.name, style: const TextStyle(fontSize: 14)),
  //       ),
  //       DataCell(
  //         Text(cartItem.quantity.toString(),
  //             style: const TextStyle(fontSize: 14)),
  //       ),
  //       DataCell(
  //         Text('${cartItem.product.price}',
  //             style: const TextStyle(fontSize: 14)),
  //       ),
  //       DataCell(
  //         Text('${cartItem.product.price * cartItem.quantity}',
  //             style: const TextStyle(fontSize: 14)),
  //       ),
  //     ]);
  //   }).toList();

  //   // Create the DataTable
  //   DataTable dataTable = DataTable(
  //     columns: const [
  //       DataColumn(
  //         label: Text('Item',
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //       ),
  //       DataColumn(
  //         label: Text('Qty',
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //       ),
  //       DataColumn(
  //         label: Text('Price',
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //       ),
  //       DataColumn(
  //         label: Text('Total',
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //       ),
  //     ],
  //     rows: itemRows,
  //   );

  //   var date = DateTime.now();
  //   var formatedate = date.toLocal().toIso8601String().split('T')[0];
  //   var formateTime =
  //       '${date.toLocal().hour}:${date.toLocal().minute}:${date.toLocal().second}';
  //   final image = await imageFromAssetBundle("assets/Image/image.png");
  //   final doc = pw.Document();
  //   doc.addPage(
  //     pw.Page(
  //       pageFormat: PdfPageFormat.a6,
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Column(
  //             mainAxisAlignment: pw.MainAxisAlignment.center,
  //             children: [
  //               // resturent name
  //               pw.Padding(
  //                 padding: const pw.EdgeInsets.all(8.0),
  //                 child: pw.Text(
  //                   'Dua Fast Food & BBQ',
  //                   style: pw.TextStyle(
  //                       fontSize: 18, fontWeight: pw.FontWeight.bold),
  //                 ),
  //               ),
  //               pw.SizedBox(height: 10),
  //               // date and time
  //               pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
  //                 children: [
  //                   pw.Text(
  //                     'Date: $formatedate',
  //                     style: const pw.TextStyle(fontSize: 15),
  //                   ),
  //                   pw.Text(
  //                     'Time: $formateTime',
  //                     style: const pw.TextStyle(fontSize: 15),
  //                   ),
  //                 ],
  //               ),
  //               pw.SizedBox(height: 10),
  //               // number of item and total amount
  //               pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
  //                 children: [
  //                   pw.Text(
  //                     'No of Item : ${billController.cart.length}',
  //                     style: pw.TextStyle(
  //                         fontSize: 16, fontWeight: pw.FontWeight.bold),
  //                   ),
  //                   pw.Text(
  //                     'Total Bill: ${totalAmount.split('.')[0]}',
  //                     style: pw.TextStyle(
  //                         fontSize: 16, fontWeight: pw.FontWeight.bold),
  //                   ),
  //                 ],
  //               ),
  //               pw.SizedBox(height: 10),
  //               pw.Expanded(
  //               child: pw.Container(
  //                 child: dataTable,
  //               ),
  //             ),
  //               pw.Padding(
  //                 padding: pw.EdgeInsets.symmetric(vertical: 10),
  //                 child: pw.Row(
  //                   mainAxisAlignment: pw.MainAxisAlignment.center,
  //                   children: [
  //                     //pw.Icon(pw.Icons.phone),
  //                     pw.SizedBox(
  //                       width: 10,
  //                     ),
  //                     pw.Text(" 0333 02 04 111"),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //   await Printing.layoutPdf(onLayout: (PdfPageFormat format) => doc.save());
  // }
}

// List of IT
            // Flexible(
            //   child: ListView(
            //     children: items
            //         .map((item) => Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Text(item, style: TextStyle(fontSize: 16)),
            //             ))
            //         .toList(),
            //   ),
            // ),
