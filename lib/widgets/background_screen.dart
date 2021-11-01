import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackgroundScreen extends StatelessWidget {
  final Widget child;
  const BackgroundScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                height: size.height,
                child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SvgPicture.asset("lib/utils/wavetop.svg",
                        width: size.width),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      "lib/utils/wavebot.svg",
                      width: size.width,
                    ),
                  ),
                  child
                ]))));
  }
}
