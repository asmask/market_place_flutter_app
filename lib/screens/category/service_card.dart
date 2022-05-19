import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/models/speciality.dart';

class ServiceCard extends StatefulWidget {
  final int id;
  const ServiceCard({Key? key, required this.id}) : super(key: key);

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  void initState() {
    super.initState();
    debugPrint("id" + widget.id.toString());
    getServices(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 15.0),
          Container(
              padding: const EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard('50417431-Sousse', 'Asma Skhiri',
                      'assets/cookiemint.jpg', false, false, context),
                  _buildCard('Cookie cream', '\$5.99', 'assets/cookiecream.jpg',
                      true, false, context),
                  _buildCard('Cookie classic', '\$1.99',
                      'assets/cookieclassic.jpg', false, true, context),
                  _buildCard('Cookie choco', '\$2.99', 'assets/cookiechoco.jpg',
                      false, false, context)
                ],
              )),
          const SizedBox(height: 15.0)
        ],
      ),
    );
  }

  Widget _buildCard(String name, String price, String imgPath, bool added,
      bool isFavorite, context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              /*Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CookieDetail(
                      assetPath: imgPath,
                      cookieprice: price,
                      cookiename: name)));*/
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  //color: Colors.white
                ),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isFavorite
                                ? const Icon(Icons.favorite,
                                    color: Colors.deepPurple)
                                : const Icon(Icons.favorite_border,
                                    color: Colors.deepPurple)
                          ])),
                  Hero(
                      tag: imgPath,
                      child: Container(
                          height: 75.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.contain)))),
                  const SizedBox(height: 7.0),
                  Text(price,
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontFamily: 'Varela',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  Text(name,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: const Color(0xFFEBEBEB), height: 1.0)),
                  Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (!added) ...[
                              const Icon(Icons.shopping_basket,
                                  color: Colors.deepPurple, size: 12.0),
                              const Text('Add to cart',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: Colors.deepPurple,
                                      fontSize: 12.0))
                            ],
                            if (added) ...[
                              const Icon(Icons.remove_circle_outline,
                                  color: Colors.deepPurple, size: 12.0),
                              const Text('3',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0)),
                              const Icon(Icons.add_circle_outline,
                                  color: Colors.deepPurple, size: 12.0),
                            ]
                          ]))
                ]))));
  }

  getServices(int id) async {
    var services = await SpecialityApi.getSpecialitiesById(id);
    for (var service in services) {
      debugPrint(service.lastName);
    }
  }
}
