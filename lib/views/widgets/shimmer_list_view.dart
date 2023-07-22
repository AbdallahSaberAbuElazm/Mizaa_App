import 'package:flutter/material.dart';
import 'package:mizaa/views/widgets/shimmer_container.dart';

class ShimmerListView extends StatelessWidget {
  final double width;
  final double height;
  final double topPadding;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  const ShimmerListView(
      {Key? key,
      required this.width,
      required this.height,
      required this.topPadding,
      required this.bottomPadding,
      required this.rightPadding,
      required this.leftPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        ShimmerContainer(
          width: width,
          height: height,
          topPadding: topPadding,
          bottomPadding: bottomPadding,
          leftPadding: leftPadding,
          rightPadding: rightPadding,
        ),
        ShimmerContainer(
          width: width,
          height: height,
          topPadding: topPadding,
          bottomPadding: bottomPadding,
          leftPadding: leftPadding,
          rightPadding: rightPadding,
        ),
      ]),
    );
  }
}
