import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/entities/category.dart';
import 'package:market_place_flutter_app/entities/speciality.dart';
import 'package:market_place_flutter_app/models/service.dart';

import 'service_card.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late int _selectedIndex;
  late int _selectedSpeciality;
  List<Speciality> services = [];

  @override
  void initState() {
    super.initState();
    debugPrint("okhtchiiiiiiiiii'");

    _tabController =
        TabController(length: widget.category.specialities.length, vsync: this);
    _selectedIndex = 0;
    services.addAll(widget.category.specialities);
    _selectedSpeciality = services[_selectedIndex + 1].id;
    debugPrint('init : $_selectedSpeciality');

    tabListener();
  }

  @override
  Widget build(BuildContext context) {
    var cname = widget.category.name;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 230,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(50)),
                color: Colors.deepPurple),
            child: Stack(
              children: [
                Positioned(
                    top: 80,
                    left: 0,
                    child: Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50)),
                            color: Theme.of(context).cardColor))),
                Positioned(
                  top: 104,
                  left: 0.5,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    //   ),
                  ),
                ),
                Positioned(
                  top: 110,
                  left: 40,
                  child: Text('$cname Category',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
          ),
          specialitesSlider(),
        ],
      ),
    );
  }

  specialitesSlider() {
    return Expanded(
        //height: 500,
        child: ListView(
      padding: const EdgeInsets.only(left: 20.0),
      children: <Widget>[
        const SizedBox(height: 15.0),
        const SizedBox(height: 15.0),
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: Colors.deepPurple,
          isScrollable: true,
          labelPadding: const EdgeInsets.only(right: 45.0),
          unselectedLabelColor: const Color(0xFFCDCDCD),
          tabs: getTabs(),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height - 50.0,
            width: double.infinity,
            child: TabBarView(controller: _tabController, children: [
              for (var i = 0; i < _tabController.length; i++)
                ServiceCard(id: _selectedSpeciality),
            ]))
      ],
    ));
  }

  getTabs() {
    List<Tab> tabs = [];

    for (var speciality in widget.category.specialities) {
      services.add(speciality);
      tabs.add(
        Tab(
          child: Text(
            speciality.name,
            style: const TextStyle(
              fontFamily: 'Varela',
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }

    return tabs;
  }

  tabListener() {
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        _selectedSpeciality = services[_selectedIndex + 1].id;
        debugPrint('set : $_selectedSpeciality');
      });
    });
  }
}
