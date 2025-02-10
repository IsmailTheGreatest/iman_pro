import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/cubit/search_category_cubit.dart';
/// SearchBarInSearchPage class
class SearchBarInSearchPage extends StatelessWidget {
  /// SearchBarInSearchPage constructor
  const SearchBarInSearchPage({
    required this.controller, required this.focusNode, super.key,
  });
/// SearchBarInSearchPage constructor
  final TextEditingController controller;
  /// SearchBarInSearchPage constructor
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    onChanged: (value) {
                      context.read<SearchCubit>().search(value);
                    },
                    focusNode: focusNode,
                    enabled: true,
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      suffix: value.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                controller.clear();
                                context.read<SearchCubit>().search('');
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
    );
  }
}
