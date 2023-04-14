import 'package:flutter/material.dart';
import 'dart:async';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  const DelayedAnimation({super.key, required this.child, required this.delay});

  @override
  DelayedAnimation_State createState() => DelayedAnimation_State();
}

// ignore: camel_case_types
class DelayedAnimation_State extends State<DelayedAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800)
    );

    final curve = CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate
    ); //effet ralenti et glissant

    _animOffset = Tween<Offset>(
        begin: const Offset(0, -0.35),
        end: Offset.zero
    ).animate(curve);

    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _controller,
        child: SlideTransition(
          position: _animOffset,
          child: widget.child,
        )
    );
  }
}
