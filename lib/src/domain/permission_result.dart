import 'permission.dart';

sealed class PermissionResult {
  const PermissionResult(this.permission);
  final Permission permission;
}

final class PermissionGranted extends PermissionResult {
  const PermissionGranted(super.permission);

  @override
  String toString() => 'PermissionGranted(${permission.id})';
}

final class PermissionDenied extends PermissionResult {
  const PermissionDenied(super.permission);

  @override
  String toString() => 'PermissionDenied(${permission.id})';
}

final class PermissionPermanentlyDenied extends PermissionResult {
  const PermissionPermanentlyDenied(super.permission);

  @override
  String toString() => 'PermissionPermanentlyDenied(${permission.id})';
}
