import 'package:flutter/material.dart';
import 'package:news/home/tabs/categories/each_category.dart';
import 'package:news/models/categoryDM.dart';

class CategoriesTap extends StatelessWidget {

  Function (CategoryDM) OnCategoryClick;

  CategoriesTap(this.OnCategoryClick);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [const SizedBox(height: 5,),
        const Text(
          "pick your categories you interest",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,crossAxisSpacing: 3,mainAxisSpacing: 3),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {OnCategoryClick(CategoryDM.categories[index]);},child: EachCategory(CategoryDM.categories[index]),
              );
            },
            itemCount: 6,
          ),
        )
      ],
    );
  }
}
