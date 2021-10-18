import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/add_review_provider.dart';
import 'package:rentalku/widgets/star_rating_widget.dart';

class AddReviewPage extends StatelessWidget {
  const AddReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddReviewProvider(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 24,
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Beri Nilai"),
          titleTextStyle: AppStyle.title2Text.copyWith(color: Colors.white),
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
          itemBuilder: (context, index) => Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Consumer<AddReviewProvider>(
                        builder: (context, state, _) =>
                            Image.network(state.bookings[index].imageURL),
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
                              state.bookings[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: AppStyle.regular1Text.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Consumer<AddReviewProvider>(
                            builder: (context, state, _) => Text(
                              state.bookings[index].description,
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
                    onRatingChanged: (rating) {
                      state.updateRating(index, rating);
                    },
                  ),
                ),
              ),
              Padding(
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
                    decoration: InputDecoration(
                      hintText:
                          "Beritahu pengguna lain mengapa Anda sangat menyukai produk ini.",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
