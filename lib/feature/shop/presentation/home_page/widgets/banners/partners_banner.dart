import 'package:flutter/material.dart';
class PartnersBanner extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double distance;
  final String? storeIconImgUrl;
  final VoidCallback onTap;

  const PartnersBanner(
      {super.key,
        required this.imageUrl,
        required this.title,
        required this.distance,
        this.storeIconImgUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Visibility(
                visible: imageUrl.isEmpty,
                child: Container(
                  margin: const EdgeInsets.all( 8),
                  height: 175,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff4059E6).withOpacity(0.1),
                  ),
                    child: const Center(
                      child: Icon(
                        Icons.store,
                        color: Colors.black,
                        size: 80,
                      ),
                    ),
                ),
              ),
              Visibility(
                visible: imageUrl.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 175,
                    width: 300,
                    decoration: BoxDecoration(
                      color:const Color(0xff4059E6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff040415)),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/locationIcon.png',
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      '${distance.toStringAsFixed(1)} км',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff818188)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}