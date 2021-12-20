import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/providers/search_units_provider.dart';
import 'package:rentalku/widgets/filter_widget.dart';
import 'package:rentalku/widgets/rental_mobil_card_widget.dart';

class SearchUnitsPage extends StatelessWidget {
  const SearchUnitsPage({Key? key}) : super(key: key);

  get id => null;

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
        title: Text("Rental Mobil"),
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
      body: RowUnits(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_alt),
        mini: true,
        backgroundColor: AppColor.green,
        onPressed: () {
          var parentState =Provider.of<SearchUnitsProvider>(context, listen: false);

          showModalBottomSheet(
            context: context,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            builder: (context) =>
                ChangeNotifierProvider<SearchUnitsProvider>.value(
              value: parentState,
              child: ModalSheetBar(context),
            ),
          );
        },
      ),
    );
  }

  Widget RowUnits(BuildContext context){
    return Consumer<SearchUnitsProvider>(
      builder: (context,state,_) {
        if(state.homeState == HomeState.Loading){
          return Center(child: CircularProgressIndicator(color: AppColor.green,),);
        }else if(state.homeState == HomeState.Error){
          return Center(child: Text(defaultErrorText),);
        }else if(state.unitList!.length <= 0){
          return Center(child: Text("Unit tidak ditemukan."),);
        }
        else{
          return ListView.builder(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          itemCount: state.unitList!.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: UnitCardWidget(
              unit: Unit(
                id: state.unitList![index].id,
                name: state.unitList![index].name,
                description: state.unitList![index].kategoriName,
                kategoriName: state.unitList![index].kategoriName,
                withDriver: true,
                imageURL: assetURL+state.unitList![index].imageURL,
                price: state.unitList![index].price,
                rating: state.unitList![index].rating,
                capacity: state.unitList![index].capacity,
                kategori: state.unitList![index].kategori
              ),
              onTap: () {
                state.changeUnit(index);
                Provider.of<SearchUnitsProvider>(context, listen: false).selectedIndex= index;
                Navigator.pushNamed(
                  context,
                  Routes.detailUnit,
                  arguments: state.unitList![index]
                );
              },
            ),
          ),
        );
        }
      }
      
    );
  }

  Widget ModalSheetBar(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
      children: [
        Text("Pilihan kota", style: AppStyle.regular2Text),
        SizedBox(height: 2,),
        Consumer<SearchUnitsProvider>(
          builder: (context, state, _) => GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: 3,
            children: List.generate(
              state.pilihanKota.length,
              (index) => FilterWidget(
                label: state.pilihanKota[index],
                selected: state.pilihanKota[index] == state.kota,
                onTap: (status) {
                  if (status) {
                    state.kota = state.pilihanKota[index];
                  }
                  state.notifyListeners();
                },
              ),
            ),
          ),
        ),
        Text("Jenis mobil", style: AppStyle.regular2Text),
        SizedBox(height: 2),
        Consumer<SearchUnitsProvider>(
          builder: (context, state, _) => GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: 3,
            children: List.generate(
              state.selectableCarType.length,
              (index) => FilterWidget(
                label: state.selectableCarType[index],
                selected:
                    state.carType.contains(state.selectableCarType[index]),
                onTap: (status) {
                  if (status) {
                    state.carType.add(state.selectableCarType[index]);
                  } else {
                    state.carType.remove(state.selectableCarType[index]);
                  }
                  state.notifyListeners();
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Consumer<SearchUnitsProvider>(
            builder: (context,app,_)=>ElevatedButton(
            onPressed: () {
              print(app.kota);
              app.search();
              app.notifyListeners();
            },
            child: Text("Cari"),
          ),
        ),
        
      ],
    );
  }
}
