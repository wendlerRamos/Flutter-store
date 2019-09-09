import 'package:flutter/material.dart';
import 'package:loja_app/tabs/home_tab.dart';
import 'package:loja_app/tabs/orders_tab.dart';
import 'package:loja_app/tabs/places_tab.dart';
import 'package:loja_app/tabs/products_tab.dart';
import 'package:loja_app/widgets/cart_button.dart';
import 'package:loja_app/widgets/custom_dwawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
            drawer: CustomDrawer(_pageController),
            floatingActionButton: CartButton(),
            body: HomeTab(

          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,

          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(

          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
