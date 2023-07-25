import 'package:flutter/material.dart';
import 'package:news/models/categoryDM.dart';

class EachCategory extends StatelessWidget {
  CategoryDM categoryDM;

  EachCategory(this.categoryDM);

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(8),margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: const Radius.circular(12),
              topLeft: const Radius.circular(12),
              bottomLeft: categoryDM.isLeftedSide
                  ? Radius.zero
                  : const Radius.circular(12),
              bottomRight: categoryDM.isLeftedSide
                  ? const Radius.circular(12)
                  : Radius.zero),color: categoryDM.backgroundCoulor),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [const SizedBox(height: 3), Image.asset(categoryDM.imagePath),const SizedBox(height: 3,)
          ,Text(categoryDM.title,style: const TextStyle(color: Colors.white,fontSize: 18),)]),
    );
  }
}
