import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.name,
    required this.weight,
  }) : super(key: key);

  final String name;
  final double weight;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  void showMessage(){
    final snackbar = SnackBar(content: Text("Button Pressed"));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          const Flexible(
              child: Image(image: AssetImage('images/rubber-duck.jpg'))
          ),
          Text(
            widget.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            '${widget.weight} KG'
          ),
          OutlinedButton(
              onPressed: (){
                showMessage();
              },
              child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

