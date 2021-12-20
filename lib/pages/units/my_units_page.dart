import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/form_unit_provider.dart';
import 'package:rentalku/providers/search_units_provider.dart';

class MyUnitsPage extends StatelessWidget {
  const MyUnitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Galeri UnitKu"),
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
      body: 
      Consumer<FormUnitProvider>(
        builder: (context,state,_) {
          if(state.homeState == HomeState.Loading){
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: CircularProgressIndicator(color: AppColor.green,),
                );
              }
          if(state.homeState == HomeState.Error){
            return Center(child: Text(defaultErrorText),);
          }
          if(state.myUnitList!.length < 1){
            return Center(child: Text("Anda belum memiliki Unit."),);
          }
          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: state.myUnitList!.length,
            itemBuilder: (context, index) => Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  state.myUnitList!.elementAt(index).name,
                  style: AppStyle.smallText.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    elevation: 3,
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Image.network(assetURL+state.myUnitList!.elementAt(index).imageURL),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.detailUnit,
                          arguments: state.myUnitList![index]
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
