import 'package:flutter/material.dart';
import '../screens/login/model/login_response_model.dart';

class OrganizationService {
  static LoginDetails? _currentUser;

  static void setUserData(LoginDetails userData) {
    _currentUser = userData;
  }

  static LoginDetails? get currentUser => _currentUser;

  static String get orgTypeName => _currentUser?.orgTypeName ?? '';

  static const String CHEMISTRY_DEPARTMENT = 'Chemistry Department';
  static const String CUSTOMS = 'Customs';
  static const String IMMIGRATION = 'Immigration';
  static const String MARINE_DEPARTMENT = 'Marine Department';
  static const String MINISTRY = 'Ministry';
  static const String POLICE = 'Police';
  static const String PORT_AUTHORITY = 'Port Authority';
  static const String PORT_HEALTH = 'Port Health';
  static const String PORT_TERMINAL_OPERATOR = 'Port/Terminal Operator';
  static const String PRIVATE_JETTY = 'Private Jetty';
  static const String SHIPPING_AGENT = 'Shipping Agent';

  static bool get isMarineDepartment => orgTypeName == MARINE_DEPARTMENT;
  static bool get isCustoms => orgTypeName == CUSTOMS;
  static bool get isImmigration => orgTypeName == IMMIGRATION;
  static bool get isPolice => orgTypeName == POLICE;
  static bool get isPortAuthority => orgTypeName == PORT_AUTHORITY;
  static bool get isPortHealth => orgTypeName == PORT_HEALTH;
  static bool get isChemistryDepartment => orgTypeName == CHEMISTRY_DEPARTMENT;
  static bool get isMinistry => orgTypeName == MINISTRY;
  static bool get isPortTerminalOperator => orgTypeName == PORT_TERMINAL_OPERATOR;
  static bool get isPrivateJetty => orgTypeName == PRIVATE_JETTY;
  static bool get isShippingAgent => orgTypeName == SHIPPING_AGENT;

  static bool get isGovernmentAgency => [
    MARINE_DEPARTMENT,
    CUSTOMS,
    IMMIGRATION,
    POLICE,
    PORT_AUTHORITY,
    PORT_HEALTH,
    CHEMISTRY_DEPARTMENT,
    MINISTRY
  ].contains(orgTypeName);


}


class RoleConditionWidget extends StatelessWidget {
  final Widget child;
  final bool condition;
  final Widget? fallback;

  const RoleConditionWidget({
    Key? key,
    required this.child,
    required this.condition,
    this.fallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return child;
    }
    return fallback ?? const SizedBox.shrink();
  }
}



//
// bool isVisibleForCurrentRole(String roleId) {
//   final org = loginDetailsMaster.orgTypeName;
//   switch (org) {
//     case 'Marine Department':
//       return roleId == 'marin-dept' ;
//     case 'Port Authority':
//       return roleId == 'portCard';
//     case 'Logistics':
//       return roleId == 'logisticsCard' || roleId == 'sharedCard';
//     default:
//       return false;
//   }
// }