import 'package:chance_app/ux/helpers/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerMainScreen,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _bannerAd = ad as BannerAd;
          if (mounted) setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      constraints: BoxConstraints(
        minHeight: MediaQuery.paddingOf(context).bottom,
        minWidth: double.infinity,
      ),
      padding: const EdgeInsets.all(2),
      alignment: Alignment.center,
      child: ColoredBox(
        color: Colors.white,
        child: SizedBox(
          width: _bannerAd?.size.width.toDouble(),
          height: _bannerAd?.size.height.toDouble(),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 75),
            child: (_bannerAd != null)
                ? AdWidget(ad: _bannerAd!)
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}