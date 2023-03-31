import 'dart:collection';
import 'dart:core';

double countSubTotal(List<dynamic> theList){
  double thisSubTotal = 0;

  for(var price in theList){
    thisSubTotal += price;
  }

  return thisSubTotal;
}

double countSubBobotTotal(List<dynamic> theList){
  double thisSubBobot = 0;

  for(var bobot in theList){
    thisSubBobot += bobot;
  }

  return thisSubBobot;
}