import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:update_app/model/cardItem.dart';
import 'package:update_app/model/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DragTargetWidget1 extends StatefulWidget {
  final CardItem cardItem;
  DragTargetWidget1({required this.cardItem});

  @override
  _DragTargetWidgetState1 createState() =>
      _DragTargetWidgetState1(cardItem: this.cardItem);
}

class _DragTargetWidgetState1 extends State<DragTargetWidget1> {
  CardItem cardItem;
  _DragTargetWidgetState1({required this.cardItem});

  get key => null;
  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onWillAccept: (data) {
        return true;
      },
      onAccept: (CardItem data) {
        if (data.imageUrl == cardItem.imageUrl) {
          // ScaffoldMessenger.of(context)
          //   .showSnackBar(SnackBar(content: const Text('well done')));
          //Provider.of<Data>(context, listen: false).removeLastItem();
          Provider.of<Data>(context, listen: false)
              .changeSuccessDropByIndex(true, 1);
          Provider.of<Data>(context, listen: false)
              .changeSuccessDropByIndex(false, 0);
          Provider.of<Data>(context, listen: false)
              .changeSuccessDropByIndex(false, 2);
          Provider.of<Data>(context, listen: false)
              .changeSuccessDropByIndex(false, 3);
          Provider.of<Data>(context, listen: false).changeAcceptedData(data);
          //  Provider.of<Data>(context, listen: false).removeLastCenterItem();
        }
      },
      builder: (context, candidateData, rejectedData) {
        if (Provider.of<Data>(context, listen: false).isSuccessDropList(1)) {
          return buildTarget(
              Provider.of<Data>(context, listen: false).getAcceptedData);
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              child: Container(
                height: 150,
                width: 150,
                color: Colors.white,
                child: Center(child: Image.asset(cardItem.imageUrl)),
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildTarget(CardItem? item) {
    if (item != null) {
        return Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(pi*0.3),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              child: Container(
                height: 150,
                width: 150,
                color: Colors.white,
                child: Center(child: Image.asset(item.imageUrl)),
              ),
            ),
          ));
    } else {
      return Text('Errors');
    }
  }
}