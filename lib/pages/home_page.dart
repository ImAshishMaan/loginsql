import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text("HomePage"),
      ),
    );
  }
}
