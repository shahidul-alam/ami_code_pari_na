import 'package:ami_code_pari_na/screens/chobi_dekhao.dart';
import 'package:ami_code_pari_na/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  TextEditingController _numberController = TextEditingController();
  TextEditingController _controller = TextEditingController();
  var result = '';
  void uploadList(String a) async {
    try {
      FirebaseFirestore.instance.collection("listCollection").add({
        'list': a.toString(),
      });
      print(a);
    } catch (e) {}
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
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    hintText: 'eg: 1,2,3...',
                    labelText: 'Input_Field',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(),
                    fillColor: Colors.teal,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Search_Field',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(),
                    fillColor: Colors.teal,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    String list = _numberController.text;
                    String search = _controller.text;
                    var lst = list.split(',');
                    lst.sort((b, a) => a.compareTo(b));
                    uploadList(lst.toString());
                    for (var i = 0; i < lst.length; i++) {
                      if (lst[i] == search) {
                        setState(() {
                          result = 'True';
                        });
                        break;
                      } else {
                        setState(() {
                          result = 'False';
                        });
                      }
                    }
                  },
                  child: Text('Khoj The Search'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                ),
                Text(
                  result,style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                ),
                SizedBox(
                  height: 60,
                ),
                FlatButton.icon(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  icon: Icon(Icons.person),
                  label: Text('log out'),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),
          ),
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
