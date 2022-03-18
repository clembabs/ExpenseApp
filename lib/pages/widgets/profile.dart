import 'package:flutter/material.dart';
import 'package:hiveproject/model/profile.dart';
import 'package:hiveproject/pages/widgets/appbar_widget.dart';

class ViewProfile extends StatefulWidget {
  final Profile user;

  const ViewProfile({Key? key, required this.user}) : super(key: key);
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // ProfileWidget(
          //   imagePath: user.imagePath,
          //   onClicked: () async {},
          // ),
          const SizedBox(height: 24),
          buildName(widget.user),
          const SizedBox(height: 24),
          buildAbout(widget.user),
        ],
      ),
    );
  }

  Widget buildName(Profile user) => Column(
        children: [
          Text(
            user.firstName + ' ' + user.lastName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
        ],
      );

  Widget buildAbout(Profile user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.occupation,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
