import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/user_api.dart';
import '../views/admin/home.dart';
import '../views/admin/login.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String url =
      'https://www.google.com/search?q=red+circle&rlz=1C1GCEA_enMA849MA849&sxsrf=ALiCzsZ6sy6ISWSjSGOfU75GZQ9Z9auEUg:1659366319489&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiIk5mg9aX5AhXliv0HHQfQAG8Q_AUoAXoECAIQAw&biw=1396&bih=656&dpr=1.38#imgrc=VUIh3VlvGIA0cM';

  @override
  void initState() {
    super.initState();
    var firebaseUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xfff2f9fc),
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Material(
            color: Color(0xfff2f9fc),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
              child: Column(
                children: [
                  headerWidget(),
                  const SizedBox(
                    height: 40,
                  ),
                  Divider(
                    thickness: 1,
                    height: 10,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ListTile(
                    title: Text(
                      'Find a Place',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    leading: Icon(
                      Icons.archive,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      onItemPressed(context, index: 1);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    title: Text(
                      'History',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    leading: Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      onItemPressed(context, index: 2);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    title: Text(
                      'Log Out',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    leading: Icon(
                      Icons.settings,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      onItemPressed(context, index: 3);
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  //const Divider(thickness: 1, height: 10, color: Colors.grey,),
                  //const SizedBox(height: 30,),
                  //  const SizedBox(height: 70,),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    final FirebaseAuth auth = FirebaseAuth.instance;

    switch (index) {
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeAdmin()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeAdmin()));
        break;
      case 3:
        UserAPI userAPI = UserAPI(auth: auth);
        userAPI.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (context) => new LoginAdmin()),
                (route) => false);
        break;
    }
  }

  Widget headerWidget() {
    late String? email = '';
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;
    final uid = user?.uid;
    email = user?.email;

    return GestureDetector(
      onTap: null,
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(url),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(email!, style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400),)
            ],
          )
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
        required this.name,
        required this.icon,
        required this.onPressed})
      : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(
              width: 40,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}