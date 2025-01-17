import 'package:iman_invest/screens/search_page.dart';
import 'package:iman_invest/helper_functions/navigate_without_transition.dart';
import 'package:flutter/material.dart';
class CategoryContainer extends StatelessWidget {
  final String urlStringImage;
  final String title;
  const CategoryContainer({super.key, required this.urlStringImage, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: (){
          navigateWithoutTransition(context, SearchPage(category: title,));
              },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),

              decoration: BoxDecoration(
                color: const Color(0xffF4F4F5),
                borderRadius: BorderRadius.circular(18),
              ),
              child:

              Image.asset(urlStringImage, height: 50, width: 50,),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: SizedBox(

                  width: 80,
                  child: Text(title,textAlign: TextAlign.center, softWrap: true, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff040415)),)),
            ),


          ],
        ),
      ),
    );
  }
}