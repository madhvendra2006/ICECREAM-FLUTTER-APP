import 'package:flutter/material.dart';
import 'package:cgcflutter/IceCreamDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> iceCreams = [
    {
      "name": "Chocolate",
      "price": "₹120",
      "emoji": "🍫",
      "icon": Icons.icecream,
      "color": Colors.brown,
    },
    {
      "name": "Mango",
      "price": "₹110",
      "emoji": "🥭",
      "icon": Icons.icecream,
      "color": Colors.orange,
    },
    {
      "name": "Vanilla",
      "price": "₹90",
      "emoji": "🍦",
      "icon": Icons.icecream,
      "color": Colors.amber,
    },
    {
      "name": "Strawberry",
      "price": "₹130",
      "emoji": "🍓",
      "icon": Icons.icecream,
      "color": Colors.pink,
    },
    {
      "name": "Butterscotch",
      "price": "₹125",
      "emoji": "🍯",
      "icon": Icons.icecream,
      "color": Colors.deepOrange,
    },
    {
      "name": "Black Currant",
      "price": "₹140",
      "emoji": "🫐",
      "icon": Icons.icecream,
      "color": Colors.purple,
    },
  ];
  List<Map<String, dynamic>> filteredIceCreams = [];

  @override
  void initState() {
    super.initState();
    filteredIceCreams = iceCreams;
  }

  void searchIceCream(String value) {
    setState(() {
      filteredIceCreams = iceCreams
          .where((item) => item["name"]
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF3F7),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pink,
        title: const Text(
          "Sweet Cream",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "🍦 Welcome!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Choose your favourite ice cream",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              onChanged: searchIceCream,
              decoration: InputDecoration(
                hintText: "Search Ice Cream...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Flavours",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: GridView.builder(
                itemCount: filteredIceCreams.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final item = filteredIceCreams[index];

                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {},

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          CircleAvatar(
                            radius: 35,
                            backgroundColor:
                            item["color"].withOpacity(0.15),
                            child: Icon(
                              item["icon"],
                              color: item["color"],
                              size: 40,
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text(
                            item["name"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IceCreamDetailScreen(
                                    name: item["name"],
                                    price: item["price"],
                                    emoji: item["emoji"],
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "View",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}