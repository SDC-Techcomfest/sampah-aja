import 'package:flutter/material.dart';

class GradientAppbar extends StatelessWidget {
  const GradientAppbar({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 174,
      child: Column(
        children: [
          const SizedBox(height: 48,),
          child
        ],
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: const Alignment(0, 0.6),
              colors: [
                Color(0xFF499D2F).withOpacity(0.2),
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

