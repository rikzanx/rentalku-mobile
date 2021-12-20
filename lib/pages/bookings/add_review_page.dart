import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/booking.dart';
import 'package:rentalku/providers/add_review_provider.dart';
import 'package:rentalku/providers/dashboard_provider.dart';
import 'package:rentalku/services/ulasan_services.dart';
import 'package:rentalku/widgets/star_rating_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReviewPage extends StatelessWidget {
  final Booking booking;
  const AddReviewPage({Key? key,required this.booking}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddReviewProvider(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 24,
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Beri Nilai"),
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
        body: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 16),
          itemCount: 4,
          separatorBuilder: (context, index) => Divider(
            thickness: 6,
            color: Color(0xFFE0E0E0),
          ),
          itemBuilder: (context, index){
            if(index == 0){
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Consumer<AddReviewProvider>(
                            builder: (context, state, _) =>
                                Image.network(assetURL+booking.unit.imageURL),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<AddReviewProvider>(
                                builder: (context, state, _) => Text(
                                  booking.unit.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: AppStyle.regular1Text.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Consumer<AddReviewProvider>(
                                builder: (context, state, _) => Text(
                                  booking.unit.kategoriName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.regular1Text.copyWith(
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[500],
                  ),
                  Consumer<AddReviewProvider>(
                    builder: (context, state, _) => Center(
                      child: StarRating(
                        rating: state.ratings[index],
                        onRatingChanged: (rating) async{
                          state.updateRating(index, rating);
                          state.notifyListeners();
                        },
                      ),
                    ),
                  ),
                  Consumer<AddReviewProvider>(
                    builder: (context,state,_) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColor.green,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            maxLines: 5,
                            onChanged: (value) async{
                              state.updateReview(index,value);
                              state.notifyListeners();
                            },
                            decoration: InputDecoration(
                              hintText:
                                  "Beritahu pengguna lain mengapa Anda sangat menyukai unit ini.",
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ],
              );
            }else if(index == 1){
              return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Consumer<AddReviewProvider>(
                          builder: (context, state, _) =>
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    assetURL+booking.pemilik.imageURL),
                                radius: MediaQuery.of(context).size.width * 0.125,
                              ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<AddReviewProvider>(
                              builder: (context, state, _) => Text(
                                booking.pemilik.name,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: AppStyle.regular1Text.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Consumer<AddReviewProvider>(
                              builder: (context, state, _) => Text(
                                "Pemilik",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.regular1Text.copyWith(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                Consumer<AddReviewProvider>(
                  builder: (context, state, _) => Center(
                    child: StarRating(
                      rating: state.ratings[index],
                      onRatingChanged: (rating) async{
                        state.updateRating(index, rating);
                        state.notifyListeners();
                      },
                    ),
                  ),
                ),
                Consumer<AddReviewProvider>(
                  builder: (context,state,_) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: AppColor.green,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          maxLines: 5,
                          onChanged: (value) async{
                            state.updateReview(index,value);
                            state.notifyListeners();
                          },
                          decoration: InputDecoration(
                            hintText:
                                "Beritahu pengguna lain mengapa Anda sangat menyukai pemilik ini.",
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ],
            );
            }else if(index == 2){
              if(booking.withDriver){
                  return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Consumer<DashboardProvider>(
                              builder: (context, state, _) =>
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        assetURL+state.pengemudi!.imageURL),
                                    radius: MediaQuery.of(context).size.width * 0.125,
                                  ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer<DashboardProvider>(
                                  builder: (context, state, _) => Text(
                                    state.pengemudi!.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: AppStyle.regular1Text.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Consumer<AddReviewProvider>(
                                  builder: (context, state, _) => Text(
                                    "Sopir",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyle.regular1Text.copyWith(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    Consumer<AddReviewProvider>(
                      builder: (context, state, _) => Center(
                        child: StarRating(
                          rating: state.ratings[index],
                          onRatingChanged: (rating) async{
                            state.updateRating(index, rating);
                            state.notifyListeners();
                          },
                        ),
                      ),
                    ),
                    Consumer<AddReviewProvider>(
                      builder: (context,state,_) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColor.green,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              maxLines: 5,
                              onChanged: (value) async{
                                state.updateReview(index, value);
                                state.notifyListeners();
                              },
                              decoration: InputDecoration(
                                hintText:
                                    "Beritahu pengguna lain mengapa Anda sangat menyukai sopir ini.",
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  ],
                );
              }
              return Container(color: Colors.grey[500],);
            }else{
              return
              Consumer<AddReviewProvider>(
                builder: (context,state,_) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async{
                          showLoaderDialog(context);
                          makeReview(context, booking.id, state.ratings, state.reviews, booking.withDriver).
                          then((value){
                            if(value){
                              Navigator.pop(context);
                              Navigator.popUntil(context, (route) => route.isFirst);
                              Provider.of<DashboardProvider>(context, listen: false)
                              .jumpToPage(1);
                              // Navigator.pop(context);
                              Fluttertoast.showToast(msg: "Sukses buat rating.");
                            }else{
                              Navigator.pop(context);
                              Fluttertoast.showToast(msg: "Gagal buat rating.");
                            }
                          });
                        },
                        child: Text("Simpan perubahan"),
                      ),
                    ),
                  );
                }
              );
            }
          }
        ),
      ),
    );
  }

  void alertKolom(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text("Peringatan"),
        content: Container(
          height: MediaQuery.of(context).size.height / 9,
          child: Column(
            children:[
              Text(
                "Kolom isian belum lengkap.",
                style: TextStyle(color: Colors.red),
              ),
              Text(
                "Isi semua kolom!",
                style: TextStyle(color: Colors.red),
              ),
            ],
          )
        ),
      ),
    );
  }

  Future<bool> makeReview(BuildContext context,int transaksiId, List<double> ratings, List<String> reviews, bool withDriver) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    Map<String,String> body;
    if(withDriver){
      body ={
        'user_id': userId!,
        'transaksi_id': transaksiId.toString(),
        'kendaraan_star' : ratings[0].toString(), 
        'kendaraan_review' : reviews[0].toString(),
        'pemilik_star' : ratings[1].toString(), 
        'pemilik_review' : reviews[1].toString(),
        'pengemudi_star' : ratings[2].toString(), 
        'pengemudi_review' : reviews[2].toString()
      };
    }else{
      body ={
        'user_id': userId!,
        'transaksi_id': transaksiId.toString(),
        'kendaraan_star' : ratings[0].toString(), 
        'kendaraan_review' : reviews[0].toString(),
        'pemilik_star' : ratings[1].toString(), 
        'pemilik_review' : reviews[1].toString()
      };
    }
    bool response = await UlasanServices.makeReview(body);

    return response;
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Proses..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}
