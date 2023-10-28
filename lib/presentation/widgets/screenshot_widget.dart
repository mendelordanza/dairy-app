import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:night_diary/helper/colors.dart';

class ScreenshotWidget extends StatelessWidget {
  final String quote;
  final String author;

  const ScreenshotWidget(
      {required this.quote, required this.author, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkCardColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40.0,
              horizontal: 30.0,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.format_quote_rounded,
                    color: Colors.white,
                  ),
                  Text(
                    quote,
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Icon(
                    Icons.format_quote_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/ic_logo.svg",
                  height: 30.0,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                const Text(
                  "Dairy App",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
