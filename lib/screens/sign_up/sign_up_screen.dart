import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/models/category.dart';
import 'package:market_place_flutter_app/entities/client.dart';
import 'package:market_place_flutter_app/models/service.dart';
import 'package:market_place_flutter_app/models/speciality.dart';
import 'package:market_place_flutter_app/preferences/client_preferences.dart';
import 'package:market_place_flutter_app/provider/constants.dart';
import 'package:market_place_flutter_app/provider/size_config.dart';
import 'package:market_place_flutter_app/screens/sign_in/sign_in_screen.dart';
import 'package:market_place_flutter_app/widget/form_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late List<Category> _categories;
  String? catSelectedItem;
  String? speSelectedItem;

  final List<String> categories = [];
  late List<Speciality> _specialities;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? serviceName;
  String? serviceDescrption;
  String? serviceCat;
  String? speciality;
  late Speciality sp;
  // ignore: non_constant_identifier_names
  String? conform_password;
  bool remember = false;
  final List<String?> errors = [];

  late Client client;
  @override
  void initState() {
    super.initState();

    CategoryApi.getCategories().then((mcategories) {
      _specialities = [];
      _categories = mcategories;
      for (var cat in mcategories) {
        categories.add(cat.name!);
        /* specialities.add(cat.specialities
            .map((e) => Speciality(id: e.id, name: e.name))
            .toList());
        _category = Category(
            id: cat.id,
            name: cat.name,
            image: cat.image,
            specialities: cat.specialities
                .map((e) =>
                    Speciality(id: e.id, name: e.name, categoryId: cat.id))
                .toList());*/

        /*List<Speciality>.from(cat.specialities
                .map((e) => Speciality(id: e.id, name: e.name))).toList());*/

      }
      debugPrint(categories.toString());
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  var currentStep = 0;
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
              ),
              const Text("A few steps and we start"),
              Stepper(
                steps: getSteps(),
                currentStep: currentStep,
                onStepContinue: () {
                  final isLastStep = currentStep == getSteps().length - 1;
                  if (currentStep == 1) {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        currentStep += 1;
                      }
                    });
                  } else if (isLastStep) {
                    setState(() {
                      debugPrint("$_value");
                      register();
                    });
                  } else {
                    setState(() => currentStep += 1);
                  }
                },
                //onStepTapped: (step) => setState(() => currentStep = step),
                onStepCancel: currentStep == 0
                    ? null
                    : () => setState(() => currentStep -= 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: const Text("Account"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.deepPurple),
                        value: 1,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value as int;
                          });
                        }),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text("Client"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.deepPurple),
                        value: 2,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value as int;
                          });
                        }),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text("professional"),
                  ],
                )
              ],
            ),
            isActive: currentStep >= 0),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            title: const Text("Iformations"),
            content: Column(children: [
              basicForm(),
            ]),
            isActive: currentStep >= 1),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            title: const Text("Complete"),
            content: resumeUserInformations(),
            isActive: currentStep >= 2)
      ];

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        suffixIcon: const Icon(Icons.mail),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        suffixIcon: const Icon(Icons.person),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        suffixIcon: const Icon(Icons.person),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        suffixIcon: const Icon(Icons.phone),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        suffixIcon: const Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        suffixIcon: const Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildServiceTitleFormField() {
    return TextFormField(
      onSaved: (newValue) => serviceName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kSNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kSNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Service Title",
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        suffixIcon: const Icon(Icons.person),
      ),
    );
  }

  TextFormField buildServiceDescriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      onSaved: (newValue) => serviceDescrption = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kSDesclNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kSDesclNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Service Description",
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        suffixIcon: const Icon(Icons.person),
      ),
    );
  }

  basicForm() {
    switch (_value) {
      case 2:
        return Form(
          key: _formKey,
          child: Column(
            children: [
              buildEmailFormField(),
              const SizedBox(height: 30),
              buildFirstNameFormField(),
              const SizedBox(height: 30),
              buildLastNameFormField(),
              const SizedBox(height: 30),
              buildPhoneNumberFormField(),
              const SizedBox(height: 30),
              buildPasswordFormField(),
              const SizedBox(height: 30),
              buildConformPassFormField(),
              const SizedBox(height: 30),
              buildServiceTitleFormField(),
              const SizedBox(height: 30),
              buildServiceDescriptionFormField(),
              const SizedBox(height: 30),
              categoriesDropDownButton(),
              const SizedBox(height: 30),
              specialitiesDropDownButton(),
              FormError(errors: errors),
              const SizedBox(height: 30),
            ],
          ),
        );

      default:
        return Form(
          key: _formKey,
          child: Column(
            children: [
              buildEmailFormField(),
              const SizedBox(height: 30),
              buildFirstNameFormField(),
              const SizedBox(height: 30),
              buildLastNameFormField(),
              const SizedBox(height: 30),
              buildPhoneNumberFormField(),
              const SizedBox(height: 30),
              buildPasswordFormField(),
              const SizedBox(height: 30),
              buildConformPassFormField(),
              FormError(errors: errors),
              const SizedBox(height: 30),
            ],
          ),
        );
    }
  }

  DropdownButtonFormField<String> categoriesDropDownButton() {
    return DropdownButtonFormField<String>(
      items: categories.map(buildMenuItem).toList(),
      value: catSelectedItem,
      onTap: () => setState(() {
        removeError(error: kSCatNullError);
      }),
      onChanged: (value) {
        setState(() {
          catSelectedItem = value;
          getSpecialitiesByCat(catSelectedItem!);

          debugPrint('$catSelectedItem');
        });
      },
      validator: (value) {
        if (value == null) {
          addError(error: kSCatNullError);
        }
      },
      isExpanded: true,
      hint: const Text(
        "Chose your service category",
      ),
      onSaved: (newValue) => serviceCat = newValue,
    );
  }

  DropdownButtonFormField<String> specialitiesDropDownButton() {
    return DropdownButtonFormField(
      items: _specialities.map(buildSMenuItem).toList(),
      value: speSelectedItem,
      onTap: () => setState(() {
        removeError(error: kSSpecNullError);
      }),
      onChanged: (value) {
        setState(() {
          speSelectedItem = value;
          getSpecialitiesByCat(speSelectedItem!);

          debugPrint('$speSelectedItem');
        });
      },
      validator: (value) {
        if (value == null) {
          addError(error: kSSpecNullError);
        }
      },
      isExpanded: true,
      hint: const Text(
        "Chose your Speciality",
      ),
      onSaved: (newValue) => speciality = newValue,
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
  DropdownMenuItem<String> buildSMenuItem(Speciality item) => DropdownMenuItem(
        value: item.name,
        child: Text(item.name!),
      );
  getSpecialitiesByCat(String catName) {
    for (var cat in _categories) {
      if (cat.name == catName) {
        _specialities = cat.specialities!;
      }
    }
    debugPrint(_specialities.toString());
  }

  getSpecialitySelected() {
    for (var sp in _specialities) {
      if (sp.name == speciality) {
        debugPrint(" ye broooo");
        debugPrint(sp.toString());

        return Speciality(id: sp.id, name: sp.name);
      }
    }
  }

  resumeUserInformations() {
    switch (_value) {
      case 2:
        return Column(
          children: [
            ListTile(
              title: const Text('Email'),
              subtitle: Text('$email'),
            ),
            ListTile(
              title: const Text('FirstName'),
              subtitle: Text('$firstName'),
            ),
            ListTile(
              title: const Text('LastName'),
              subtitle: Text('$lastName'),
            ),
            ListTile(
              title: const Text('Phone Number'),
              subtitle: Text('$phoneNumber'),
            ),
            ListTile(
              title: const Text('Service title'),
              subtitle: Text('$serviceName'),
            ),
            ListTile(
              title: const Text('Service Description'),
              subtitle: Text('$serviceDescrption'),
            ),
            ListTile(
              title: const Text('Service Category'),
              subtitle: Text('$serviceCat'),
            ),
            ListTile(
              title: const Text('Speciality'),
              subtitle: Text('$speciality'),
            ),
          ],
        );

      default:
        return Column(
          children: [
            ListTile(
              title: const Text('Email'),
              subtitle: Text('$email'),
            ),
            ListTile(
              title: const Text('FirstName'),
              subtitle: Text('$firstName'),
            ),
            ListTile(
              title: const Text('LastName'),
              subtitle: Text('$lastName'),
            ),
            ListTile(
              title: const Text('Phone Number'),
              subtitle: Text('$phoneNumber'),
            ),
          ],
        );
    }
  }

  register() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    if (_value == 1) {
      client = Client(
          pwd: password!,
          email: email!,
          firstName: firstName!,
          lastName: lastName!,
          phoneNumber: phoneNumber!);
      await ClientPreferences.setClient(client);

      ClientApi.register(client).then((value) {
        if (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SignInScreen(email: email!, password: password!)),
          );
        } else {
          SnackBar snackBar = const SnackBar(
            content: Text("Please try again !"),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } else {
      debugPrint(getSpecialitySelected().toString());

      var service = Service(
          password: password!,
          email: email!,
          firstName: firstName!,
          lastName: lastName!,
          phoneNumber: phoneNumber!,
          title: serviceName!,
          speciality: getSpecialitySelected()!,
          description: serviceDescrption!);

      ServiceApi.register(service).then((value) {
        if (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SignInScreen(email: email!, password: password!)),
          );
        } else {
          SnackBar snackBar = const SnackBar(
            content: Text("Please try again !"),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }
}
