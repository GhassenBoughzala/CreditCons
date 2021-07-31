import 'package:flutter/material.dart';

class CardModel {
  String name;
  String type;
  String balance;
  String valid;
  String moreIcon;
  String cardBackground;
  Color bgColor;
  Color firstColor;
  Color secondColor;

  CardModel(this.name, this.type, this.balance, this.valid, this.moreIcon,
      this.cardBackground, this.bgColor, this.firstColor, this.secondColor);
}

List<CardModel> cards = cardData
    .map((item) => CardModel(
        item['name'],
        item['type'],
        item['balance'],
        item['valid'],
        item['moreIcon'],
        item['cardBackground'],
        item['bgColor'],
        item['firstColor'],
        item['secondColor']))
    .toList();

var cardData = [];