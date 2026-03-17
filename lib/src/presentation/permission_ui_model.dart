import 'package:flutter/widgets.dart';
import '../domain/permission.dart';

class PermissionUiModel {
  const PermissionUiModel({
    this.loadingContent,
    this.grantedContent,
    this.deniedContent,
    this.grantAccessLabel = 'Grant Access',
    this.openSettingsLabel = 'Open Settings',
    this.permissionRequiredMessage = 'Permission is required',
    this.permissionBlockedMessage =
        'Permission is blocked.\nPlease enable it in Settings.',
  });

  final Widget Function(BuildContext context)? loadingContent;
  final Widget Function(BuildContext context)? grantedContent;
  final Widget Function(
          BuildContext context, Permission permission, VoidCallback retry)?
      deniedContent;

  final String grantAccessLabel;
  final String openSettingsLabel;
  final String permissionRequiredMessage;
  final String permissionBlockedMessage;

  /// Global instance for default configuration.
  static PermissionUiModel instance = const PermissionUiModel();
}
