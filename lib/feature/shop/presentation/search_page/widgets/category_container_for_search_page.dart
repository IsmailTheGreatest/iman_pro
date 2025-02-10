import 'package:flutter/material.dart';

/// CategoryContainer class
class CategoryContainer extends StatelessWidget {
  /// CategoryContainer constructor
  const CategoryContainer({
    required this.urlStringImage,
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  /// CategoryContainer constructor
  final String urlStringImage;

  /// CategoryContainer constructor
  final String title;

  /// CategoryContainer constructor
  final bool isSelected;

  /// CategoryContainer constructor
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Visibility(
              visible: urlStringImage.isEmpty,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xffF4F4F5),
                  borderRadius: BorderRadius.circular(18),
                  border: isSelected
                      ? Border.all(
                          color: const Color(0xff4059E6),
                        )
                      : Border.all(
                          color: Colors.transparent,
                        ),
                ),
                child: const Icon(
                  Icons.store,
                  size: 50,
                  color: Colors.black,
                ),
              ),
            ),
            Visibility(
              visible: urlStringImage.isNotEmpty,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xffF4F4F5),
                  borderRadius: BorderRadius.circular(18),
                  border: isSelected
                      ? Border.all(color: const Color(0xff4059E6))
                      : Border.all(color: Colors.transparent),
                ),
                child: Image.network(
                  urlStringImage,
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: SizedBox(
                width: 80,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? const Color(0xff4059E6)
                        : const Color(0xff040415),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
