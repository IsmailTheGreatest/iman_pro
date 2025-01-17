import 'package:flutter/material.dart';
import 'package:iman_invest/screens/map_screen.dart';
class ListOfStoreItem extends StatelessWidget {
  final String? icon;
  final String title;

  const ListOfStoreItem({super.key, this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute( builder: (context)=> const MapScreen(),));
        },
        child: Row(
          children: [
            if (icon != null)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(icon!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xff040415),
            ),
          ],
        ),
      ),
    );
  }
}
