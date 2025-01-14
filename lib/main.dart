import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'search_page.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Gilroy',
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Магазины",
                        style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SvgPicture.asset(
                        'assets/icons.svg',
                        height: 26,
                        width: 26,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xffF4F4F5),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: TextField(
                      readOnly: true,
                      enabled: true,
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const SearchPage(), // Replace with your screen
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return child; // No transition; widget simply appears
                          },
                        ));
                      },

                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xff818188),
                        ),
                        enabled: false,
                        hintText: 'Поиск по магазинам',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff818188),

                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                CarouselSlider(
                    items: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/partners.png',),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/partners.png'),
                      )
                    ],
                    options: CarouselOptions(
                    autoPlay: true,
                        aspectRatio: 335/130,
                        enlargeCenterPage: false,
                        viewportFraction: 0.90,
                        scrollDirection: Axis.horizontal)),
                const SizedBox(height: 10,),
                const SingleChildScrollView(

                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CategoryContainer(urlStringImage: 'assets/nout.png', title: 'Электроника'),
                      CategoryContainer(urlStringImage: 'assets/tel.png', title: 'Смартфоны'),
                      CategoryContainer(urlStringImage: 'assets/bitovoy.png', title: 'Бытовая техника'),
                      CategoryContainer(urlStringImage: 'assets/ikea-sofa (1).png', title: 'Мебель'),
                      CategoryContainer(urlStringImage: 'assets/auto.png', title: 'Авто товары'),
                      CategoryContainer(urlStringImage: 'assets/teddy-bear-.png', title: 'Детские товары'),
                    ],
                  ),
                ),


                const  Header(title: "Поблизости"),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:    Row(
                    children: [
                      PartnersBanner(imageUrl: 'assets/mediapark.png', title: 'MEDIAPARK', distance: 1.2, storeIconImgUrl: 'assets/mediaparkLogo.png'),
                      PartnersBanner(imageUrl: 'assets/store.png', title: 'Магазин', distance: 2.4, storeIconImgUrl: null),
                    ],
                  ),
                ),
                const Header(title: "Вам может понравится"),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:    Row(
                    children: [
                      PartnersSmallBanner(imageUrl: 'assets/elmakonBanner.png', title: 'Elmakon', distance: 1.2, storeIconImgUrl: 'assets/elmakonIcon.png'),
                      PartnersSmallBanner(imageUrl: 'assets/store.png', title: 'Магазин', distance: 2.4, storeIconImgUrl: null),
                      PartnersSmallBanner(imageUrl: 'assets/magazini.png', title: 'Магазин', distance: 2.4, storeIconImgUrl: null),
                      PartnersSmallBanner(imageUrl: 'assets/magazini.png', title: 'Магазин', distance: 2.4, storeIconImgUrl: null),
                    ],
                  ),
                ),



              ],
            )),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;
  final double? size;
  const Header({
    super.key, required this.title, this.size
  });


  @override
  Widget build(BuildContext context) {
    double fontSize= 26;
    if(size != null){
    fontSize= size!;
    }
    return   Padding(
        padding:  const EdgeInsets.all(20.0),
        child:  Text(title, style:  TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),),
      );
  }
}
class CategoryContainer extends StatelessWidget {
  final String urlStringImage;
  final String title;
  const CategoryContainer({super.key, required this.urlStringImage, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>  SearchPage(category: title,), // Replace with your screen
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return child; // No transition; widget simply appears
            },
          ));       },
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
class PartnersBanner extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double distance;
  final String? storeIconImgUrl;
  const PartnersBanner({super.key, required this.imageUrl, required this.title, required this.distance,  this.storeIconImgUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 175,
                width: 300,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if (storeIconImgUrl != null)
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(storeIconImgUrl!),
                        ),
                      ),


                    ),
                  if(storeIconImgUrl == null)
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(Icons.store, color: Colors.black,),
                      ),
                    ),
                ],
              ),
            ),
          ],

        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/locationIcon.png', height: 20, width: 20,),
                  const SizedBox(width: 2,),
                  Text(
                    '$distance км',
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
    );
  }
}

class PartnersSmallBanner extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double distance;
  final String? storeIconImgUrl;
  const PartnersSmallBanner({super.key, required this.imageUrl, required this.title, required this.distance,  this.storeIconImgUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 145,
                width: 145,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if (storeIconImgUrl != null)
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(storeIconImgUrl!),
                        ),
                      ),


                    ),
                  if(storeIconImgUrl == null)
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(Icons.store, color: Colors.black,),
                      ),
                    ),
                ],
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
             const Text("Магазин электроники", style:  TextStyle(fontSize: 13, color: Color(0xff818188)),),

        ],),
        ),


      ],
    );
  }
}



