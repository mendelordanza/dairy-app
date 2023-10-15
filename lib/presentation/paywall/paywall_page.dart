import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:collection/collection.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:night_diary/helper/date_helper.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../helper/colors.dart';
import '../widgets/custom_button.dart';

class PaywallPage extends HookWidget {
  final bool isFromOnboarding;
  final Offering offering;

  PaywallPage({this.isFromOnboarding = false, required this.offering});

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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
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

    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          24.0,
          16.0,
          24.0,
          0.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.close),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/ic_logo.svg",
                          height: 150.0,
                        ),
                        const Text(
                          "Unlock Unlimited Quotes",
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
                          "Generate unlimited personal, inspiring, and motivating quotes whenever you want",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      isLoading.value = true;
                      restorePurchase(context);
                      isLoading.value = false;
                    },
                    child: const Text(
                      "Restore Purchase",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        Column(
                          children: offering.availablePackages
                              .mapIndexed((index, item) {
                            return priceItem(
                              context,
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
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: isFromOnboarding ? 0.0 : 24.0),
              child: CustomButton(
                height: 60.0,
                onPressed: () async {
                  isLoading.value = true;
                  if (selectedIndex.value != -1) {
                    final item = offering
                        .availablePackages[selectedIndex.value].storeProduct;
                    await Purchases.purchaseStoreProduct(item).then((value) {
                      isLoading.value = false;
                      Navigator.pop(context);
                    }).onError((error, stackTrace) {
                      isLoading.value = false;
                    });
                  } else {
                    isLoading.value = false;
                  }
                },
                backgroundColor: selectedIndex.value == -1
                    ? Colors.grey.shade400
                    : Colors.black,
                child: isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : Text(
                        "Get Your $period Free Trial",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            if (isFromOnboarding)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("I'll do it later"),
              )
          ],
        ),
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
            color: isSelected ? Colors.black : Colors.white70,
            border: isSelected ? null : Border.all(color: Colors.grey),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Theme.of(context).colorScheme.onSurface,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          item.storeProduct.title
                              .replaceAll(RegExp('\\(.*?\\)'), ''),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: "Get ${DateHelper.getPeriod(
                                  value: item.storeProduct.introductoryPrice!
                                      .periodNumberOfUnits,
                                  unit: item.storeProduct.introductoryPrice!
                                      .periodUnit,
                                )} free, then ",
                              ),
                              TextSpan(
                                text: "${item.storeProduct.priceString}/$per",
                              ),
                              const TextSpan(
                                text: " after",
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
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
