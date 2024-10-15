import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    this.onKeyPressed,
    required this.counter,
    this.limit,
  });

  final Function(String)? onKeyPressed;
  final int counter;
  final double? limit;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.counter;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton(
          onPressed: _decrementCounter,
          child: const Icon(Icons.remove),
        ),
        FadeTransition(
          opacity: _animation,
          child: Text(
            _counter.toString(),
            style: const TextStyle(fontSize: 24),
          ),
        ),
        FloatingActionButton(
          onPressed: _incrementCounter,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  void _incrementCounter() {
    final limit = widget.limit ?? 0.0;
    if (limit > _counter || limit == 0.0) {
      setState(() {
        _counter++;
        widget.onKeyPressed?.call(_counter.toString());
        _animateCounter();
      });
    }
  }

  void _decrementCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
        widget.onKeyPressed?.call(_counter.toString());
        _animateCounter();
      });
    }
  }

  void _animateCounter() {
    _controller.reset();
    _controller.forward();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedCounterDouble extends StatefulWidget {
  final Function(String)? onKeyPressed;
  final double counter;

  const AnimatedCounterDouble({
    super.key,
    this.onKeyPressed,
    required this.counter,
  });

  @override
  State<AnimatedCounterDouble> createState() => _AnimatedCounterDoubleState();
}

class _AnimatedCounterDoubleState extends State<AnimatedCounterDouble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.counter;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton(
          onPressed: () => _decrementCounter(1),
          child: const Icon(Icons.remove),
        ),
        FloatingActionButton(
          onPressed: () => _decrementCounter(0.1),
          child: const Icon(Icons.remove),
        ),
        FadeTransition(
          opacity: _animation,
          child: Text(
            _counter.toStringAsFixed(1),
            style: const TextStyle(fontSize: 24),
          ),
        ),
        FloatingActionButton(
          onPressed: () => _incrementCounter(0.1),
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () => _incrementCounter(1),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  void _incrementCounter(double amount) {
    setState(() {
      _counter += amount;
      widget.onKeyPressed?.call(_counter.toStringAsFixed(1));
      _animateCounter();
    });
  }

  void _decrementCounter(double amount) {
    if (_counter > 1) {
      setState(() {
        _counter -= amount;
        widget.onKeyPressed?.call(_counter.toStringAsFixed(1));
        _animateCounter();
      });
    }
  }

  void _animateCounter() {
    _controller.reset();
    _controller.forward();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
