import 'package:flutter/material.dart';


class CgpaCalculatorView extends StatefulWidget{
  @override

  CgpaCalculatorViewState createState()=>  CgpaCalculatorViewState();
}

class CgpaCalculatorViewState  extends State<CgpaCalculatorView>{
  double avarageCredit=0.0;
 List<Widget> listViews=new List<Widget>();
 List<ItemControllers> listControllers=new List<ItemControllers>();
 final _formkey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: RaisedButton(
        child: Text('Calculate CGPA'),
        onPressed: () {
       if(_formkey.currentState.validate()){
   print(getCalculatedCredit());
   avarageCredit=getCalculatedCredit();
   setState(() {

   });
       }
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
                    children: <Widget>[Text(avarageCredit.toString()), Text("Credit")],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text("4.0"), Text("4.0")],
                  ),
                ),
              ],
            ),

            Container(
              width: double.infinity,
              height: 200,
              child: Form(
                key: _formkey,
                child: ListView.builder(
                  itemCount: listViews.length,
                  itemBuilder:(BuildContext context, int index) {

                    return ListItem(index,listControllers[index]);
                  },
                ),
              ),
            )  ,
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                TextEditingController courseController;
                TextEditingController creditController;
                TextEditingController cgpaController;

                courseController=TextEditingController();
                creditController=TextEditingController();
                cgpaController=TextEditingController();


                final itemControllers=ItemControllers(courseController,creditController,cgpaController);
                listControllers.add(itemControllers);
               listViews.add(ListItem(listViews.length-1,itemControllers));
               print(listViews.length);
                setState(() {

                });


              },
            )
          ],
        ),
      ),
    );
  }



  Widget ListItem(int index,ItemControllers itemControllers){


  //  print(listControllers.length);
    return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(hintText: 'COURSE'),
              controller: itemControllers.courseController,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Credits'),
              controller: itemControllers.creditController,
              onEditingComplete: (){

                print(double.parse(itemControllers.creditController.text)/2);
              },
              validator: (v) {
                if (v.isEmpty) {
                  return 'Please Enter Credits';
                } else if (double.parse(v) > 4) {
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
              controller: itemControllers.cgpaController,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
            listViews.removeAt(index);
           // listControllers[index].cgpaController.dispose();
           // listControllers[index].creditController.dispose();
            //listControllers[index].courseController.dispose();
           listControllers.removeAt(index);
              setState(() {


              });
            },
          )
        ],
      );





  }
 double getCalculatedCredit(){
   double credit=0.0;
   print(listControllers.length);
   listControllers.forEach((ItemControllers itemControllers){

      double currentCredit=double.parse(itemControllers.creditController.text);
      print(itemControllers.creditController.text);
 credit+=currentCredit;
   });

   return credit;
 }

  @override
  void dispose() {
    // TODO: implement dispose
    listControllers.forEach((ItemControllers itemControllers){
      itemControllers.courseController.dispose();
      itemControllers.creditController.dispose();
      itemControllers.cgpaController.dispose();
    });
    super.dispose();
  }






}


class ItemControllers{
  TextEditingController courseController,creditController,cgpaController;
  ItemControllers(TextEditingController course,TextEditingController credit,TextEditingController cgpa){
    this.courseController=course;
    this.creditController=credit;
    this.cgpaController=cgpa;

  }

}

