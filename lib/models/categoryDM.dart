import 'package:flutter/material.dart';

class CategoryDM {
  String id;
  String title;
  String imagePath;
  bool isLeftedSide;
  Color backgroundCoulor;

  CategoryDM(
      {required this.id,
      required this.title,
      required this.imagePath,
      required this.isLeftedSide,
      required this.backgroundCoulor});

  static List<CategoryDM> categories = [
    CategoryDM(
        id: "sports",
        title: "sports",
        imagePath: "assets/sports.png",
        isLeftedSide: true,
        backgroundCoulor: Colors.red),
    CategoryDM(
        id: "technology",
        title: "Technology",
        imagePath: "assets/Politics.png",
        isLeftedSide: false,
        backgroundCoulor: Colors.blue),
    CategoryDM(
        id: "health",
        title: "health",
        imagePath: "assets/health.png",
        isLeftedSide: true,
        backgroundCoulor: Colors.purpleAccent),
    CategoryDM(
        id: "bussines",
        title: "buissines",
        imagePath: "assets/bussines.png",
        isLeftedSide: false,
        backgroundCoulor: Colors.brown),
    CategoryDM(id: "entertainment", title: "environment", imagePath: "assets/environment.png", isLeftedSide: true, backgroundCoulor: Colors.blueAccent),
    CategoryDM(id: "science", title: "science", imagePath: "assets/science.png", isLeftedSide: false, backgroundCoulor: Colors.yellow)
  ];
}
