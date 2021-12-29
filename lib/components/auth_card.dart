import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({Key? key, required this.child}) : super(key: key);
  
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Column(
          children: [
            const SizedBox(
              height: 33,
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  child
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset('assets/images/logo2.png'),
        )
      ],
    );
  }
}
