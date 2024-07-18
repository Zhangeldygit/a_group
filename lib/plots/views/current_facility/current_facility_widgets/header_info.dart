import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderInfo extends StatelessWidget {
  final Plot plot;
  final Map<String, String>? info;

  const HeaderInfo({
    super.key,
    required this.plot,
    this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              YInfoCommon(
                title: 'Цена',
                value: mln(plot.price?.toDouble() ?? 0),
              ),
              YInfoCommon(
                title: 'Назначение',
                value: plot.appointment ?? '',
              ),
              YInfoCommon(
                title: 'Сот',
                value: areaGoodLookm2(plot.acreage?.toDouble() ?? 0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class YInfoCommon extends StatelessWidget {
  final String title;
  final String value;

  const YInfoCommon({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

String areaGoodLookm2(double? price) {
  if (price == null || price == 0) return '';

  // Add your function code here!
  if (price.toString()[price.toString().length - 1] == '0') {
    final String numWihoutDecimal = price.toString().split(".")[0];
    return numWihoutDecimal;
  }

  return price.toString();
}

String mln(double value) {
  if (value == 0) return '0';
  if (value < 1000000) {
    // less than a million
    final result = value / 1000;
    if (result is int) {
      final String numWihoutDecimal = result.toInt().toStringAsFixed(2).split(".")[0];

      return '$numWihoutDecimal тыс';
    }

    if (result.toString()[result.toString().length - 1] == '0') {
      final String numWihoutDecimal = result.toStringAsFixed(2).split(".")[0];
      return '$numWihoutDecimal тыс';
    }

    final res = result.toString().split('.');

    return '${res.first} тыс';
  }

  if (value >= 1000000 && value < (1000000 * 10 * 100)) {
    // less than 100 million
    final result = value / 1000000;

    if (result is int) {
      final String numWihoutDecimal = result.toInt().toStringAsFixed(2).split(".")[0];
      return '$numWihoutDecimal млн';
    }

    if (result.toString()[result.toString().length - 1] == '0') {
      final String numWihoutDecimal = result.toStringAsFixed(2).split(".")[0];
      return '$numWihoutDecimal млн';
    }

    final newResult = result.toStringAsFixed(2).split('.');
    if (newResult.length == 2 && newResult.last == '0') {
      return '${result.toStringAsFixed(1)} млн';
    }
    return '${result.toStringAsFixed(1)} млн';
  }

  return '0';
}
