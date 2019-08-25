import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomListPage extends StatefulWidget {
  static const routeName = '/room_list';

  @override
  _RoomListPageState createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room list"),
      ),
      body: RoomListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: _createRoom,
        child: Icon(Icons.add),
      ),
    );
  }

  void _createRoom() async {
    await Firestore.instance.collection('rooms').document().setData({
      'title': 'foo',
      'author': 'bar',
    });
  }
}

class RoomListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('rooms').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading...');
          default:
            return ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return ListTile(
                  title: Text(document['title']),
                  subtitle: Text(document['author']),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
