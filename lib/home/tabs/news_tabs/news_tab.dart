import 'package:flutter/material.dart';
import 'package:news/data/api_manager.dart';
import 'package:news/home/tabs/news_tabs/tab_content.dart';

import 'package:news/models/SourcesResponse.dart';
import 'package:news/models/categoryDM.dart';

class NewsTap extends StatefulWidget {
  CategoryDM selectedCategory;
  NewsTap(this.selectedCategory);

  @override
  State<NewsTap> createState() => _NewsTapState();
}

class _NewsTapState extends State<NewsTap> {



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourcesResponseDM>(
      future: ApiManager.getSources(widget.selectedCategory.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          return getScreenBody(snapshot.data!.sources!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget getScreenBody(List<SourcesDM> sources) {
    int currentTabIndex = 0;
    return DefaultTabController(
        length: sources.length,
        child: Column(
          children: [
            TabBar(
              tabs: sources.map((source) {
                return getTap(
                    source, currentTabIndex == sources.indexOf(source));
              }).toList(),
              onTap: (index) {
                currentTabIndex = index;
                setState(() {});
              },
              isScrollable: true,
              indicatorColor: Colors.transparent,
            ),
            Expanded(
              child: TabBarView(
                  children: sources.map((source) {
                return GetTapContent(source);
              }).toList()),
            )
          ],
        ));
  }

  Widget getTap(SourcesDM source, bool isSelected) {
    return Container(padding: EdgeInsets.all(6),margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8)),
      child: Text(source.name ?? "unknow",style: TextStyle(color: isSelected?Colors.white:Colors.green)),
    );
  }
}
