import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_cubit.dart';
import 'map_screen.dart';

class SearchPage extends StatelessWidget {
  final String? category;

  const SearchPage({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: SearchView(category: category),
    );
  }
}

class SearchView extends StatelessWidget {
  final String? category;

  const SearchView({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();

    if (category != null) {
      controller.text = category!;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F4F5),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xff818188),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F4F5),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (context, value, __) {
                            return TextField(
                              focusNode: focusNode,
                              enabled: true,
                              controller: controller,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                suffix: value.text.isNotEmpty
                                    ? GestureDetector(
                                  onTap: () {
                                    controller.clear();
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    margin: const EdgeInsets.only(right: 15),
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffc4c4c4),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      weight: 2000,
                                      Icons.close_rounded,
                                      size: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                    : null,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color(0xff818188),
                                ),
                                enabled: false,
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff818188),
                                ),
                                border: InputBorder.none,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (category == null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CategoryContainer(
                            urlStringImage: 'assets/nout.png',
                            title: 'Электроника',
                            isSelected: context.watch<SearchCubit>().state.selectedCategoryIndex == 0,
                            onTap: () {
                              context.read<SearchCubit>().updateCategory(0, 'Электроника');
                            },
                          ),
                          CategoryContainer(
                            urlStringImage: 'assets/tel.png',
                            title: 'Смартфоны',
                            isSelected: context.watch<SearchCubit>().state.selectedCategoryIndex == 1,
                            onTap: () {
                              context.read<SearchCubit>().updateCategory(1, 'Смартфоны');
                            },
                          ),
                          CategoryContainer(
                            urlStringImage: 'assets/bitovoy.png',
                            title: 'Бытовая техника',
                            isSelected: context.watch<SearchCubit>().state.selectedCategoryIndex == 2,
                            onTap: () {
                              context.read<SearchCubit>().updateCategory(2, 'Бытовая техника');
                            },
                          ),
                          CategoryContainer(
                            urlStringImage: 'assets/ikea-sofa (1).png',
                            title: 'Мебель',
                            isSelected: context.watch<SearchCubit>().state.selectedCategoryIndex == 3,
                            onTap: () {
                              context.read<SearchCubit>().updateCategory(3, 'Мебель');
                            },
                          ),
                          CategoryContainer(
                            urlStringImage: 'assets/auto.png',
                            title: 'Авто товары',
                            isSelected: context.watch<SearchCubit>().state.selectedCategoryIndex == 4,
                            onTap: () {
                              context.read<SearchCubit>().updateCategory(4, 'Авто товары');
                            },
                          ),
                          CategoryContainer(
                            urlStringImage: 'assets/teddy-bear-.png',
                            title: 'Детские товары',
                            isSelected: context.watch<SearchCubit>().state.selectedCategoryIndex == 5,
                            onTap: () {
                              context.read<SearchCubit>().updateCategory(5, 'Детские товары');
                            },
                          ),
                        ],
                      ),
                    ),
                    if (context.watch<SearchCubit>().state.selectedCategoryIndex == null)
                      const Header(
                        title: "Часто ищут",
                        size: 22,
                      ),
                    if (context.watch<SearchCubit>().state.selectedCategory != null)
                      Header(
                        title: context.watch<SearchCubit>().state.selectedCategory!,
                        size: 22,
                      ),
                  ],
                ),
              const ListOfStoreItem(icon: 'assets/img.png', title: 'Elmakon'),
              const ListOfStoreItem(icon: 'assets/texnomart.png', title: 'Texnomart'),
              const ListOfStoreItem(icon: 'assets/idea.png', title: 'Idea'),
              const ListOfStoreItem(icon: 'assets/mediaparkListItem.png', title: 'Mediapark'),
              const ListOfStoreItem(icon: 'assets/discount.png', title: 'Discount'),
              const ListOfStoreItem(title: 'Shop'),
              const ListOfStoreItem(title: 'Shop'),
              const ListOfStoreItem(title: 'Shop'),
              const ListOfStoreItem(title: 'Shop'),
              const ListOfStoreItem(title: 'Shop'),
              const ListOfStoreItem(title: 'Shop'),
              const ListOfStoreItem(title: 'Shop'),
            ],
          ),
        ),
      ),
    );
  }
}

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

class Header extends StatelessWidget {
  final String title;
  final double? size;

  const Header({super.key, required this.title, this.size});

  @override
  Widget build(BuildContext context) {
    double fontSize = 26;
    if (size != null) {
      fontSize = size!;
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        title,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
    );
  }
}

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
