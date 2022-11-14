import 'package:assigment/screen3.dart';
import 'package:assigment/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Users",
              style: TextStyle(
                color: Colors.pink.shade700,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("userlist").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(snapshot.data.docs.length);
                    //  print(snapshot.data.docs[index]['imageUrl']);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Screen3(
                                user: User(
                                    id: index,
                                    name: snapshot.data.docs[index]['name'],
                                    number: snapshot.data.docs[index]['number'],
                                    age: snapshot.data.docs[index]['age'],
                                    department: snapshot.data.docs[index]
                                        ['department'],
                                    imageUrl: snapshot.data.docs[index]
                                        ['imageUrl']),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Hero(
                              tag: index,
                              child: CircleAvatar(
                                radius: 31,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    snapshot.data.docs[index]['imageUrl'],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              snapshot.data.docs[index]['name'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("error");
              } else {
                Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Text("No Data");
            },
          ),
        ],
      ),
    );
  }
}
