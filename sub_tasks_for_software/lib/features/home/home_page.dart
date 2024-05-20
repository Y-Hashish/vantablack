import 'package:flutter/material.dart';
import 'package:frist_pages/aboutus.dart';
import 'package:frist_pages/contactus.dart';
import 'package:frist_pages/features/menuItem/view/menuPage.dart';
import 'package:frist_pages/login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var backC = const Color.fromARGB(255, 237, 237, 237);

    return Scaffold(
      backgroundColor: backC,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          "Ratatouille",
          style: TextStyle(color: Color.fromARGB(255, 95, 94, 94)),
        ),
        backgroundColor: backC,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: backC,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text('Food Menu'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_phone),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Log out'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ratatouille",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "We are special in almost every thing",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/images/photo_2024-05-15_18-00-24.jpg",
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 25, left: 25),
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Food Menu",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (v) {
                        return MyApp();
                      }));
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/images/ChickenAlfredo.jpg",
                            width: 100,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text(
                        "ChickenAlfredo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.all(10),
                  //  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/images/Bruschetta.jpg",
                            width: 100,
                            height: 75,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text(
                        "Bruschetta",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.all(10),
                  //  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/images/calamari.jpg",
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text(
                        "Calamari",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: const Text(
                  "Popular",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (v) {
                    return MyApp();
                  }));
                },
                child: const Text(
                  "See all",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                      margin: const EdgeInsets.all(10),
                      height: 250,
                      padding: const EdgeInsets.all(10),
                      //  margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/images/p2.jpg",
                                width: 120,
                                height: 100,
                              ),
                            ),
                          ),
                          const Text(
                            "Ratatouille",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text("According to an odd family member",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("21\$    ",
                                  style: TextStyle(color: Colors.grey)),
                              Text("4.4"),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 12,
                              )
                            ],
                          )
                        ],
                      )),
                ],
              ),
              Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      //  margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/Tiramisu.jpg",
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("21\$    ",
                                  style: TextStyle(color: Colors.grey)),
                              Text("4.4"),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 12,
                              )
                            ],
                          )
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/SteakFlorentine.jpg",
                              width: 90,
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("21\$    ",
                                  style: TextStyle(color: Colors.grey)),
                              Text("4.4"),
                              Icon(
                                color: Colors.yellow,
                                Icons.star,
                                size: 12,
                              )
                            ],
                          )
                        ],
                      ))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),

          // Container(
          //   decoration: BoxDecoration(
          //       color: Colors.white, borderRadius: BorderRadius.circular(15)),
          //   margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
          //   padding: const EdgeInsets.all(25),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text(
          //         "You can get a 20% descount !",
          //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          //       ),
          //       Container(
          //         decoration: BoxDecoration(
          //             color: backC, borderRadius: BorderRadius.circular(10)),
          //         padding: EdgeInsets.all(7.5),
          //         child: const Text(
          //           "Get Now!",
          //           style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //     height: 300,
          //     child: Expanded(
          //         child: ListView.builder(
          //             scrollDirection: Axis.horizontal,
          //             itemCount: foodtitle.length,
          //             itemBuilder: (context, index) =>
          //                 menu(food: foodtitle[index]))))
        ],
      ),
    );
  }
}
