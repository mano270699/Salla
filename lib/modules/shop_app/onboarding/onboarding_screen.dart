import 'package:flutter/material.dart';
import 'package:salla/modules/shop_app/login/login_screen.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String Image;
  final String Title;
  final String Body;
  BoardingModel({
    @required this.Image,
    @required this.Title,
    @required this.Body,
  });
}

/*"title": "Choose",
  "subtitle1": "The",
  "subtitle2": "Products",

  "title2": "Add favourite",
  "subtitle12": "Product to",
  "subtitle22": "Cart",

  "title3": "Choose your",
  "subtitle13": "Payment",
  "subtitle23": "Option",

  "title4": "Choose",
  "subtitle14": "The Best",
  "subtitle24": "Shipping", */
class OnBoardingScreen extends StatefulWidget {
  //const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> onBoard = [
    BoardingModel(
      Body: 'The Products',
      Image: 'assets/images/firstimage.png',
      Title: 'Choose',
    ),
    BoardingModel(
      Body: 'Product to cart',
      Image: 'assets/images/secondimage.png',
      Title: 'Add favourite',
    ),
    BoardingModel(
      Body: 'Payment Option',
      Image: 'assets/images/thirdimage.png',
      Title: 'Choose your',
    ),
    BoardingModel(
      Body: 'The Best Shipping',
      Image: 'assets/images/fourthimage.png',
      Title: 'Choose ',
    ),
  ];
  bool isLast = false;
  void submit() {
    CacheHelper.saveUserData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text(
                'SKIP',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == onBoard.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(onBoard[index]),
                itemCount: 4,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: onBoard.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel onBoard) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${onBoard.Image}'),
            ),
          ),
          Text(
            '${onBoard.Title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${onBoard.Body}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
