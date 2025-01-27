import 'package:flutter/material.dart';
class PartnersSmallBanner extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double distance;
  final VoidCallback onTap;
  final String? storeIconImgUrl;

  const PartnersSmallBanner(
      {super.key,
        required this.imageUrl,
        required this.title,
        required this.distance,
        this.storeIconImgUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Visibility(
                visible: imageUrl.isEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 145,
                    width: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.store,
                        color: Colors.black,
                        size: 80,
                      ),
                  ),
                ),
              ),),
              Visibility(
                visible: imageUrl.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 145,
                    width: 145,
                    decoration: BoxDecoration(
                      color: const Color(0xff4059E6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(22),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff040415)),
                ),
                const Text(
                  "Магазин электроники",
                  style: TextStyle(fontSize: 13, color: Color(0xff818188)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}