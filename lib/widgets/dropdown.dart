import 'package:flutter/material.dart';

class ConfigurationData {
  final int countryId;
  final String countryCode;
  final String mobileAppURL;
  final String applicationUIURL;
  final String product;
  final String clientID;
  final String clientRequestID;
  final String communityCode;
  final String environment;
  final bool isActive;
  final String createdOn;
  final String? updatedOn;
  final int createdBy;
  final int updatedBy;

  ConfigurationData({
    required this.countryId,
    required this.countryCode,
    required this.mobileAppURL,
    required this.applicationUIURL,
    required this.product,
    required this.clientID,
    required this.clientRequestID,
    required this.communityCode,
    required this.environment,
    required this.isActive,
    required this.createdOn,
    this.updatedOn,
    required this.createdBy,
    required this.updatedBy,
  });

  factory ConfigurationData.fromJson(Map<String, dynamic> json) {
    return ConfigurationData(
      countryId: json['CountryId'],
      countryCode: json['CountryCode'],
      mobileAppURL: json['MobileAppURL'],
      applicationUIURL: json['ApplicationUIURL'],
      product: json['Product'],
      clientID: json['ClientID'],
      clientRequestID: json['ClientRequestID'],
      communityCode: json['CommunityCode'],
      environment: json['Environment'],
      isActive: json['IsActive'],
      createdOn: json['CreatedOn'],
      updatedOn: json['UpdatedOn'],
      createdBy: json['CreatedBy'],
      updatedBy: json['UpdatedBy'],
    );
  }
}

class CountryDropdown extends StatefulWidget {
  final List<ConfigurationData> countries;
  final Function(ConfigurationData?) onChanged;
  final ConfigurationData? initialValue;

  const CountryDropdown({
    Key? key,
    required this.countries,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  ConfigurationData? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            value: _selectedCountry?.countryCode,
            isExpanded: true,
            hint: const Text(
              'Select Region',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black54,
            ),
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            onChanged: (String? newValue) {
              if (newValue != null) {
                final selectedCountry = widget.countries.firstWhere(
                      (country) => country.countryCode == newValue,
                  orElse: () => widget.countries.first,
                );

                setState(() {
                  _selectedCountry = selectedCountry;
                });

                widget.onChanged(selectedCountry);
              } else {
                setState(() {
                  _selectedCountry = null;
                });
                widget.onChanged(null);
              }
            },
            items: widget.countries.map<DropdownMenuItem<String>>((ConfigurationData country) {
              return DropdownMenuItem<String>(
                value: country.countryCode,
                child: Text(country.countryCode),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
