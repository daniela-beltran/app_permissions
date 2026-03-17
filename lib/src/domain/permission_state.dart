import 'permission.dart';
import 'permission_result.dart';

abstract interface class PermissionState {
  Future<PermissionResult> request(Permission permission);

  Future<bool> isGranted(Permission permission);

  Stream<PermissionResult> watch(Permission permission);

  Future<void> openSettings();
}
