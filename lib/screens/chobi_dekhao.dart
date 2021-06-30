import 'dart:convert';
import 'package:ami_code_pari_na/Screens/Home/home.dart';
import 'package:ami_code_pari_na/models/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Api> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  final JsonBody = jsonDecode(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Api.fromJson(JsonBody[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class DekhaoChobi extends StatefulWidget {
  const DekhaoChobi({Key key}) : super(key: key);

  @override
  _DekhaoChobiState createState() => _DekhaoChobiState();
}

class _DekhaoChobiState extends State<DekhaoChobi> {
  Future<Api> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[600],
      appBar: AppBar(
        title: Text('Ami_Code_Pari_na'),
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: FutureBuilder<Api>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(snapshot.data.url.toString());
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
class MyDrawer extends StatelessWidget {
  final Function onTap;
  MyDrawer({this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey[600],
              ),
              child: Padding(
                padding: EdgeInsets.all(.6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'User',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Khoj The Search'),
              onTap: () => onTap( Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      )),
            ),
            ListTile(
              title: Text('Dekhao Chobi'),
              onTap: () => onTap( Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DekhaoChobi()),
                      )
                      ),
            )
          ],
        ),
      ),
    );
  }
}