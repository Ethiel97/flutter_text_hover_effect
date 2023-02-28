import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_scale_hover/utils/constants.dart';
import 'package:flutter_text_scale_hover/widgets/letter_widget.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "Awesome Developer";

  Offset? dragUpdateDetails;

  @override
  void initState() {
    super.initState();
  }

  handleDragLogic(i) {
    if (dragUpdateDetails != null) {
      return ((i - 1) * AppConstants.letterWidgetWidth) <=
              dragUpdateDetails?.dx.toInt() &&
          (dragUpdateDetails?.dx.toInt())! <=
              (i * AppConstants.letterWidgetWidth);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: GestureDetector(
              onHorizontalDragStart: (details) {
                // print(details.localPosition);
                setState(() => {dragUpdateDetails = details.localPosition});
              },
              onHorizontalDragUpdate: (details) {
                setState(() => {dragUpdateDetails = details.localPosition});
              },
              onHorizontalDragCancel: () {
                setState(() {
                  dragUpdateDetails = null;
                });
              },
              onHorizontalDragEnd: (details) {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: text
                    .split("")
                    .mapIndexed(
                      (i, e) => Expanded(
                        child: LetterWidget(
                          letter: e,
                          animate: handleDragLogic(i + 1),
                          dragDetails: dragUpdateDetails,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      );
}
