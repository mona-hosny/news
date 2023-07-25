

import 'package:flutter/material.dart';

import 'package:news/home/home.dart';


import 'home/tabs/news_tabs/news_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,routes: {
      Home.routeName:(_)=>Home(),
    NewsDtailsScreen.routeName:(_)=>NewsDtailsScreen()

    },initialRoute: Home.routeName,);
  }}