import 'package:flutter/material.dart';
import 'package:smart_parking/views/admin/add_driver.dart';
import 'package:smart_parking/views/admin/parking.dart';
import '../../componants/floating_button.dart';
import '../../componants/side_menu.dart';
import 'package:flutter/painting.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Home",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.person_rounded,
                  color: Theme.of(context).colorScheme.primary, // Changing Drawer Icon Size
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),

        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Stats(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available Places',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        child: TextButton(
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AddDriver())),
                          child: Text(
                            'Add Driver',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Container(
                      child: ParkingSchema(availability: [true, false, true, true, false]),
                    ),
                  ),
                                  ]),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingButton()

    );
  }
}


