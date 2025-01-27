import 'package:flutter/material.dart';

import '../../../data/models/merchant.dart';
import '../../map_screen/map_screen.dart';

class ListOfStoreItem extends StatelessWidget {
  final Merchant merchant;

  const ListOfStoreItem({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(merchants: [merchant]),));},
        child: Row(
          children: [
            if (merchant.logo.isNotEmpty)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(merchant.logo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                merchant.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
