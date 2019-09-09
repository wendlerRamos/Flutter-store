import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_app/models/cart_model.dart';

class DiscountCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
          title: Text(
              "Cupom de desconto",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.green[800],

            ),
          ),
        leading: Icon(Icons.card_membership),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Informe o código do cupom",

              ),
              initialValue: CartModel.of(context).cupomCode ?? "",
              onFieldSubmitted: (text){
                Firestore.instance.collection("coupons").document(text).get().then((docSnap){
                  if(docSnap.data != null){
                    CartModel.of(context).setCupom(text, docSnap.data['percentage']);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Desconto de ${docSnap.data['percentage']} aplicado"), backgroundColor: Theme.of(context).primaryColor,)
                    );
                  }else{
                    CartModel.of(context).setCupom(null, 0);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Código aplicado inválido !"), backgroundColor: Colors.red[900],)
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
