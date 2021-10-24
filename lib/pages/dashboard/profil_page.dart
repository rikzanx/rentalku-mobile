import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/app_provider.dart';

class DashboardProfilPage extends StatelessWidget {
  const DashboardProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            title: Text(
              "Profil",
              style: AppStyle.title3Text.copyWith(
                color: AppColor.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                splashRadius: 24,
                icon: Image.asset('assets/images/chat_icon.png', height: 24),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.chats);
                },
              )
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              SizedBox(width: 16),
              CircleAvatar(
                backgroundImage:
                    NetworkImage("https://lorempixel.com/200/200/people/"),
                radius: 24,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo,",
                      style: AppStyle.regular1Text,
                    ),
                    Text(
                      "Muhammad",
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: AppStyle.regular1Text.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              InkWell(
                child: Text(
                  "Jadi Pemilik Mobil  >",
                  style: AppStyle.smallText.copyWith(
                    color: AppColor.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(width: 16),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.green,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Consumer<AppProvider>(
                  builder: (context, state, _) => Text(
                    state.isUser
                        ? "Saya Penyewa"
                        : state.isOwner
                            ? "Saya Pemilik Mobil"
                            : "Saya Sopir",
                    style: AppStyle.smallText.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            horizontalTitleGap: 0,
            visualDensity: VisualDensity.compact,
            title: Text(
              'Data Diri',
              style: AppStyle.regular1Text,
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.myProfile);
            },
          ),
          ListTile(
            leading: Icon(Icons.lock_outline),
            visualDensity: VisualDensity.compact,
            horizontalTitleGap: 0,
            title: Text(
              'Ganti Password',
              style: AppStyle.regular1Text,
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.updatePassword);
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_car_outlined),
            visualDensity: VisualDensity.compact,
            horizontalTitleGap: 0,
            title: Text(
              'Rental Mobil',
              style: AppStyle.regular1Text,
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.rentalMobil);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet_outlined),
            visualDensity: VisualDensity.compact,
            horizontalTitleGap: 0,
            title: Text(
              'Dompetku',
              style: AppStyle.regular1Text,
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.dompetku);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            horizontalTitleGap: 0,
            visualDensity: VisualDensity.compact,
            title: Text(
              'Logout',
              style: AppStyle.regular1Text.copyWith(
                color: Colors.redAccent,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Yakin untuk logout?",
                      style: AppStyle.regular1Text.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          "Tidak",
                          style: AppStyle.regular1Text.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text(
                          "Ya",
                          style: AppStyle.regular1Text.copyWith(
                            color: Colors.redAccent,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
