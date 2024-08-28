import 'package:flutter/material.dart';

@immutable
class AppConstants {
  const AppConstants._();
  static const sendTimeout = 60;
  static const connectTimeout = 60;
  static const receiveTimeout = 60;

  static const String font_URL = 'assets/fonts/roboto/Roboto-Regular.ttf';

  static List<String> payment_types_list = [
    "pos_bank",
    "pos_cash",
    "app_payment",
    "serve",
    "discount",
    "tick",
    "sodexo",
    "smart",
    "winwin",
    "multinet",
    "setcard",
    "metropol",
    "edended",
    "tips",
    "jetKurye",
    "not-payable",
    "migros-hemen",
    "getir-online",
    "trendyol",
    "yemek-sepeti"
  ];
}

const kZero = 0;
const kOne = 0;
