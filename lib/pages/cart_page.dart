import 'package:flutter/material.dart';
import 'package:flutter_app/pages/cart_page/cart_bottom.dart';
import 'package:flutter_app/pages/cart_page/cart_item.dart';
import 'package:flutter_app/provider/cart.dart';
import 'package:provider/provider.dart';

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
            // List cartList = Provider.of<CartProvider>(context, listen: false).cartList;
            return Stack(
              children: <Widget>[
                Consumer<CartProvider>(builder: (context, t, child) {
                  List cartList = t.cartList;
                  return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return CartItem(cartList[index]);
                      });
                }),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provider.of<CartProvider>(context, listen: false).getCartInfo();
    return 'end';
  }
}
