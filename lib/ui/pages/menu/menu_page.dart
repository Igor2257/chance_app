import 'dart:async';

import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ux/hive_crum.dart';
import 'package:chance_app/ux/model/product_model.dart';
import 'package:chance_app/ux/model/settings.dart';
import 'package:chance_app/ux/repository/items_repository.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  static InAppPurchase inAppPurchase = InAppPurchase.instance;
  static List<ProductDetails> products = [];
  static List<PurchaseDetails> purchase = [];
  StreamSubscription? subscription;
  static String idOfPrd = "";
  static late ProductDetails item;

  @override
  void dispose() {
    if (subscription != null) {
      subscription!.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkIfDocsAreAvailable();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          AppLocalizations.instance.translate("menu"),
          style: TextStyle(fontSize: 22, color: primaryText),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/");
          },
        ),
      ),
      backgroundColor: beigeBG,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.instance.translate("account"),
              style: TextStyle(fontSize: 16, color: darkNeutral800),
            ),
            RoundedButton(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 4),
                border: Border.all(color: darkNeutral800),
                onPress: () async {
                  Navigator.of(context).pushNamed("/my_information");
                },
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.instance.translate("myInfo"),
                      style: TextStyle(
                          fontSize: 16,
                          color: primaryText,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primaryText,
                    )
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            RoundedButton(
              onPress: (){
                findMatch(products[0], 0);
              },
                padding: const EdgeInsets.all(16),
                height: 70,
                color: darkNeutral600,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/adblocker.png",
                      width: 53,
                      color: primary50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      AppLocalizations.instance.translate("buyAdblocker"),
                      style: TextStyle(
                          color: primary50,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            Text(
              AppLocalizations.instance.translate("aboutTheApplication"),
              style: TextStyle(fontSize: 16, color: darkNeutral800),
            ),
            RoundedButton(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 4),
                border: Border.all(color: darkNeutral800),
                onPress: () async {},
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.instance.translate("privacyPolicy"),
                      style: TextStyle(
                          fontSize: 16,
                          color: primaryText,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primaryText,
                    )
                  ],
                )),
            RoundedButton(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 4),
                border: Border.all(color: darkNeutral800),
                onPress: () async {
                  Navigator.of(context).pushNamed("/choose_language");
                },
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.instance.translate("changeLanguage"),
                      style: TextStyle(
                          fontSize: 16,
                          color: primaryText,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primaryText,
                    )
                  ],
                )),
            const Spacer(),
            RoundedButton(
                margin: const EdgeInsets.symmetric(vertical: 4),
                onPress: () async {
                  await UserRepository().logout().then((value) {
                    if (value == null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/signinup", (route) => false);
                    }
                  });
                },
                color: primary1000,
                child: Text(
                  AppLocalizations.instance.translate("logOut"),
                  style: TextStyle(
                      fontSize: 16,
                      color: primary50,
                      fontWeight: FontWeight.w500),
                )),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  void initialize() async {
    await inAppPurchase.isAvailable().then((value) async {
      if (value) {
        await _getProducts().whenComplete(() {
          subscription = inAppPurchase.purchaseStream.listen((event) {
            purchase.addAll(event);
            verifyPurchase();
          });
        });
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  checkIfDocsAreAvailable() async {
    List<ProductModel> items = List.of(HiveCRUM().myItems);
    if (items.isNotEmpty) {
      List<ProductModel> newItems = [];
      for (int i = 0; i < items.length; i++) {
        if (items[i].validity != null) {
          if (items[i].validity!.isAfter(DateTime.now())) {
            newItems.add(items[i]);
          }
        }
      }
      if (newItems != items) {
        HiveCRUM().rewriteItems(newItems);
      }
    }
  }

  Future<void> _getProducts() async {
    try {
      Set<String> ids = <String>{
        'adblocker',
        'buy_more_seats_on_server',
        'change_parametrs_on_serv',
        'one_more_server',
        'editing_profile',
        'block_all_ads',
      };

      await InAppPurchase.instance
          .queryProductDetails(ids)
          .then((value) => setState(() {
                products = value.productDetails;
              }));
    } on PlatformException {
      Fluttertoast.showToast(
          msg: AppLocalizations.instance.translate("smthWentWrong"));
    } catch (error) {
      Fluttertoast.showToast(
          msg: AppLocalizations.instance.translate("smthWentWrong"));
    }
  }

  findMatch(ProductDetails item1, int position) async {
    List<ProductModel> items = HiveCRUM().myItems;
    if (items.isNotEmpty) {
      bool isAdBlockerValid = items.any((item) =>
              item.id == "adblocker" &&
              item.validity!.isAfter(DateTime.now())) ||
          items.any((item) =>
              item.id == "block_all_ads" &&
              item.validity!.isAfter(DateTime.now()));

      if (!(item1.id == 'adblocker' && isAdBlockerValid)) {
        item = item1;
        idOfPrd = item.id;
        final PurchaseParam purchaseParam =
            PurchaseParam(productDetails: products[position]);
        InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
        verifyPurchase();
      } else {
        Fluttertoast.showToast(
            msg: AppLocalizations.instance.translate("adblockerExists"));
      }
    } else {
      item = item1;
      idOfPrd = item.id;
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: products[position]);
      InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
      verifyPurchase();
    }
  }

  PurchaseDetails? _hasPurchased(String productID) {
    for (var item in purchase) {
      if (item.productID == productID) {
        return item;
      }
    }
    return null;
  }

  verifyPurchase() {
    if (idOfPrd != "") {
      PurchaseDetails? purchaseDetails = _hasPurchased(idOfPrd);

      if (purchaseDetails != null &&
          purchaseDetails.status == PurchaseStatus.purchased &&
          purchaseDetails.status != PurchaseStatus.pending) {
        bought();
      }
    }
  }

  bought() async {
    ProductModel model = ProductModel(
      id: item.id,
      title: item.title,
      description: item.description,
      price: item.price,
      validity: DateTime.now().add(const Duration(days: 30)),
    );
    HiveCRUM hiveCRUM=HiveCRUM();
    List<ProductModel> items = hiveCRUM.myItems;
    items.add(model);
    await ItemsRepository().rewriteItems(items);
    idOfPrd = "";
    purchase = [];
    if (mounted) {
      setState(() {});
    }
    Fluttertoast.showToast(
      msg: AppLocalizations.instance.translate("enjoy"),
    );
  }
}
