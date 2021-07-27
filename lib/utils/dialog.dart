import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image? img;

  const CustomDialogBox({
    Key? key, 
    required this.title, 
    required this.descriptions, 
    required this.text, 
    this.img}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(kDefaultPadding),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(kDefaultPadding),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.5),offset: Offset(0,10),
              blurRadius: 10
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(fontSize: 16),textAlign: TextAlign.right,),
              SizedBox(height: 22,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pop(context,'accept');
                      },
                      child: Text(widget.text,style: TextStyle(fontSize: 16))
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pop(context,'close');
                      },
                      child: Text("اغلاق",style: TextStyle(fontSize: 16))
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}