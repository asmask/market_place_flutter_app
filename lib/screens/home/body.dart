import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:market_place_flutter_app/entities/category.dart';
import 'package:market_place_flutter_app/entities/serv.dart';
import 'package:market_place_flutter_app/provider/constants.dart';
import 'package:market_place_flutter_app/screens/category/category_screen.dart';
import 'package:market_place_flutter_app/screens/introduction/loading_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;

  List<Category> _categories = [];
  @override
  void initState() {
    super.initState();
    mcategories.toList();
    getCategories();
  }

  @override
  Widget build(BuildContext context) => isLoading
      ? const LoadingScreen()
      : Scaffold(
          body: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  searchBar(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  categoriesSlide(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  appseeAll(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  NoAppointmentCard(
                    onTap: onPressedScheduleCard,
                  ),
                ],
              )
            ],
          ),
        );

  searchBar() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TypeAheadField<Service?>(
          hideSuggestionsOnKeyboardHide: false,
          debounceDuration: const Duration(milliseconds: 500),
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey[400],
              ),
              hintText: 'speciality,title,name...',
              hintStyle: TextStyle(letterSpacing: 1, color: Colors.grey[400]),
              filled: true,
              suffixIcon: Icon(Icons.tune_sharp, color: Colors.grey[400]),
            ),
          ),
          suggestionsCallback: (pattern) async {
            return ServiceApi.getServiceSuggestions(pattern);
          },
          itemBuilder: (context, Service? suggestion) {
            final service = suggestion!;
            var fname = service.firstName;
            var lname = service.lastName;
            return ListTile(
              title: Text('$fname $lname'),
            );
          },

          //hideOnError: true,
          noItemsFoundBuilder: (context) => Container(
            height: 50,
            child: const Text(
              'No Services Found.',
              style: TextStyle(fontSize: 15),
            ),
          ),
          onSuggestionSelected: (Service? suggestion) {
            /*final service = suggestion!;
            Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ServiceDetailScreen(service: service)));*/
          },
        ),
      ),
    );
  }

  categoriesSlide() {
    return SafeArea(
      child: Container(
        height: 130,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  var category = Category(
                      id: _categories[index].id,
                      name: _categories[index].name,
                      image: _categories[index].image,
                      specialities: _categories[index].specialities);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CategoryScreen(category: category)));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                          //boxShadow: shadowList,
                        ),
                        child: Image.network(
                          _categories[index].image,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        _categories[index].name,
                        textAlign: TextAlign.center,
                        /*style: TextStyle(
                          color: Colors.grey[700],
                        ),*/
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  getCategories() async {
    setState(() => isLoading = true);
    _categories = await CategoryApi.getCategories();

    debugPrint('catttt $_categories');
    setState(() => isLoading = false);
  }

  appseeAll() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Appointment Today',
            style: TextStyle(
              //color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            child: const Text(
              'See All',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  void onPressedScheduleCard() {}
}

class AppointmentCard extends StatelessWidget {
  final void Function() onTap;

  const AppointmentCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('images/user_avatar.jpeg'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Dr.Muhammed Syahid',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Dental Specialist',
                                  style: TextStyle(color: Color(0xffbec2fc)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const ScheduleCard(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 10,
              decoration: const BoxDecoration(
                color: Color(0xffc3c5f8),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              height: 10,
              decoration: const BoxDecoration(
                color: Color(0xffe8eafe),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Mon, July 29',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '11:00 ~ 12:10',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class NoAppointmentCard extends StatelessWidget {
  final void Function() onTap;

  const NoAppointmentCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'Agne',
                              color: Colors.white),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                  'There is no appointments for today!'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 10,
              decoration: const BoxDecoration(
                color: Color(0xffc3c5f8),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
