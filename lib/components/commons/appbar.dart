import 'package:flutter/material.dart';

class GradientAppbar extends StatelessWidget {
  const GradientAppbar({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 154,
      child: Column(
        children: [
          const SizedBox(height: 56,),
          child
        ],
      ),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFDDEDD9),
                Color(0xFFDDEDD9),
                Colors.white
              ]
          )
      ),
    );
  }
}

class TransparentAppbar extends StatelessWidget {
  const TransparentAppbar({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 144,
      child: child,
      decoration: const BoxDecoration(
          color: Colors.transparent
      ),
    );
  }
}

