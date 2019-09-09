import 'package:flutter/material.dart';

class ShipCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Calculadora de Frete",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.green[800],

          ),
        ),
        leading: Icon(Icons.location_on),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite o seu CEP",

              ),
              initialValue: "",
              onFieldSubmitted: (text){

              },
            ),
          )
        ],
      ),
    );
  }
}
