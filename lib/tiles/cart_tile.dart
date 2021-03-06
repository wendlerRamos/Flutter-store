import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_app/datas/cart_product.dart';
import 'package:loja_app/datas/product_data.dart';
import 'package:loja_app/models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  CartTile(this.cartProduct);



  @override
  Widget build(BuildContext context) {

    Widget _buiderContent(){
      CartModel.of(context).updatePrices();
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            width: 120.0,
            child: Image.network(cartProduct.productData.images[0], fit: BoxFit.cover,),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cartProduct.productData.title,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Tamanho ${cartProduct.size}",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$ ${cartProduct.productData.price.toStringAsFixed(2)}",
                    style: TextStyle(fontSize : 16.0,  fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: cartProduct.quantity > 1  ? (){
                          CartModel.of(context).decProduct(cartProduct);
                        } : null,
                        color: Theme.of(context).primaryColor,

                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: (){
                          CartModel.of(context).incProduct(cartProduct);
                        },
                        color: Theme.of(context).primaryColor,
                      ),
                      FlatButton(
                        child: Icon(Icons.delete, size: 25.0,),
                        textColor: Colors.red[600],
                        onPressed: (){
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      child: cartProduct.productData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance.collection("products").document(cartProduct.category)
              .collection("items").document(cartProduct.pid).get(),
          builder: (context, snapshot) {
              if(snapshot.hasData){
                cartProduct.productData = ProductData.fromDocument(snapshot.data);
                return _buiderContent();
              }else{
                return Container(
                  height: 70.0,
                  child: CircularProgressIndicator(),
                  alignment: Alignment.center,
                );
              }
          },
        ) : _buiderContent()
    );
  }
}
