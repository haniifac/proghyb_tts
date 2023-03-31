import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uts_shoping/helper.dart';
import 'package:uts_shoping/numeric_step_button.dart';
import 'package:uts_shoping/product.dart';

class CartArguments{
  final List<Product> cart;
  CartArguments(this.cart);
}

List<DropdownMenuItem<int>> get dropdownItems{
  List<DropdownMenuItem<int>> menuItems = [
    DropdownMenuItem(child: Text("JNE Rp1000"),value: 1000),
    DropdownMenuItem(child: Text("TIKI Rp2000"),value: 2000),
    DropdownMenuItem(child: Text("SiCepat Rp3000"),value: 3000),
    DropdownMenuItem(child: Text("JNT Rp4000"),value: 4000),
  ];
  return menuItems;
}


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}



class _CartPageState extends State<CartPage> {
  void showMessage(String message){
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  int selectedKurir = 1000;

  HashMap subPrices = HashMap<String, double>();
  HashMap subBobot = HashMap<String, double>();
  String subTotalString = "Rp0";
  String grandTotalString = "Rp1000";
  String totalBobotString = "0 KG";
  String hargaTotalBobotString = "Rp0";

  updateSubProductString(String name, double newPrice) {
    setState(() {
      subPrices.update(name, (value) => newPrice);
    });
  }

  updateSubtotalString(double newPrice) {
    setState(() {
      subTotalString = "Rp${newPrice}";
    });
  }

  updateGrandtotalString(double newPrice) {
    setState(() {
      grandTotalString = "Rp${newPrice}";
    });
  }

  updateTotalBobotString(double newBobot) {
    setState(() {
      totalBobotString = "${newBobot} KG";
    });
  }

  updateHargaPengirimanString(double newBobot) {
    setState(() {
      hargaTotalBobotString = "Rp${newBobot}";
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as CartArguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: ListView.builder(
                  itemCount: args.cart.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
                      color: Colors.red,
                      child: Row(
                        children: [
                          Flexible(
                              child: Image(
                                  image: AssetImage(args.cart[index].img),
                                width: 90,
                                height: 90,
                              )
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(args.cart[index].name),
                              Text('Rp${args.cart[index].price}'),
                              Container(
                                child: NumericStepButton(
                                  maxValue: 100,
                                  onChanged: (int value) {
                                    args.cart[index].qty = value;

                                    double subTotalProduct = args.cart[index].qty * args.cart[index].price;
                                    subPrices.update(args.cart[index].name, (value) => subTotalProduct, ifAbsent: () => subTotalProduct);


                                    double productSubBobot = args.cart[index].qty.toDouble() * args.cart[index].weight;
                                    subBobot.update(args.cart[index].name, (value) => productSubBobot, ifAbsent: () => productSubBobot);


                                    var totalBobot = countSubBobotTotal(subBobot.values.toList());
                                    var subTotal = countSubTotal(subPrices.values.toList());

                                    updateSubProductString(args.cart[index].name, subTotalProduct);
                                    updateTotalBobotString(countSubBobotTotal(subBobot.values.toList()));
                                    updateSubtotalString(subTotal);
                                    updateHargaPengirimanString(totalBobot * selectedKurir);
                                    updateGrandtotalString(subTotal + totalBobot * selectedKurir);

                                    print(subPrices[args.cart[index].name].toString());
                                  },
                                ),
                              )
                              //
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(
                                "Rp${subPrices[args.cart[index].name] ?? 0}",
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Shipping"),
                        DropdownButton(
                          value: selectedKurir,
                          onChanged: (int? newValue){
                            setState(() {
                              selectedKurir = newValue!;
                              var subTotal = countSubTotal(subPrices.values.toList());
                              var totalBobot = countSubBobotTotal(subBobot.values.toList());
                              updateGrandtotalString(subTotal + selectedKurir.toDouble());
                              updateHargaPengirimanString(totalBobot * selectedKurir);
                              updateGrandtotalString(subTotal + totalBobot * selectedKurir);
                            });
                          },
                          items: dropdownItems,
                        ),
                        Text("Total Bobot : $totalBobotString"),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Sub Total"),
                      Text("${subTotalString}"),
                      Text("Harga Pengiriman"),
                      Text("${hargaTotalBobotString}"),
                      Text("Grand Total"),
                      Text("${grandTotalString}")
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
