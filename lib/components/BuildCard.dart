import 'dart:ui';

import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String categoryName;

  CategoryCard({required this.imagePath, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildCategoryCard(),
          SizedBox(height: 10.0),
          Text(
            categoryName,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Kanit',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard() {
    Color backgroundColor = Color(0xFFC3ACD0);

    return Container(
      width: 100.0, // Adjust the width to make the card square
      height: 100.0, // Maintain a square shape
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: backgroundColor.withOpacity(0.8),
            ),
            child: Center(
              child: Image.network(
                imagePath,
                height: 60.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// To use the component:

Widget _buildAllCardDetail(String imagePath, String nameCat) {
  return CategoryCard(imagePath: imagePath, categoryName: nameCat);
}
