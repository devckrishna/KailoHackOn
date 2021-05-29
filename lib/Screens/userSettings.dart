import 'package:flutter/material.dart';
import 'package:kailo/Screens/viewUserSettings.dart';
import 'package:kailo/utils/constants.dart';

import 'myHealth.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  userSettingsOrHealth selectedSettingType = userSettingsOrHealth.profile;
  PageController _userSettingsPageController = new PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
              padding: EdgeInsets.all(3.0),
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _userSettingsPageController.animateToPage(0,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
                        selectedSettingType = userSettingsOrHealth.profile;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 14),
                      width: MediaQuery.of(context).size.width / 2.3,
                      decoration: BoxDecoration(
                          color: selectedSettingType ==
                                  userSettingsOrHealth.profile
                              ? Colors.deepPurple.shade800
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Center(
                        child: Text(
                          'Profile',
                          style: ktextStyle().copyWith(
                              color: selectedSettingType ==
                                      userSettingsOrHealth.profile
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _userSettingsPageController.animateToPage(1,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
                        selectedSettingType = userSettingsOrHealth.health;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.3,
                      decoration: BoxDecoration(
                          color:
                              selectedSettingType == userSettingsOrHealth.health
                                  ? Colors.deepPurple.shade800
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Center(
                          child: Text(
                        'My Health',
                        style: ktextStyle().copyWith(
                            color: selectedSettingType ==
                                    userSettingsOrHealth.health
                                ? Colors.white
                                : Colors.black),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _userSettingsPageController,
              children: [ViewUserSettings(), MyHealth()],
            ),
          ),
        ],
      ),
    );
  }
}
