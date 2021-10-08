import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardProfilPage extends StatelessWidget {
  const DashboardProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                      style: GoogleFonts.montserrat(fontSize: 13),
                    ),
                    Text(
                      "Muhammad",
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 24),
          Container(
            height: 8,
            color: Colors.grey[300],
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            horizontalTitleGap: 0,
            visualDensity: VisualDensity.compact,
            title: Text(
              'Edit Data Diri',
              style: GoogleFonts.montserrat(fontSize: 13),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.lock_outline),
            visualDensity: VisualDensity.compact,
            horizontalTitleGap: 0,
            title: Text(
              'Ganti Password',
              style: GoogleFonts.montserrat(fontSize: 13),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.directions_car_outlined),
            visualDensity: VisualDensity.compact,
            horizontalTitleGap: 0,
            title: Text(
              'Rental Mobil',
              style: GoogleFonts.montserrat(fontSize: 13),
            ),
            onTap: () {},
          ),
          Container(
            height: 8,
            color: Colors.grey[300],
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            horizontalTitleGap: 0,
            visualDensity: VisualDensity.compact,
            title: Text(
              'Logout',
              style: GoogleFonts.montserrat(
                fontSize: 13,
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
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          "Tidak",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
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
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
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
