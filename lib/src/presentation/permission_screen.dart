import 'package:flutter/material.dart';
import '../domain/permission.dart';
import '../domain/permission_identity.dart';
import '../domain/permission_result.dart';
import '../domain/permission_state.dart';

part 'permission_denied_screen.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({
    super.key,
    required this.identity,
    required this.controller,
    required this.granted,
    this.denied,
    this.permanentlyDenied,
    this.loading,
  });

  /// The identity of the permission to request.
  final PermissionIdentity identity;

  /// The provider used to request and check permissions.
  final PermissionState controller;

  /// Builder invoked when the permission is granted.
  final WidgetBuilder granted;

  /// Optional builder invoked when the permission is denied.
  final Widget Function(BuildContext context, VoidCallback retry)? denied;

  /// Optional builder invoked when the permission is permanently denied.
  final Widget Function(BuildContext context, VoidCallback openSettings)? permanentlyDenied;

  /// Optional widget shown while the permission is being requested.
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PermissionResult>(
      stream: controller.watch(Permission(id: identity)),
      builder: (context, snapshot) {
        final result = snapshot.data;

        if (result == null) {
          return loading ??
              const Center(child: CircularProgressIndicator.adaptive());
        }

        return switch (result) {
          PermissionGranted() => granted(context),
          PermissionDenied(:final permission) => denied?.call(context, () => controller.request(permission)) ??
              _PermissionDeniedScreen(
                permission: permission,
                onRetry: () => controller.request(permission),
              ),
          PermissionPermanentlyDenied(:final permission) => permanentlyDenied?.call(context, controller.openSettings) ??
              _PermissionDeniedScreen(
                permission: permission,
                onRetry: controller.openSettings,
                isPermanentlyDenied: true,
              ),
        };
      },
    );
  }
}
