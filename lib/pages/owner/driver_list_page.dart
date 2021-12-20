import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/sopir_provider.dart';

class DriverListPage extends StatelessWidget {
  const DriverListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SopirProvider>(context,listen:false).getDrivers();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("SopirKu"),
        titleTextStyle: AppStyle.title3Text.copyWith(color: Colors.white),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        elevation: 2,
      ),
      body: Consumer<SopirProvider>(
        builder: (context,state,_) {
          if(state.homeState == HomeState.Loading){
            return Center(child: CircularProgressIndicator(color: AppColor.green,),);
          }
          if(state.homeState == HomeState.Error){
            return Center(child: Text(defaultErrorText),);
          }
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              ...List.generate(
                state.drivers.length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(5),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  assetURL+state.drivers.elementAt(index).imageURL),
                              radius: 24,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                state.drivers.elementAt(index).name,
                                style: AppStyle.regular2Text,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ),
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(5),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          width: 48,
                          height: 48,
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            "Tambahkan Sopir",
                            style: AppStyle.regular2Text.copyWith(
                              color: Colors.grey[500],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.addDriver);
                  },
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
