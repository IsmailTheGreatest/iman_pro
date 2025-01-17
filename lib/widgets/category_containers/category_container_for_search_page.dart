import 'package:flutter/material.dart';
class CategoryContainer extends StatelessWidget {
  final String urlStringImage;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryContainer(
      {super.key,
        required this.urlStringImage,
        required this.title,
        required this.isSelected,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xffF4F4F5),
                borderRadius: BorderRadius.circular(18),
                border: isSelected
                    ? Border.all(color: const Color(0xff4059E6), width: 1)
                    : Border.all(color:  Colors.transparent, width: 1),
              ),
              child: Image.asset(
                urlStringImage,
                height: 50,
                width: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: SizedBox(
                  width: 80,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isSelected? const Color(0xff4059E6):const Color(0xff040415)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}