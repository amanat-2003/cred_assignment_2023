// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cred_amanat/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cred_amanat/app_constants.dart';
import 'package:cred_amanat/utils.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopCircularButtton(
            type: ButtonType.x,
          ),
          TopCircularButtton(
            type: ButtonType.question,
          ),
        ],
      ),
    );
  }
}

enum BottomButtonNo { first, second, third }

class BottomButton extends ConsumerWidget {
  final String text;
  final Color backColor;
  final BottomButtonNo buttonNo;
  final void Function()? onTap;
  const BottomButton({
    super.key,
    required this.text,
    required this.backColor,
    required this.buttonNo,
    this.onTap,
  });

  void _showBottomSheet1(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        backgroundColor: AppColors.base2Color,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Consumer(
            builder: (context, ref, child) {
              double height = kIsWeb
                  ? mediaQuery.size.height - 180.w
                  : Platform.isIOS
                      ? mediaQuery.size.height - mediaQuery.padding.top - 235.w
                      : mediaQuery.size.height - 210.w;

              final heightFactor = height / 617;

              final selectedEMIPlan = ref.watch(selectedEMIPlanProvider);

              final currentView = ref.watch(currentViewTypeProvider);

              final emiViewColumn = [
                Padding(
                  padding: EdgeInsets.only(
                    left: 30.w,
                    right: 30.w,
                    top: 30 * heightFactor,
                    bottom: 50 * heightFactor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "how do you wish to repay?",
                        style: TextStyle(
                          color: AppColors.bigBlueTextColor,
                          fontSize: 18.w,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(10 * heightFactor),
                      Text(
                        "choose one of our recommended plans or make your own",
                        style: TextStyle(
                          color: AppColors.smallBlueTextColor,
                          fontSize: 12.w,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Gap(40 * heightFactor),
                      SizedBox(
                        height: height / 3,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          child: Consumer(builder: (context, ref, child) {
                            final selectedEMIPlan =
                                ref.watch(selectedEMIPlanProvider);
                            final setter =
                                ref.read(selectedEMIPlanProvider.notifier);
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setter.set(listOfPlans[0]);
                                  },
                                  child: EMICard(
                                    height: height / 3,
                                    color: AppColors.emiCardColor1,
                                    isRecommended: false,
                                    money: 4247,
                                    months: 12,
                                    isSelected:
                                        selectedEMIPlan == listOfPlans[0],
                                  ),
                                ),
                                Gap(20.w),
                                GestureDetector(
                                  onTap: () {
                                    setter.set(listOfPlans[1]);
                                  },
                                  child: EMICard(
                                    height: height / 3,
                                    color: AppColors.emiCardColor2,
                                    isRecommended: true,
                                    money: 5580,
                                    months: 9,
                                    isSelected:
                                        selectedEMIPlan == listOfPlans[1],
                                  ),
                                ),
                                Gap(20.w),
                                GestureDetector(
                                  onTap: () {
                                    setter.set(listOfPlans[2]);
                                  },
                                  child: EMICard(
                                    height: height / 3,
                                    color: AppColors.emiCardColor3,
                                    isRecommended: false,
                                    money: 8494,
                                    months: 6,
                                    isSelected:
                                        selectedEMIPlan == listOfPlans[2],
                                  ),
                                ),
                                Gap(20.w),
                              ],
                            );
                          }),
                        ),
                      ),
                      Gap(30 * heightFactor),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16 * heightFactor,
                              vertical: 10 * heightFactor),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.outlineButtonColor,
                                width: 1 * heightFactor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Create your own plan",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.outlineButtonColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (ref.watch(isButtonVisibleProvider))
                  const BottomButton(
                    text: 'Select your bank account',
                    backColor: AppColors.base2Color,
                    buttonNo: BottomButtonNo.second,
                  ),
              ];

              final nonEmiViewColumn = [
                Padding(
                  padding: EdgeInsets.only(
                    left: 30.w,
                    right: 30.w,
                    top: 30 * heightFactor,
                    bottom: 50 * heightFactor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "EMI",
                            style: TextStyle(
                              color: AppColors.text1InactiveColor,
                              fontSize: 13.w,
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
                                "${formatIndianCurrency(selectedEMIPlan.amountPerMonth)} /mo",
                                style: GoogleFonts.montserrat(
                                  letterSpacing: 1,
                                  color: AppColors.text1InactiveColor,
                                  fontSize: 20.w,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "duration",
                            style: TextStyle(
                              color: AppColors.text1InactiveColor,
                              fontSize: 13.w,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Gap(5.w),
                          Text(
                            "${selectedEMIPlan.noOfMonths} months",
                            style: GoogleFonts.montserrat(
                              color: AppColors.text1InactiveColor,
                              fontSize: 20.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
                ),
              ];
              /*
                return PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (didPop, result) {
                    if (!didPop) {
                      ref
                          .read(currentViewTypeProvider.notifier)
                          .set(ViewType.sliderView);
                      Navigator.of(context).pop();
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: height,
                    child: SafeArea(
                      child: Consumer(
                        builder: (context, ref, child) {
                          final currentViewType =
                              ref.watch(currentViewTypeProvider);
                          return Stack(
                            children: [
                              AnimatedOpacity(
                                opacity: (currentViewType ==
                                            ViewType.emiPlansView ||
                                        currentViewType == ViewType.sliderView)
                                    ? 1.0
                                    : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: emiViewColumn,
                                ),
                              ),
                              AnimatedOpacity(
                                opacity:
                                    (currentViewType == ViewType.bankAccountView)
                                        ? 1.0
                                        : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: nonEmiViewColumn,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
            */

              return PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) {
                  ref
                      .read(currentViewTypeProvider.notifier)
                      .set(ViewType.sliderView);
                  if (!didPop) {
                    Navigator.of(context).pop();
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  height: height,
                  child: SafeArea(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                      child: (currentView == ViewType.emiPlansView ||
                              currentView == ViewType.sliderView)
                          ? Column(
                              key: const ValueKey(ViewType.emiPlansView),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: emiViewColumn,
                            )
                          : Column(
                              key: const ValueKey(ViewType.bankAccountView),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: nonEmiViewColumn,
                            ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  void _showBottomSheet2(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        backgroundColor: AppColors.base3Color,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          double parentHeight = kIsWeb
              ? mediaQuery.size.height - 180.w
              : Platform.isIOS
                  ? mediaQuery.size.height - mediaQuery.padding.top - 235.w
                  : mediaQuery.size.height - 210.w; // 617

          final parentHeightFactor = kIsWeb
              ? parentHeight / 726
              : Platform.isIOS
                  ? parentHeight / 617
                  : parentHeight / 609;

          double height = kIsWeb
              ? 590 * parentHeightFactor
              : Platform.isIOS
                  ? 510 * parentHeightFactor
                  : 490 * parentHeightFactor;

          final heightFactor = kIsWeb
              ? height / 467
              : Platform.isIOS
                  ? height / 490
                  : height / 490;

          return Consumer(builder: (context, ref, child) {
            bool isChecked = ref.watch(isBankAccountSelectedProvider);

            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                ref
                    .read(currentViewTypeProvider.notifier)
                    .set(ViewType.emiPlansView);
                if (!didPop) {
                  Navigator.of(context).pop();
                }
              },
              child: SizedBox(
                width: double.infinity,
                height: height,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                              right: 30.w,
                              top: 30 * heightFactor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "where should we send the money?",
                                  style: TextStyle(
                                    color: AppColors.bigBlueTextColor,
                                    fontSize: 18.w,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gap(10 * heightFactor),
                                Text(
                                  "amount will be credited to this bank account, EMI will also be debited from this bank account",
                                  style: TextStyle(
                                    color: AppColors.smallBlueTextColor,
                                    fontSize: 12.w,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Gap(25 * heightFactor),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              ref
                                  .read(isBankAccountSelectedProvider.notifier)
                                  .toggle();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 15 * heightFactor,
                                horizontal: 30.w,
                              ),
                              child: Row(
                                children: [
                                  // Asset image with rounded edges
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        15 * heightFactor),
                                    child: Image.asset(
                                      'assets/paytm_logo.png',
                                      width: 55 * heightFactor,
                                      height: 55 * heightFactor,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 12 * heightFactor),

                                  // Column with two text widgets
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Paytm Payments Bank',
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 16 * heightFactor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 4), // Spacing between texts
                                      Text(
                                        '919935670475',
                                        style: TextStyle(
                                          fontSize: 16 * heightFactor,
                                          color: AppColors.whiteColor
                                              .withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const Spacer(),
                                  Container(
                                    width: 35 * heightFactor,
                                    height: 35 * heightFactor,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.darkGreyTextColor
                                          .withOpacity(0.3),
                                    ),
                                    child: isChecked
                                        ? Center(
                                            child: Icon(
                                              Icons.check_rounded,
                                              color: AppColors.whiteColor
                                                  .withOpacity(1),
                                              size: 20 * heightFactor,
                                              weight: 0.1,
                                            ),
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(20 * heightFactor),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                              right: 30.w,
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16 * heightFactor,
                                    vertical: 10 * heightFactor),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.outlineButtonColor,
                                      width: 1 * heightFactor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Change account",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.outlineButtonColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const BottomButton(
                        text: 'Tap for 1-click KYC',
                        backColor: AppColors.base3Color,
                        buttonNo: BottomButtonNo.third,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        switch (buttonNo) {
          case BottomButtonNo.first:
            ref
                .read(currentViewTypeProvider.notifier)
                .set(ViewType.emiPlansView);
            _showBottomSheet1(context);
            await Future.delayed(
              const Duration(milliseconds: 300),
              () => ref.read(isButtonVisibleProvider.notifier).set(true),
            );
            break;
          case BottomButtonNo.second:
            print("Button 2");
            ref
                .read(currentViewTypeProvider.notifier)
                .set(ViewType.bankAccountView);
            _showBottomSheet2(context);
            break;
          case BottomButtonNo.third:
            break;
          default:
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: backColor,
        ),
        child: Container(
          height: 80.w,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.bottomNavBarButtonColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: (buttonNo == BottomButtonNo.third)
                    ? AppColors.bottomNavBarTextColor.withOpacity(0.5)
                    : AppColors.bottomNavBarTextColor,
                fontSize: 16.w, // Adjust font size as needed
                fontWeight: FontWeight.bold, // Optional for better visibility
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EMICard extends StatelessWidget {
  final double height;
  final Color color;
  final int money;
  final int months;
  final bool isRecommended;
  final bool isSelected;
  const EMICard({
    super.key,
    required this.height,
    required this.color,
    required this.money,
    required this.months,
    required this.isRecommended,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final heightFactor = height / 205;
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height,
          padding: EdgeInsets.only(
            left: 20 * heightFactor,
            top: 20 * heightFactor,
            bottom: 20 * heightFactor,
            right: 65 * heightFactor,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20 * heightFactor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Gap(13 * heightFactor),
              CheckedCircle(
                heightFactor: heightFactor,
                isChecked: isSelected,
              ),
              Gap(16 * heightFactor),
              Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "₹",
                    style: GoogleFonts.roboto(
                      color: AppColors.whiteColor,
                      fontSize: 18 * heightFactor,
                    ),
                  ),
                  Text(
                    formatIndianCurrency(money),
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18 * heightFactor, // Adjust font size as needed
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' /mo',
                    style: TextStyle(
                      color: AppColors.whiteColor.withOpacity(0.5),
                      fontSize: 14 * heightFactor, // Adjust font size as needed
                      fontWeight:
                          FontWeight.bold, // Optional for better visibility
                    ),
                  ),
                ],
              ),
              Gap(3 * heightFactor),
              Text(
                'for $months months',
                style: TextStyle(
                  color: AppColors.whiteColor.withOpacity(0.7),
                  fontSize: 15 * heightFactor, // Adjust font size as needed
                  fontWeight: FontWeight.bold, // Optional for better visibility
                ),
              ),
              Gap(13 * heightFactor),
              DashedBottomContainer(
                text: '',
                isSmall: true,
                underlineColor: AppColors.whiteColor.withOpacity(0.6),
                child: Text(
                  'See calculations',
                  style: TextStyle(
                    color: AppColors.whiteColor.withOpacity(0.6),
                    fontSize: 13 * heightFactor, // Adjust font size as needed
                    fontWeight:
                        FontWeight.bold, // Optional for better visibility
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isRecommended)
          Positioned(
            top: -15 * heightFactor,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20 * heightFactor,
                vertical: 4 * heightFactor,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12 * heightFactor),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 59, 60, 60),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'recommended',
                style: TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontSize: 13.5 * heightFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CheckedCircle extends StatelessWidget {
  const CheckedCircle({
    super.key,
    required this.heightFactor,
    required this.isChecked,
  });

  final double heightFactor;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40 * heightFactor,
      height: 40 * heightFactor,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isChecked ? AppColors.blackColor.withOpacity(0.3) : null,
        border: isChecked
            ? null
            : Border.all(
                color: AppColors.whiteColor.withOpacity(0.6),
                width: 1 * heightFactor,
              ),
      ),
      child: isChecked
          ? Center(
              child: Icon(
                Icons.check_rounded,
                color: AppColors.whiteColor.withOpacity(1),
                size: 25 * heightFactor,
                weight: 0.1,
              ),
            )
          : null,
    );
  }
}

enum ButtonType {
  x,
  question,
}

class TopCircularButtton extends StatelessWidget {
  final ButtonType type;
  const TopCircularButtton({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.w,
      height: 35.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.topCircularButtonBackgroundColor, // #1b242a color
      ),
      child: Center(
        child: type == ButtonType.question
            ? Text(
                '?',
                style: TextStyle(
                  color: AppColors
                      .topCircularButtonForegroundColor, // #a5acac color
                  fontSize: 20.w,
                  // fontWeight: FontWeight.bold,
                ),
              )
            : Icon(
                Icons.close_rounded,
                size: 20.w,
                color: AppColors.topCircularButtonForegroundColor,
              ),
      ),
    );
  }
}

class DashedBottomContainer extends StatelessWidget {
  final String text;
  final bool isSmall;
  final Widget? child;
  final Color? underlineColor;

  const DashedBottomContainer({
    super.key,
    required this.text,
    required this.isSmall,
    this.child,
    this.underlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: CustomPaint(
        painter: DashedBottomPainter(
          color: isSmall ? underlineColor! : AppColors.blackColor,
          underlineDashWidth: isSmall ? 3.0 : 5.0,
        ),
        child: Container(
          padding: isSmall ? null : const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: isSmall ? null : const Color.fromARGB(255, 239, 240, 239),
            borderRadius: isSmall
                ? null
                : const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
          ),
          child: Center(
            child: isSmall
                ? child
                : Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class DashedBottomPainter extends CustomPainter {
  final Color color;
  final double underlineDashWidth;

  DashedBottomPainter({
    required this.color,
    required this.underlineDashWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final dashWidth = underlineDashWidth;
    final dashSpace = underlineDashWidth - 1;
    final totalWidth = size.width;
    final totalHeight = size.height;

    double startX = 0;

    while (startX < totalWidth) {
      final endX = startX + dashWidth;
      if (endX > totalWidth) {
        canvas.drawLine(
          Offset(startX, totalHeight),
          Offset(totalWidth, totalHeight),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(startX, totalHeight),
          Offset(endX, totalHeight),
          paint,
        );
      }
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
