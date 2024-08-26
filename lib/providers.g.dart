// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$creditAmountHash() => r'e5b96904b1775948f59d1af2352643a477889000';

/// See also [CreditAmount].
@ProviderFor(CreditAmount)
final creditAmountProvider = NotifierProvider<CreditAmount, double>.internal(
  CreditAmount.new,
  name: r'creditAmountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$creditAmountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreditAmount = Notifier<double>;
String _$selectedEMIPlanHash() => r'9ecc765312978efe594ef828ee8eba3217cb960b';

/// See also [SelectedEMIPlan].
@ProviderFor(SelectedEMIPlan)
final selectedEMIPlanProvider =
    NotifierProvider<SelectedEMIPlan, EMIPlan>.internal(
  SelectedEMIPlan.new,
  name: r'selectedEMIPlanProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedEMIPlanHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedEMIPlan = Notifier<EMIPlan>;
String _$isBankAccountSelectedHash() =>
    r'4e6dbf24eb6823fdb02378f329a53821f48097a6';

/// See also [IsBankAccountSelected].
@ProviderFor(IsBankAccountSelected)
final isBankAccountSelectedProvider =
    NotifierProvider<IsBankAccountSelected, bool>.internal(
  IsBankAccountSelected.new,
  name: r'isBankAccountSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isBankAccountSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsBankAccountSelected = Notifier<bool>;
String _$currentViewTypeHash() => r'b81b41f94950608b9aebf1b41c265efa6ab5baec';

/// See also [CurrentViewType].
@ProviderFor(CurrentViewType)
final currentViewTypeProvider =
    NotifierProvider<CurrentViewType, ViewType>.internal(
  CurrentViewType.new,
  name: r'currentViewTypeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentViewTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentViewType = Notifier<ViewType>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
