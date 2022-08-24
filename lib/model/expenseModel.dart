import 'package:flutter/material.dart';

class ExpenseModel {

var Title;
var Description;
late DateTime Date;
late TimeOfDay Time;
late String ExpenseType;
late double Amount;

ExpenseModel(this.Title, this.Description, this.Date, this.Time, this.ExpenseType, this.Amount);




}