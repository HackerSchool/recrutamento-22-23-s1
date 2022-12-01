import 'package:flutter/material.dart';
import 'package:app/menu_item.dart';

class MenuItems {
  static const List<MenuItem2> itemsFirst = [
    itemSave,
    itemDelete,
    itemMail,
  ];

  static const List<MenuItem2> itemsSecond = [
    itemMail
  ];


  static const itemSave = MenuItem2(
    text: 'Save list',
    icon: Icons.favorite,
  );

  static const itemMail = MenuItem2(
    text: 'Send mail',
    icon: Icons.mail_rounded,
  );

  static const itemDelete = MenuItem2(
    text: 'Clear list',
    icon: Icons.delete,
  );
}