import 'package:digitalbillbook/customwidgets/CustomInputDecorationWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Eachrow extends StatelessWidget {
  final TextEditingController controller1, controller2;
  final String s1, s2;
  Function validation1, validation2;
  int inputformates;
  TextInputType keyboardTypeC1, keyboardTypeC2;
 
  Eachrow(this.controller1, this.s1, this.keyboardTypeC1, this.validation1,
      this.controller2, this.s2, this.keyboardTypeC2, this.validation2,this.inputformates);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Card(
            elevation: 4,
            child: Container(
              //height: 50,
              width: MediaQuery.of(context).size.width * 0.45,
              child: TextFormField(
                
                keyboardType: keyboardTypeC1,
                controller: controller1,
                decoration: CoustumInputDecorationWidget(s1).decoration(),
                // The validator receives the text that the user has entered.
                validator: validation1 == null?                    
                    (value) {
                        if (value.isEmpty) {
                          return null;
                        }
                        return null;
                      }
                    : validation1,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0), 
          child: Card(
            elevation: 4,
            child: Container(
               //height: 50,
              width: MediaQuery.of(context).size.width * 0.45,
              child: TextFormField(
               inputFormatters: [new LengthLimitingTextInputFormatter(inputformates)],
                  keyboardType: keyboardTypeC2,
                  controller: controller2,
                  decoration: CoustumInputDecorationWidget(s2).decoration(),
                  // The validator receives the text that the user has entered.
                  validator: validation2 == null
                      ?                      
                      (value) {
                          if (value.isEmpty) {
                            return null;
                          }
                          return null;
                        }
                      : 
                      validation2
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
