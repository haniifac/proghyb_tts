import 'dart:collection';
import 'dart:core';

double countSubTotal(List<dynamic> theList){
  double thisSubTotal = 0;

  for(var price in theList){
    thisSubTotal += price;
  }

  return thisSubTotal;
}