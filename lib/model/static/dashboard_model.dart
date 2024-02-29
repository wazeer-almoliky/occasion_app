import 'package:flutter/material.dart';

class DashBoardModel {
  final String? label;
  final IconData? icon;
  const DashBoardModel({this.label, this.icon});
}

class DashBoardData {
  static const user = [
    DashBoardModel(label: "بيانات المؤسسة"),
    DashBoardModel(label: "الخدمــات"),
    DashBoardModel(label: "إضـافة خدمـات"),
    DashBoardModel(label: " أسعار الخدمــات"),
    DashBoardModel(label: "الطلبات النشطـة"),
    DashBoardModel(label: "الطلبــات المنفذة"),
  ];
  static const admin = [
    DashBoardModel(label: "الأدمــن"),
    DashBoardModel(label: "الخدمــات"),
    DashBoardModel(label: "إضـافة خدمـات"),
    DashBoardModel(label: "الفتــرات"),
    DashBoardModel(label: "الطلبات النشطـة"),
    DashBoardModel(label: "الطلبــات المنفذة"),
  ];
}
