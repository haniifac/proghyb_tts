import 'package:flutter/material.dart';
import 'package:uts_shoping/cart_page.dart';
import 'package:uts_shoping/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => MainPage(),
        '/cart' : (context) => CartPage(),
      },
      // home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void showMessage(String name){
    final snackbar = SnackBar(content: Text("$name added to cart."));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  List<Product> products = [
    Product("Handuk", 'images/handuk.jpg', 1, 15000),
    Product("Piring", 'images/piring.jpg', 5, 30000),
    Product("Bebek", 'images/rubber-duck.jpg', 1, 5000),
    Product("sajadah", 'images/sajadah.jpg', 1, 8000),
    Product("Sendok", 'images/sendok.jpg', 3, 24000)
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 80) / 2;
    final double itemWidth = size.width / 2;

    List<Product> cart = [];

    List<Widget> catalouge = List.generate(5, (index) {
      return Container(
        color: Colors.red,
        child: Column(
          children: [
            Flexible(
                child: Image(image: AssetImage(products[index].img))
            ),
            Text(
              products[index].name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text('${products[index].weight}'),
            OutlinedButton(
              onPressed: (){
                cart.add(products[index]);
                showMessage(products[index].name);
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Toko nya Dia"),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: (itemWidth / itemHeight),
          children: catalouge
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart', arguments: CartArguments(cart));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}



