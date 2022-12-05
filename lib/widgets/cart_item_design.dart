import 'package:flutter/material.dart';
import 'package:udemy_paid_users/Models/items.dart';

class CartItemDesign extends StatefulWidget {
  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  CartItemDesign(
      {Key? key, this.model, this.context, this.quanNumber})
      : super(key: key);

  @override
  State<CartItemDesign> createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          height: 135,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              //image
              Image.network(widget.model!.thumbnailUrl!,
                  width: 140, height: 120,fit: BoxFit.cover,),

              const SizedBox(
                width: 6,
              ),
              // title, description,prize
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.model!.title!,
                    style: const TextStyle(
                        color: Colors.black, fontSize: 16, fontFamily: "Kiwi"),
                  ),
                
                  SizedBox(
                    height: 1,
                  ),
                
                  Row(
                    children: [
                      Text(
                        "x ",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "Kiwi"),
                      ),
                      Text(
                        widget.quanNumber.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "Kiwi"),
                      ),
                    ],
                  ),
                 
                  SizedBox(
                    height: 1,
                  ),
                  
                  Row(
                    children: [
                      const Text(
                        "Price ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "Kiwi"),
                      ),
                      const Text(
                        "₹ ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "Kiwi"),
                      ),
                      Text(
                        widget.model!.price.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "Kiwi"),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
