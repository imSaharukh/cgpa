import 'package:flutter/material.dart';
import 'cgpa_calculator.dart';

List lst = [1];
CgpaCalculator cgpaCalculator;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  @override
  Widget build(BuildContext context) {
     cgpaCalculator=CgpaCalculator();
    return Scaffold(
      floatingActionButton: RaisedButton(
        child: Text('Calculate CGPA'),
        onPressed: () {
          print(cgpaCalculator.calCulateCredit());
        },
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text('0.00'), Text('CGPA')],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text('0.00'), Text('Credits')],
                  ),
                ),
              ],
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: lst.length,
              itemBuilder: (BuildContext context, int index) {
                return Details(index);
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  lst.add(1);
                });
                print(lst.length);
              },
            )
          ],
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {
  final int i;
  Details(this.i);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController courseController=TextEditingController();
  TextEditingController creditController=TextEditingController();
  TextEditingController cgpaController=TextEditingController();
  Controllers controllers;


  @override
  Widget build(BuildContext context) {
    controllers=new Controllers(courseController, creditController, cgpaController);
    cgpaCalculator.add(controllers);
    return Form(
      child: Row(
        key: _formkey,
        children: <Widget>[
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(hintText: 'COURSE'),
              controller: courseController,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Credits'),
              controller: creditController,
              validator: (v) {
                if (v.isEmpty) {
                  return 'Please Enter Credits';
                } else if (double.parse(v) >= 4) {
                  return 'CGPA can\'t be more then 4.00';
                } else {
                  return null;
                }
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(hintText: 'CGPA'),
              controller: cgpaController,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                lst.removeAt(widget.i);
                cgpaCalculator.remove(widget.i);
              });
            },
          )
        ],
      ),
    );
  }

 @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.

    cgpaController.dispose();
    creditController.dispose();
    courseController.dispose();
   
    super.dispose();
  }
}
