import 'package:flutter/material.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Drag and Drop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int timesDragged = 0;
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DragTarget<Color>(
              // Check what we want to accept. If the data is Colors.blue then true(accept) otherwise false(don't accept)
              // onWillAccept: (value) {
              //   return value == Colors.blue ? true : false;
              // },

              // what we do when we accept
              onAccept: (value) {
                setState(() {
                  timesDragged++;
                  color = value;
                });
              },

              // the actual thing, what we see depending on what we accept
              builder: (context, data, rejectedDate) {
                return Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Times dragged: $timesDragged',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Last data: $color',
                        style: TextStyle(fontSize: 16, color: color),
                      ),
                    ],
                  )),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Draggable<Color>(
                  // the data that we want to pass with draggable widget
                  data: Colors.blue,
                  //thing that we drag
                  feedback: ContainerBlue(),
                  //what we see before dragging
                  child: ContainerBlue(),
                  //what remains behind
                  childWhenDragging: Empty(),
                ),
                Draggable<Color>(
                  data: Colors.red,
                  feedback: ContainerRed(),
                  child: ContainerRed(),
                  childWhenDragging: Empty(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Empty extends StatelessWidget {
  const Empty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.grey[300],
    );
  }
}

class ContainerRed extends StatelessWidget {
  const ContainerRed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.red,
    );
  }
}

class ContainerBlue extends StatelessWidget {
  const ContainerBlue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.blue,
    );
  }
}
