import 'package:ami_code_pari_na/loading.dart';
import 'package:ami_code_pari_na/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String error = '';
  String email = '';
  String password='';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.blueGrey[600],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
          title: Text('Sign in to...Ami Code Pari Na'),
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Welcome',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox( height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.5)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey,width: 1.5)
                  )
                ),
                validator: (val) => val.isEmpty? 'Enter an Email':null,
                onChanged: (val){
                  setState(() {
                    email=val;
                  });
                },
              ),
              SizedBox( height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.5)
                    )
                ),
                validator: (val) => val.length < 6 ?'Enter a Password that is larger than 6':null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
              ),
              SizedBox( height: 20.0),
              RaisedButton(
                color: Colors.blueGrey,
                child: Text('Sign In',style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading=true;
                    });
                     dynamic result = await _auth.signInWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        error = 'could not sign in with those credentials';
                        loading=false;
                      });
                    }
                    print('valid');
                  }
                }
              ),
              SizedBox(height: 10,),
              Text(error, style: TextStyle(color: Colors.red, fontSize: 11),),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Don\'t have an account?',style: TextStyle(color: Colors.white),),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      widget.toggleView();
                    } ,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
