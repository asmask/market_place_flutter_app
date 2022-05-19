import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/entities/category.dart';
import 'package:market_place_flutter_app/models/others/draggable_list.dart';

List<DraggableList> draggableList = const [
  DraggableList(header: 'Days On (full session)', items: [
    DraggableListItem(title: 'Monday'),
    DraggableListItem(title: 'Tuesday'),
    DraggableListItem(title: 'Wednesday'),
    DraggableListItem(title: 'Thursday'),
    DraggableListItem(title: 'Friday'),
    DraggableListItem(title: 'Friday'),
  ]),
  DraggableList(header: 'Days On (single session)', items: [
    DraggableListItem(title: 'Saturday'),
  ]),
  DraggableList(header: 'Days Off', items: [
    DraggableListItem(title: 'Sunday'),
  ]),
];

List<Category> mcategories = [
  const Category(
      id: 1,
      name: "Home",
      image: "https://img.icons8.com/dusk/64/000000/home-automation.png",
      specialities: []),
  const Category(
      id: 1,
      name: "Health",
      image: "https://img.icons8.com/dusk/64/000000/apple-health.png",
      specialities: []),
  const Category(
      id: 1,
      name: "Business",
      image: "https://img.icons8.com/dusk/64/000000/business.png",
      specialities: []),
  const Category(
      id: 1,
      name: "Beauty",
      image: "https://img.icons8.com/dusk/64/000000/perfume-bottle.png",
      specialities: []),
  const Category(
      id: 1,
      name: "Removals",
      image: "https://img.icons8.com/dusk/64/000000/truck.png",
      specialities: []),
];
// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp userNameValidatorRegExp =
    RegExp(r"^(?=.{4,20}$)(?:[a-zA-Z\d]+(?:(?:\.|-|_)[a-zA-Z\d])*)+$");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kUserNameNullError =
    "Please Enter your username [4-10 caracters & no [. or _]]";
const String kInvalidUserNameError = "Please Enter Valid UserName";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kSNamelNullError = "Please Enter Service name";
const String kSDesclNullError = "Please Enter Service description";
const String kSCatNullError = "Please Select service's category";
const String kSSpecNullError = "Please Select your speciality";

List<BoxShadow> shadowList = [
  BoxShadow(
      color: Colors.grey.shade400, blurRadius: 10, offset: const Offset(0, 2))
];
