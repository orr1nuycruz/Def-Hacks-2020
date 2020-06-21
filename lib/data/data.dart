import 'package:flutter/material.dart';

class Data {
  static List<DropdownMenuItem> jobPos() {
    String _pos1 = "Medical Assistant";
    String _pos2 = "Physician";
    String _pos3 = "Licensed Practical Nurse";
    String _pos4 = "Registered Nurse";
    String _pos5 = "Doctor";

    List<DropdownMenuItem> results = [
      DropdownMenuItem(
        value: _pos1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(_pos1),
          ],
        ),
      ),
      DropdownMenuItem(
        value: _pos2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(_pos2),
          ],
        ),
      ),
      DropdownMenuItem(
        value: _pos3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(_pos3),
          ],
        ),
      ),
      DropdownMenuItem(
        value: _pos4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(_pos4),
          ],
        ),
      ),
      DropdownMenuItem(
        value: _pos5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(_pos5),
          ],
        ),
      ),
    ];
    return results;
  }
}
