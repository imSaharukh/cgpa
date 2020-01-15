
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'cgpa_calculator.dart';
CgpaListItem cgpaListItem;
List lst = [1];
CgpaCalculator cgpaCalculator;
//List<Widget> itemsList=new List<Widget>();

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var credit;
  int index;

   List<Widget> itemsList=new List<Widget>();
  String cgpa;
  void changeState(){
    setState(() {

    });
  }
@override
  void initState() {
    // TODO: implement initState
  cgpaCalculator=CgpaCalculator();
  cgpaListItem=CgpaListItem();
  cgpaListItem.add(Details(0,this));
  index=1;
    super.initState();
  }

  void setCgpaAndCredit(_credit,String _cgpa){
    
    setState(() {
      credit=_credit;
      cgpa=_cgpa;

    });

  }
 
  @override
  Widget build(BuildContext context) {



  final me=this;


    return Scaffold(
      floatingActionButton: RaisedButton(
        child: Text('Calculate CGPA'),
        onPressed: () {
          final _credit=cgpaCalculator.calCulateCredit();
          setCgpaAndCredit(_credit,"CGPA");
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
                    children: <Widget>[Text(credit!=null?credit.toString():"4.0"), Text(cgpa!=null?cgpa.toString():"CGPA")],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text(credit!=null?credit.toString():"4.0"), Text(cgpa!=null?cgpa.toString():"CGPA")],
                  ),
                ),
              ],
            ),

            Container(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                itemCount: cgpaListItem.length()+1,
                  itemBuilder:(BuildContext context, int index) {
                  print(index);
                    return Details(index,me);
                  },
              ),
            )  ,
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {

                  index++;
                 cgpaListItem.add(Details(index,me));
                 setState(() {

                 });

              print(cgpaListItem.length());
              },
            )
          ],
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {
   int i;
   _MyHomePageState _myHomePageState;

  Details(int i,_MyHomePageState _myHomePageState){
    this.i=i;
    this._myHomePageState=_myHomePageState;
  }

  @override
  _DetailsState createState() => _DetailsState(this._myHomePageState);
}

class _DetailsState extends State<Details> {
  _MyHomePageState _myHomePageState;
  _DetailsState(_MyHomePageState _myHomePageState){
    this._myHomePageState=_myHomePageState;
  }


  final _formkey = GlobalKey<FormState>();
  TextEditingController courseController=TextEditingController();
  TextEditingController creditController=TextEditingController();
  TextEditingController cgpaController=TextEditingController();
  Controllers controllers;


  @override
  Widget build(BuildContext context) {
    final me=this;
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
              cgpaListItem.remove(widget.i-1);
              this._myHomePageState.changeState();
              setState(() {
              //  lst.removeAt(widget.i);
               // itemsList.removeAt(widget.i+1);
               // _myHomePageState.changeState();
               // cgpaListItem.remove(widget.i);
                print(widget.i);
             //   cgpaCalculator.remove(widget.i);
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



