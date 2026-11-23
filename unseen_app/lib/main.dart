import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'objects/widgets/main_widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BackgroundImageWidget(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.92,
                heightFactor: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 512, child: Moods()),
                                Expanded(
                                  child: Clock(
                                    style: const TextStyle(
                                      fontFamily: 'Larish',
                                      fontSize: 172,
                                      height: 0.8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Transform.translate(
                                  offset: Offset(0, -32),
                                  child: LeafSlider(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 256, child: Column(children: [Settings()])),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
