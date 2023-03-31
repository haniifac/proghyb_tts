import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uts_shoping/helper.dart';
import 'package:uts_shoping/numeric_step_button.dart';
import 'package:uts_shoping/product.dart';

class CartArguments{
  final List<Product> cart;
  CartArguments(this.cart);
}

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("JNE"),value: "JNE"),
    DropdownMenuItem(child: Text("TIKI"),value: "TIKI"),
    DropdownMenuItem(child: Text("SiCepat"),value: "SiCepat"),
    DropdownMenuItem(child: Text("JNT"),value: "JNT"),
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

  String selectedKurir = "JNE";

  HashMap subPrices = HashMap<String, double>();
  String subTotalString = "Rp0";

  updateText(String name, double newPrice) {
    setState(() {
      subPrices.update(name, (value) => newPrice);
    });
  }

  updateSubtotalString(double newPrice) {
    setState(() {
      subTotalString = "Rp${newPrice}";
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
          crossAxisAlignment: CrossAxisAlignment.start,
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

                                    double subTotal = args.cart[index].qty * args.cart[index].price;
                                    subPrices.update(args.cart[index].name, (value) => subTotal, ifAbsent: () => subTotal);
                                    updateText(args.cart[index].name, subTotal);

                                    // double countSubTotal = 0;
                                    // for(var price in subPrices.values){
                                    //   countSubTotal += price;
                                    // }

                                    subTotal = countSubTotal(subPrices.values.toList());
                                    updateSubtotalString(subTotal);

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
            Text("Shipping"),
            DropdownButton(
              value: selectedKurir,
              onChanged: (String? newValue){
                setState(() {
                  selectedKurir = newValue!;
                });
              },
              items: dropdownItems,
            ),
            Text("Sub Total"),
            Text("Rp${subTotalString}")
          ],
        ),
      ),
    );
  }
}
