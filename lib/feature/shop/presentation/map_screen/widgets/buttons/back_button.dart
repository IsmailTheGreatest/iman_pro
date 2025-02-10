import 'package:flutter/material.dart';

///
class BackButton extends StatelessWidget {
  ///
  const BackButton({
    required this.onTap,
    super.key,
  });

  ///
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 53,
      left: 20,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff040415).withValues(alpha: 0.1),
                blurRadius: 15,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
