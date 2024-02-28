import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title, required this.onPressed});
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: sizeWidth,
      child: Container(
        width: sizeWidth,
        height: 50,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        child: Expanded(
            child: Stack(
          children: [
            Positioned(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),
            ),
            Positioned(
              top: -5,
              right: 10,
              bottom: -5,
              child: IconButton(
                color: const Color.fromARGB(146, 255, 255, 255),
                onPressed: onPressed,
                icon: const Icon(Icons.close),
              ),
            )
          ],
        )),
      ),
    );
  }
}
