import 'package:flutter/material.dart';
import 'package:cgcflutter/CartScreen.dart';

class IceCreamDetailScreen extends StatefulWidget {
  final String name;
  final String price;
  final String emoji;

  const IceCreamDetailScreen({
    super.key,
    required this.name,
    required this.price,
    required this.emoji,
  });

  @override
  State<IceCreamDetailScreen> createState() =>
      _IceCreamDetailScreenState();
}

class _IceCreamDetailScreenState
    extends State<IceCreamDetailScreen> {

  String container = "Cone";
  String topping = "Chocolate";
  int scoops = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFE9F2),

      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(widget.name),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(

          children: [

            Text(
              widget.emoji,
              style: TextStyle(fontSize: 100),
            ),

            SizedBox(height: 15),

            Text(
              widget.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              widget.price,
              style: TextStyle(
                color: Colors.pink,
                fontSize: 22,
              ),
            ),

            SizedBox(height: 25),

            DropdownButtonFormField<String>(
              value: container,
              decoration: InputDecoration(
                labelText: "Container",
              ),
              items: [
                "Cone",
                "Cup",
                "Waffle Cone"
              ].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  container = value!;
                });
              },
            ),

            SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: topping,
              decoration: InputDecoration(
                labelText: "Topping",
              ),
              items: [
                "Chocolate",
                "Sprinkles",
                "Oreo",
                "Nuts"
              ].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  topping = value!;
                });
              },
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                Text(
                  "Scoops",
                  style: TextStyle(fontSize: 20),
                ),

                Row(
                  children: [

                    IconButton(
                      onPressed: () {
                        if (scoops > 1) {
                          setState(() {
                            scoops--;
                          });
                        }
                      },
                      icon: Icon(Icons.remove_circle),
                    ),

                    Text(
                      "$scoops",
                      style: TextStyle(fontSize: 22),
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          scoops++;
                        });
                      },
                      icon: Icon(Icons.add_circle),
                    ),
                  ],
                ),
              ],
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),

                onPressed: () {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    SnackBar(
                      content:
                      Text("Added to Cart"),
                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },

                child: Text(
                  "Add To Cart",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}