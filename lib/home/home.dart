import 'package:flutter/material.dart';
import 'package:news/home/tabs/categories/catogory_tap.dart';
import 'package:news/home/tabs/news_tabs/news_search.dart';
import 'package:news/home/tabs/news_tabs/news_tab.dart';
import 'package:news/home/tabs/setting/setting_tap.dart';
import 'package:news/models/categoryDM.dart';

class Home extends StatefulWidget {
  static String routeName = "home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoryDM? selectedCategory = null;
  late Widget selectedTap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedTap = CategoriesTap(SetSelectedCategory);
  }

  void SetSelectedCategory(CategoryDM category) {
    selectedCategory = category;
    selectedTap = NewsTap(selectedCategory!);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (selectedTap is CategoriesTap) {
          return Future.value(true);
        } else {
          selectedTap = CategoriesTap(SetSelectedCategory);
          setState(() {});
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: const Text("News Apps"),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(22),
                  bottomLeft: Radius.circular(22))),
          actions: [IconButton(onPressed: () {showSearch(context: context, delegate: NewsSearch());}, icon: Icon(Icons.search))],
        ),
        body: selectedTap,
        drawer: buildDrawerWidget(context),
      ),
    );
  }

  Widget buildDrawerWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(children: [
        Container(
          color: Colors.green,
          height: MediaQuery.of(context).size.height * 0.15,
          child: const Center(
              child: Text("News Apps",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
        ),
        const SizedBox(height: 10),
        InkWell(
            onTap: () {
              selectedCategory = null;
              selectedTap = CategoriesTap(SetSelectedCategory);
              Navigator.pop(context);
              setState(() {});
            },
            child: buildRowDrawer(
              Icons.menu,
              "categories",
            )),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              selectedTap = SettingTap();
              setState(() {});
              Navigator.pop(context);
            },
            child: buildRowDrawer(Icons.settings, "setting"))
      ]),
    );
  }

  Widget buildRowDrawer(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 28,
          color: Colors.black,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 24),
        )
      ],
    );
  }
}
