import 'package:association_appli/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class MembersRoundedStatusWidget extends StatelessWidget {
  const MembersRoundedStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
      child: Column(
        children: [
          _headerWidget(),
          SizedBox(height: 24.0),

          Row(
            children: [
              _roundTypeMembers(
                image: 'assets/icons/chat.png',
                mStatus: 'Novices',
                onTap: null,
              ),
              SizedBox(width: 24.0),
              _roundTypeMembers(
                image: 'assets/icons/chat.png',
                mStatus: 'Novices',
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),

              SizedBox(width: 24.0),
              _roundTypeMembers(
                image: 'assets/icons/chat.png',
                mStatus: 'Novices',
                onTap: null,
              ),

              SizedBox(width: 24.0),
              _roundTypeMembers(
                image: 'image',
                mStatus: 'Novices',
                onTap: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _roundTypeMembers({
  required String image,
  required String mStatus,
  required VoidCallback? onTap,
}) {
  return Center(
    child: Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Center(child: Image.asset(image)),
          ),
        ),
        Text(mStatus),
      ],
    ),
  );
}

Widget _headerWidget() {
  return Row(
    children: [
      Text(
        'Categories',
        style: TextStyle(fontSize: 20.0, color: Colors.black12),
      ),
      SizedBox(width: 100.0),
      ElevatedButton(onPressed: () {}, child: Icon(Icons.add)),
    ],
  );
}
