import 'package:flutter/material.dart';
import 'package:flutter_app/provider/cart.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/pages/cart_page/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List cartList = Provider.of<CartProvider>(context).cartList;
            return ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  return CartItem(cartList[index]);
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provider.of<CartProvider>(context).getCartInfo();
    return 'end';
  }
}
