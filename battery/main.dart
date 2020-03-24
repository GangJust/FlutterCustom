import 'package:flutter/material.dart';
import 'package:battery/battery_widget.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: Scaffold(
        appBar: AppBar(
          title: Text('电池'),
        ),
        body: ListView.builder(
            itemCount: 100,
            itemBuilder: (_, index) {
              return Row(
                children: <Widget>[
                  SizedBox(height: 50,width: 20),
                  BatteryWidget(
                    level: index + 1,
                    color: Colors.blueGrey,
                    text: true,
                    textStyle: TextStyle(fontSize: 10, color: Colors.white),
                    type: BatteryBulgeType.top,
                  ),
                  SizedBox(height: 50,width: 20),
                  BatteryWidget(
                    level: index + 1,
                    color: Colors.blueGrey,
                    text: true,
                    textStyle: TextStyle(fontSize: 10, color: Colors.white),
                    type: BatteryBulgeType.right,
                  ),
                ],
              );
            }),
      ),
    );
  }
}