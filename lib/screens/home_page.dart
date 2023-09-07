import 'package:almanac_of_wisdom/constants/colors.dart';
import 'package:almanac_of_wisdom/constants/fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final double _transitionHeight = 20;
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 20, top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: AppFonts.titleFont(),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Almanac-Of',
                            style: AppFonts.titleFont(
                                fontColor: AppColors.tertiaryColor),
                          ),
                          const TextSpan(
                            text: '-Wisdom',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Build your ',
                          style: AppFonts.subtitleFont(),
                        ),
                        DefaultTextStyle(
                          style: AppFonts.subtitleFont(
                            fontColor: AppColors.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              RotateAnimatedText('Wealth',
                                  transitionHeight: _transitionHeight),
                              RotateAnimatedText('Happiness',
                                  transitionHeight: _transitionHeight),
                              RotateAnimatedText('Judgement',
                                  transitionHeight: _transitionHeight),
                              RotateAnimatedText('Wisdom',
                                  transitionHeight: _transitionHeight),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                color: Color.fromARGB(255, 245, 245, 249),
              ),
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.only(
                  left: 16, right: 14, top: 18, bottom: 10),
              child: TextField(
                controller: _searchTextEditingController,
                style: AppFonts.subtitleFont(
                    fontColor: AppColors.negativeColor,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  constraints: BoxConstraints(maxHeight: 28),
                  hintText: 'Try searching "How to build wealth"',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
