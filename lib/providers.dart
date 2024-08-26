// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
class CreditAmount extends _$CreditAmount {
  @override
  double build() {
    return 150000;
  }

  void set(double val) {
    if (val >= 0 && val <= 487891) {
      state = val;
    }
  }
}

class EMIPlan {
  final int amountPerMonth;
  final int noOfMonths;

  const EMIPlan({required this.amountPerMonth, required this.noOfMonths});

  @override
  bool operator ==(covariant EMIPlan other) {
    if (identical(this, other)) return true;

    return other.amountPerMonth == amountPerMonth &&
        other.noOfMonths == noOfMonths;
  }

  @override
  int get hashCode => amountPerMonth.hashCode ^ noOfMonths.hashCode;
}

const listOfPlans = [
  EMIPlan(amountPerMonth: 4247, noOfMonths: 12),
  EMIPlan(amountPerMonth: 5580, noOfMonths: 9),
  EMIPlan(amountPerMonth: 8494, noOfMonths: 6),
];

@Riverpod(keepAlive: true)
class SelectedEMIPlan extends _$SelectedEMIPlan {
  @override
  EMIPlan build() {
    return listOfPlans[1];
  }

  void set(EMIPlan emiPlan) {
    state = emiPlan;
  }
}

@Riverpod(keepAlive: true)
class IsBankAccountSelected extends _$IsBankAccountSelected {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

@Riverpod(keepAlive: true)
class IsButtonVisible extends _$IsButtonVisible {
  @override
  bool build() {
    return false;
  }

  void set(bool val) {
    state = val;
  }
}

enum ViewType {
  sliderView,
  emiPlansView,
  bankAccountView,
}

@Riverpod(keepAlive: true)
class CurrentViewType extends _$CurrentViewType {
  @override
  ViewType build() {
    return ViewType.sliderView;
  }

  void set(ViewType view) {
    state = view;
  }
}
