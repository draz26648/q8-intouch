import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final bool all;

  const AppLoader({
    Key? key,
    this.all = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (all) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: const Center(child: CupertinoActivityIndicator(radius: 22)),
      );
    } else {
      return const Center(child: CupertinoActivityIndicator(radius: 22));
    }
  }
}
