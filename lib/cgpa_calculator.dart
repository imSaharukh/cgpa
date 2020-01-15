import 'package:flutter/cupertino.dart';

class CgpaCalculator{
  final list=new List<Controllers>();

 void add(Controllers controllers){
   this.list.add(controllers);
 }

 void remove(int index){
   this.list.removeAt(index);
 }

 int length(){
return this.list.length;
 }

 double calCulateCredit(){
   double credit=0.0;
   this.list.forEach((Controllers controllers){
     var currentCredit=double.parse(controllers.creditController.text);
     credit+=currentCredit;

   });

   return credit/this.length();
 }

 




}

class Controllers{
  TextEditingController courseController,creditController,cgpaController;
  Controllers(TextEditingController course,TextEditingController credit,TextEditingController cgpa){
    this.courseController=course;
    this.creditController=credit;
    this.cgpaController=cgpa;

  }

}
