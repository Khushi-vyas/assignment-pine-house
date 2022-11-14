import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;

  final void Function()? onPress;
  const CustomButton({
    Key? key,
    required this.title,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.pink,
            width: 2,
          ),
          gradient: LinearGradient(
              colors: [Colors.pink.shade200, Colors.pink.shade700]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: onPress,
          // onPressed: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => newScreen,
          //     ),
          //   );
          //},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            onSurface: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

class Button2 extends StatelessWidget {
  final String title;

  final void Function()? onPress;

  const Button2({
    Key? key,
    required this.title,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.deepPurple,
          width: 2,
        ),
        gradient: LinearGradient(colors: [
          Colors.white,
          Colors.deepPurple.shade50,
          Colors.deepPurple.shade100,
        ]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        // onPressed: () {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => newScreen,
        //     ),
        //   );
        // },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onSurface: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
