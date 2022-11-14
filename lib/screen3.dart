import 'package:assigment/user_data_model.dart';
import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  final User user;
  const Screen3({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Hero(
              tag: user.id,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      blurRadius: 20.0,
                      spreadRadius: 10.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      user.imageUrl,
                    ),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 36,
                color: Colors.pink.shade700,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              "${user.age} years old",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Contact: ${user.number}",
              style: TextStyle(
                fontSize: 20,
                // color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Department: ${user.department}",
              style: TextStyle(
                fontSize: 20,
                // color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
