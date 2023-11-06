import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:collection/collection.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:night_diary/helper/date_helper.dart';
import 'package:night_diary/presentation/purchase/purchase_bloc.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../helper/colors.dart';
import '../widgets/custom_button.dart';

@RoutePage()
class PaywallPage extends HookWidget {
  final bool isFromOnboarding;
  final Offering offering;

  const PaywallPage(
      {super.key, this.isFromOnboarding = false, required this.offering});

  restorePurchase(BuildContext context) async {
    try {
      await Purchases.restorePurchases().then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("You are now a Pro!")));
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No previous purchase found.")));
      });
    } on PlatformException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(offering.availablePackages.indexWhere(
        (element) => element.packageType.name == PackageType.annual.name));
    final isLoading = useState(false);

    final annualPerMonth = offering.annual!.storeProduct.price / 12;
    final saving = ((offering.monthly!.storeProduct.price - annualPerMonth) /
            offering.monthly!.storeProduct.price) *
        100;
    final introductory = offering
        .availablePackages[selectedIndex.value].storeProduct.introductoryPrice;
    final period = DateHelper.getPeriod(
      value: introductory!.periodNumberOfUnits,
      unit: introductory.periodUnit,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<PurchaseBloc, PurchaseState>(
        builder: (context, state) {
          if (state is PurchaseLoaded) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.95,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16.0,
                  16.0,
                  16.0,
                  0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          "assets/ic_logo.svg",
                        ),
                        const Text(
                          "Unlock Unlimited Affirmations",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Text(
                          "Enjoy unlimited personal, inspirational, and motivational affirmations whenever and wherever",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (state.onTrial)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                "You are currently on $period free trial!",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextButton(
                            onPressed: () {
                              isLoading.value = true;
                              restorePurchase(context);
                              isLoading.value = false;
                            },
                            child: const Text(
                              "Restore Purchase",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Column(
                              children: [
                                Column(
                                  children: offering.availablePackages
                                      .mapIndexed((index, item) {
                                    return priceItem(
                                      context,
                                      state: state,
                                      item: item,
                                      isSelected: index == selectedIndex.value,
                                      onTap: () {
                                        selectedIndex.value = index;
                                        //selectedProduct.value = item.storeProduct;
                                      },
                                      saving: saving,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: isFromOnboarding ? 0.0 : 24.0),
                            child: CustomButton(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              height: 60.0,
                              onPressed: () async {
                                isLoading.value = true;
                                if (selectedIndex.value != -1) {
                                  final item = offering
                                      .availablePackages[selectedIndex.value]
                                      .storeProduct;
                                  await Purchases.purchaseStoreProduct(item)
                                      .then((value) {
                                    isLoading.value = false;
                                    Navigator.pop(context);
                                  }).onError((error, stackTrace) {
                                    isLoading.value = false;
                                  });
                                } else {
                                  isLoading.value = false;
                                }

                                if (context.mounted) {
                                  context
                                      .read<PurchaseBloc>()
                                      .add(CheckEntitlement());
                                }
                              },
                              child: isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator.adaptive(
                                        backgroundColor: Colors.white,
                                      ),
                                    )
                                  : state.trialEntitled
                                      ? Text(
                                          "Start your $period free trial",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : const Text(
                                          "Unlock Premium",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                            ),
                          ),
                          if (isFromOnboarding)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("I'll do it later"),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget featureItem({
    required Widget icon,
    required String title,
    required String desc,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(
            width: 13.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget priceItem(
    BuildContext context, {
    required PurchaseLoaded state,
    required Package item,
    required bool isSelected,
    required Function() onTap,
    required double saving,
  }) {
    final per =
        item.packageType.name == PackageType.annual.name ? "year" : "month";
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: isSelected ? Colors.black : Theme.of(context).cardColor,
            border: Border.all(
              width: 0.5,
              color: isSelected ? Colors.black : Colors.grey.shade200,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: Colors.transparent,
                child: Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  // Rounded Checkbox
                  value: isSelected,
                  activeColor: secondaryColor,
                  checkColor: Colors.black,
                  onChanged: (inputValue) {
                    onTap();
                  },
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            item.storeProduct.title
                                .replaceAll(RegExp('\\(.*?\\)'), ''),
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          if (state.trialEntitled)
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Get ${DateHelper.getPeriod(
                                      value: item
                                          .storeProduct
                                          .introductoryPrice!
                                          .periodNumberOfUnits,
                                      unit: item.storeProduct.introductoryPrice!
                                          .periodUnit,
                                    )} free, then ",
                                  ),
                                  TextSpan(
                                    text:
                                        "${item.storeProduct.priceString}/$per",
                                  ),
                                ],
                              ),
                            )
                          else
                            Text(
                              "${item.storeProduct.priceString}/$per",
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                        ],
                      ),
                    ),
                    if (item.packageType.name == PackageType.annual.name)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: secondaryColor,
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: "Save ",
                                ),
                                TextSpan(
                                  text: "${saving.toStringAsFixed(2)}%",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
