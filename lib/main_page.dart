import 'package:cred_amanat/providers.dart';
import 'package:cred_amanat/utils.dart';
import 'package:cred_amanat/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:cred_amanat/app_constants.dart';

class LoanUI extends StatefulWidget {
  const LoanUI({super.key});

  @override
  State<LoanUI> createState() => _LoanUIState();
}

class _LoanUIState extends State<LoanUI> {
  // double _currentValue = 150000;

  @override
  Widget build(BuildContext context) {
    var baseCreditSliderArea = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.base1Color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.r),
          topRight: Radius.circular(35.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 30.w,
          right: 30.w,
          top: 35.w,
          bottom: 50.w,
        ),
        child: Consumer(builder: (context, ref, child) {
          final sliderViewColumn = [
            Text(
              "nikunj, how much do you need?",
              style: TextStyle(
                color: AppColors.bigBlueTextColor,
                fontSize: 18.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(10.w),
            Text(
              "move the dial and set any amount you need upto ₹487,891",
              style: TextStyle(
                color: AppColors.smallBlueTextColor,
                fontSize: 12.w,
                fontWeight: FontWeight.normal,
              ),
            ),
            Gap(20.w),
            Container(
              // height: 300,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: AppColors.whiteCardColor,
                borderRadius: BorderRadius.all(Radius.circular(35)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 40.w,
                  right: 40.w,
                  top: 30.w,
                  bottom: 20.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SliderWidget(),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'stash is instant. money will be credited within seconds.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.w,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];

          final nonSliderViewColumn = [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "credit amount",
                      style: TextStyle(
                        color: AppColors.text1InactiveColor,
                        fontSize: 12.w,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Gap(5.w),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "₹ ",
                          style: GoogleFonts.roboto(
                            color: AppColors.text1InactiveColor,
                            fontSize: 20.w,
                          ),
                        ),
                        Text(
                          formatToIndianCurrency(
                              ref.watch(creditAmountProvider)),
                          style: GoogleFonts.montserrat(
                            letterSpacing: 1,
                            color: AppColors.text1InactiveColor,
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  color: AppColors.whiteColor,
                  iconSize: 25.w,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.expand_more_rounded,
                  ),
                )
              ],
            ),
          ];

          return AnimatedSwitcher(
            duration:
                const Duration(milliseconds: 300), // Adjust duration as needed
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: ref.watch(currentViewTypeProvider) == ViewType.sliderView
                ? Column(
                    key: const ValueKey(ViewType.sliderView),
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: sliderViewColumn,
                  )
                : Column(
                    key: const ValueKey(ViewType.emiPlansView),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: nonSliderViewColumn,
                  ),
          );
        }),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            Gap(10.w),
            const ButtonRow(),
            Gap(20.w),
            baseCreditSliderArea,
            Container(
              height: 70.w,
              width: double.infinity,
              color: AppColors.base1Color,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          clipBehavior: Clip.none,
          height: 80.w,
          notchMargin: 0,
          padding: EdgeInsets.zero,
          child: const BottomButton(
            buttonNo: BottomButtonNo.first,
            text: 'Proceed to EMI selection',
            backColor: AppColors.base1Color,
          )),
    );
  }
}

class SliderWidget extends ConsumerWidget {
  const SliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creditAmount = ref.watch(creditAmountProvider);

    return Center(
      child: SleekCircularSlider(
        appearance: CircularSliderAppearance(
          spinnerMode: false,
          angleRange: 360,
          startAngle: 270,
          customWidths: CustomSliderWidths(
            trackWidth: 15.w,
            progressBarWidth: 15.w,
            handlerSize: 20.w,
            shadowWidth: 0,
          ),
          customColors: CustomSliderColors(
            trackColor: AppColors.lightOrangeColor,
            progressBarColor: AppColors.darkOrangeColor,
            dotColor: AppColors.lighterOrangeColor,
            hideShadow: false,
          ),
          size: 300.w,
        ),
        min: 0,
        max: 487891,
        initialValue: creditAmount,
        onChange: (value) {
          ref.read(creditAmountProvider.notifier).set(value);
        },
        innerWidget: (value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'credit amount',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13.w,
                      fontWeight: FontWeight.bold),
                ),
                Gap(5.w),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "₹ ",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 28.w,
                      ),
                    ),
                    DashedBottomContainer(
                      text: formatToIndianCurrency(creditAmount),
                      isSmall: false,
                    ),
                  ],
                ),
                Gap(10.w),
                Text(
                  '@1.04% monthly',
                  style: TextStyle(
                    color: AppColors.greenTextColor,
                    fontSize: 13.w,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
