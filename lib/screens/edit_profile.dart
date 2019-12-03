import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/services/database_Service.dart';

class EditProfile extends StatefulWidget {
  final User user;

  EditProfile({this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _bio = '';

  @override
  initState(){
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
  }


  _submit(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      //  Update user in database
      String _profileImageUrl = '';
      User user = User(
        id: widget.user.id,
        name: _name,
        profileImageUrl: _profileImageUrl,
        bio: _bio
      );
      DatabaseService.updateUser(user);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Edit profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage:
                    NetworkImage('https://i.redd.it/dmdqlcdpjlwz.jpg'),
                  ),
                  FlatButton(
                    onPressed: () => print('Change profile image'),
                    child: Text(
                      'Change profile image',
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .accentColor, fontSize: 16.0),
                    ),
                  ),
                  TextFormField(
                      initialValue: _name,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            size: 30.0,
                          ),
                          labelText: 'Name'),
                      validator: (input) =>
                      input
                          .trim()
                          .length < 1 ? 'Please enter a valid name' : null,
                      onSaved: (input) => _name = input
                  ),
                  TextFormField(
                    initialValue: _bio,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.book,
                          size: 30.0,
                        ),
                        labelText: 'Bio'),
                    validator: (input) =>
                    input
                        .trim()
                        .length > 150 ? '150 characters max' : null,
                    onSaved: (input) => _bio = input,
                  ),
                  Container(
                    margin: EdgeInsets.all(40.0),
                    height: 40.0,
                    width: 250.0,
                    child: FlatButton(
                      onPressed: _submit,
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('Save profile',
                        style: TextStyle(
                            fontSize: 18.0
                        ),),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
