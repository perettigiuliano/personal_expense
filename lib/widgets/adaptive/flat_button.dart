import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String _caption;
  final Function _whatToDo;

  AdaptiveFlatButton(this._caption, this._whatToDo);

  @override
  Widget build(BuildContext context) {
    final caption = Text(this._caption);
    return Platform.isAndroid
        ? FlatButton(
            // color: Colors.white,
            // textColor: Colors.red,
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              _whatToDo();
            },
            child: caption,
          )
        : CupertinoButton(
            child: caption,
            onPressed: () {
              _whatToDo();
            },
          );
  }
}
