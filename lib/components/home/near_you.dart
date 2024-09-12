import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard({Key ? key,required this.img, required this.name, required this.location, required this.p_id}) : super(key: key);
  final String img;
  final String name;
  final String location;
  final String p_id;
  @override
  State<PlaceCard> createState() => _Chi();
}

class _Chi extends State<PlaceCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 260,
        height: 270,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              width: 260,
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    '${widget.img}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4, right: 10, left: 10),
              child: Text(
                '${widget.name}',
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          IconlyBold.location,
                          color: Colors.red,
                          size: 16,
                        ),
                        Text(
                          ' ${widget.location}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
