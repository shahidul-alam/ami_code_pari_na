import 'package:ami_code_pari_na/loading.dart';
import 'package:ami_code_pari_na/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth= AuthService();
  String email='';
  String password='';
  String error='';
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading?Loading(): Scaffold(
      backgroundColor: Colors.blueGrey[600],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
        title: Text('Sign up to...Ami Code Pari Na'),
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
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey,width: 1.5)
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
                child: Text('Register',style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),),
                onPressed: () async{
                if(_formKey.currentState.validate()){
                  setState(() {
                    loading=true;
                  });
                  dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                  if(result == null)
                    {
                      setState(() {
                        error = 'please supply a valid mail';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 10,),
              Text(error, style: TextStyle(color: Colors.red, fontSize: 11),),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Already have an account?',style: TextStyle(color: Colors.white),),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      widget.toggleView();
                    } ,
                      child: Text(
                        'Sign In',
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
