import 'package:flutter/material.dart';

void main() {
  runApp(const CounterImageToggleApp());
}

class CounterImageToggleApp extends StatelessWidget {
  const CounterImageToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CW1 Counter & Toggle',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _counter = 0;

  bool _isDark = false;
  bool _isFirstImage = true;

  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
      value: 1.0, // This ensures the first image is fully visible at the start.
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // This function acts as the increment button for the counter. When pressed, it increases the counter by a specified step value (1, 5, or 10).
  void _incrementCounter(int step) {
    setState(() {
      _counter += step;
    });
  }

  // This function acts as the decrement button for the counter. When pressed, it decreases the counter by 1, but only if the counter is greater than 0 to prevent negative values.
  void _decrementCounter() {
    if (_counter > 0){
      setState(() {
        _counter--;
      });
    }
  }

  // This function acts as the reset button for the counter. When pressed, it sets the counter back to 0.
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  // I had trouble with the starter code version of _toggleImage, because the timing of the fade animation and the image switch caused visual issues, such as images fading to nothing,
  // or the new image appearing before the fade-out completed.
  // This version of _toggleImage ensures that the fade-out animation completes before switching the image, and then fades in the new image.
  // It will wait until the fade-out is complete before switching the image, and then it will start the fade-in animation for the new image.
  void _toggleImage() async {
    await _controller.reverse();

    setState(() {
      _isFirstImage = !_isFirstImage;
    });

    await _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CW1 Counter & Toggle'),
          actions: [
            IconButton(
              onPressed: _toggleTheme,
              icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Counter: $_counter',
                // The text color is set to white in dark mode and black in light mode for better visibility.
                style: TextStyle(color: _isDark ? Colors.white : Colors.black, fontSize: 20),
              ),
              const SizedBox(height: 12),
              // This Row contains the buttons for incrementing, decrementing, and resetting the counter.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Here we have the increment buttons for the counter, which call the _incrementCounter function with different step values (1, 5, and 10) when pressed.
                  ElevatedButton(
                    onPressed: () => _incrementCounter(1),
                    child: const Text('+1'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _incrementCounter(5),
                    child: const Text('+5'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _incrementCounter(10),
                    child: const Text('+10'),
                  ),
                  // Here we have the decrement button for the counter, which calls the _decrementCounter function when pressed. It will only decrement the counter if it is greater than 0 to prevent negative values.
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    child: const Text('-1'),
                  ),
                  // Here we have the reset button for the counter, which calls the _resetCounter function when pressed. It will reset the counter back to 0.
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _resetCounter,
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // The FadeTransition widget is used to create a fade effect when toggling between the two images. The opacity of the FadeTransition is controlled by the _fade animation, which is driven by the _controller.
              FadeTransition(
                opacity: _fade,
                child: Image.asset(
                  _isFirstImage ? 'assets/image1.jpg' : 'assets/image2.jpg',
                  width: 140,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              // This button calls the _toggleImage function when pressed, which handles the logic for fading out the current image, switching to the other image, and then fading it back in.
              ElevatedButton(
                onPressed: _toggleImage,
                child: const Text('Toggle Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}