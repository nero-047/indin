import 'dart:ui';
import 'package:demoapp/components/home/near_you.dart';
import 'package:demoapp/screens/jatin/page.dart';
import 'package:demoapp/screens/map/page.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

enum _SelectedTab { home, favorite, add, search, person }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Chi();
}

class _Chi extends State<Home> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
    print(_selectedTab);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.brown.shade100,
        appBar: AppBar(
          title: const Text(
            'IndIn',
            style: TextStyle(color: Colors.white54),
          ),
          backgroundColor: Colors.brown.shade500,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(IconlyLight.message),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(IconlyLight.chat),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(IconlyLight.calendar),
              color: Colors.white,
            ),
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 6, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Near by you',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          'more',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 81, 167, 237)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        PlaceCard(
                          img:
                              'https://imgs.search.brave.com/8poHpjMSk4yjT2YlkEuB5EeJAxxwmeNH7Bls5PXzSRY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cm9hZGFmZmFpci5j/b20vd3AtY29udGVu/dC91cGxvYWRzLzIw/MTcvMTIvYWNyb3Bv/bGlzLWF0aGVucy1n/cmVlY2Utc2h1dHRl/cnN0b2NrXzUyMzk3/NTk3OC5qcGc',
                          name: 'Falana naam of faalana place',
                          location: 'location, city',
                          p_id: '',
                        ),
                        PlaceCard(
                          img:
                              'https://imgs.search.brave.com/8poHpjMSk4yjT2YlkEuB5EeJAxxwmeNH7Bls5PXzSRY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cm9hZGFmZmFpci5j/b20vd3AtY29udGVu/dC91cGxvYWRzLzIw/MTcvMTIvYWNyb3Bv/bGlzLWF0aGVucy1n/cmVlY2Utc2h1dHRl/cnN0b2NrXzUyMzk3/NTk3OC5qcGc',
                          name: 'Falana naam of faalana place',
                          location: 'location, city',
                          p_id: '',
                        ),
                        PlaceCard(
                          img:
                              'https://imgs.search.brave.com/8poHpjMSk4yjT2YlkEuB5EeJAxxwmeNH7Bls5PXzSRY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cm9hZGFmZmFpci5j/b20vd3AtY29udGVu/dC91cGxvYWRzLzIw/MTcvMTIvYWNyb3Bv/bGlzLWF0aGVucy1n/cmVlY2Utc2h1dHRl/cnN0b2NrXzUyMzk3/NTk3OC5qcGc',
                          name: 'Falana naam of faalana place',
                          location: 'location, city',
                          p_id: '',
                        ),
                        PlaceCard(
                          img:
                              'https://imgs.search.brave.com/8poHpjMSk4yjT2YlkEuB5EeJAxxwmeNH7Bls5PXzSRY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cm9hZGFmZmFpci5j/b20vd3AtY29udGVu/dC91cGxvYWRzLzIw/MTcvMTIvYWNyb3Bv/bGlzLWF0aGVucy1n/cmVlY2Utc2h1dHRl/cnN0b2NrXzUyMzk3/NTk3OC5qcGc',
                          name: 'Falana naam of faalana place',
                          location: 'location, city',
                          p_id: '',
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Explore through clips',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          'more',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 81, 167, 237)),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 140,
                          height: 220,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.purpleAccent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'https://imgs.search.brave.com/VhGg_NBzX-bMIEFyvJdPsQoxmsGKDlVvZa9CyE0TOpo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NDFqM3hIcmZZVUwu/anBn',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 140,
                          height: 220,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.purpleAccent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'https://imgs.search.brave.com/VhGg_NBzX-bMIEFyvJdPsQoxmsGKDlVvZa9CyE0TOpo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NDFqM3hIcmZZVUwu/anBn',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 140,
                          height: 220,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.purpleAccent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'https://imgs.search.brave.com/VhGg_NBzX-bMIEFyvJdPsQoxmsGKDlVvZa9CyE0TOpo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NDFqM3hIcmZZVUwu/anBn',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(minHeight: 100),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.green,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 68,
                          constraints: BoxConstraints(minHeight: 100),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        ' User name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        ' @username',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Text('7hrs')
                                ],
                              ),
                              Text(
                                "asdfghjk werty asdfghj xcvbnm wertyui sdfgh cvbnm ertyuil dfghjk ertyuio xcvbnm sdfghjk wertyui sdfghjk xcvbnm, wertyui zxcvbnm sdfghj asdfghjk werty asdfghj xcvbnm wertyui sdfgh cvbnm ertyuil dfghjk ertyuio xcvbnm sdfghjk wertyui sdfghjk xcvbnm, wertyui zxcvbnm sdfghj asdfghjk werty asdfghj xcvbnm wertyui sdfgh cvbnm ertyuil dfghjk ertyuio xcvbnm sdfghjk wertyui sdfghjk xcvbnm, wertyui zxcvbnm sdfghj",
                                style: TextStyle(),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width - 68,
                                constraints: BoxConstraints(minHeight: 180),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://imgs.search.brave.com/8poHpjMSk4yjT2YlkEuB5EeJAxxwmeNH7Bls5PXzSRY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cm9hZGFmZmFpci5j/b20vd3AtY29udGVu/dC91cGxvYWRzLzIw/MTcvMTIvYWNyb3Bv/bGlzLWF0aGVucy1n/cmVlY2Utc2h1dHRl/cnN0b2NrXzUyMzk3/NTk3OC5qcGc',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(IconlyBold.heart),
                                        Text('80k')
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(IconlyBold.chat),
                                        Text('7.4k')
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(IconlyBold.show),
                                        Text('19k')
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(Icons.ios_share),
                                        Text('19k')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(minHeight: 100),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.green,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 68,
                          constraints: BoxConstraints(minHeight: 100),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        ' User name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        ' @username',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Text('7hrs')
                                ],
                              ),
                              Text(
                                "asdfghjk werty asdfghj xcvbnm wertyui sdfgh cvbnm ertyuil dfghjk ertyuio xcvbnm sdfghjk wertyui sdfghjk xcvbnm, wertyui zxcvbnm sdfghj asdfghjk werty asdfghj xcvbnm wertyui sdfgh cvbnm ertyuil dfghjk ertyuio xcvbnm sdfghjk wertyui sdfghjk xcvbnm, wertyui zxcvbnm sdfghj asdfghjk werty asdfghj xcvbnm wertyui sdfgh cvbnm ertyuil dfghjk ertyuio xcvbnm sdfghjk wertyui sdfghjk xcvbnm, wertyui zxcvbnm sdfghj",
                                style: TextStyle(),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width - 68,
                                constraints: BoxConstraints(minHeight: 180),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://imgs.search.brave.com/8poHpjMSk4yjT2YlkEuB5EeJAxxwmeNH7Bls5PXzSRY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cm9hZGFmZmFpci5j/b20vd3AtY29udGVu/dC91cGxvYWRzLzIw/MTcvMTIvYWNyb3Bv/bGlzLWF0aGVucy1n/cmVlY2Utc2h1dHRl/cnN0b2NrXzUyMzk3/NTk3OC5qcGc',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(IconlyBold.heart),
                                        Text('80k')
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(IconlyBold.chat),
                                        Text('7.4k')
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(IconlyBold.show),
                                        Text('19k')
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(Icons.ios_share),
                                        Text('19k')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 40, right: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                22), // Ensure the blur doesn't leak outside the border
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 10.0, sigmaY: 10.0), // Apply blur effect
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                  color:
                      Colors.black.withOpacity(0.3), // Semi-transparent color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      },
                      icon: Icon(IconlyBold.home),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyMap()));
                      },
                      icon: Icon(Icons.map_outlined),
                      color: Colors.white,
                    ),
                    SizedBox(width: 40), // Space for the FloatingActionButton
                    IconButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> const ))
                      },
                      icon: Icon(Icons.local_mall_outlined),
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: Icon(Icons.more_horiz),
                      color: Colors.white,
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 400,
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Jatin(),
              ),
            );
          },
          child: Icon(Icons.smart_toy),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked, // Use centerDocked
      ),
    );
  }
}
