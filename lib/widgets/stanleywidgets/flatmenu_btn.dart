import 'package:flutter/material.dart';
import 'package:shopisoko/app_utils/app_utils.dart';
import 'package:provider/provider.dart';

class FlatMenuBtn extends StatefulWidget {
  FlatMenuBtn(this.btnName, this.func);
  final String btnName;
  final Function func;

  @override
  _FlatMenuBtnState createState() => _FlatMenuBtnState();
}

class _FlatMenuBtnState extends State<FlatMenuBtn> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final _sizedWidth = SizedBox(
      width: 10,
    );
    TextStyle style = TextStyle(
        color: appState.dark ? Colors.white : Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold);
    return FlatButton(
        onPressed: widget.func,
        child: Container(
            child: Row(
          children: [_sizedWidth, Text(widget.btnName, style: style)],
        )));
  }
}
