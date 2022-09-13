import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/on_boarding/boarding_model.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: "assets/images/onboard_1.jpg",
        title: 'OnBoarding Screen 1',
        body: 'OnBoarding body 1'),
    BoardingModel(
        image: "assets/images/onboard_1.jpg",
        title: 'OnBoarding Screen 2',
        body: 'OnBoarding body 2'),
    BoardingModel(
        image: "assets/images/onboard_1.jpg",
        title: 'OnBoarding Screen 3',
        body: 'OnBoarding body 3')
  ];
PageController pageController=PageController();
bool isLast=false;
void submit(){
  CacheHelper.saveData(key: 'onBoarding',value: true).then((value) {
    if(value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()),
              (route) => false);
    }
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 30,top: 10),
            child: InkWell(
                onTap:submit,
                child:  Text('Skip',style: TextStyle(
                  color: defaultColor
                ),)),
          )
        ],
      ),
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (int index){
                if(index==boarding.length-1){
                  setState(() {
                    isLast=true;
                  });
                }
                else{
                  setState(() {
                      isLast=false;
                  });
                }
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          Row(
            children:[
              SmoothPageIndicator(controller: pageController, count: boarding.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: defaultColor,
                  dotHeight: 10.0,
                  expansionFactor: 3,
                  dotWidth: 10,
                  spacing: 5,
                ),
              ),
              const Spacer(),
              FloatingActionButton(
              child: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                if(isLast==true){
                 submit();
                }
                pageController.nextPage(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastLinearToSlowEaseIn
                ); },)

            ],
          )
        ],
      ),
    ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ],
      );
}
