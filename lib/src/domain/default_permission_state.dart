import 'dart:async';
import 'package:flutter/widgets.dart'
    show AppLifecycleState, WidgetsBinding, WidgetsBindingObserver;
import 'package:permission_handler/permission_handler.dart' as ph;

import 'permission.dart';
import 'permission_identity.dart';
import 'permission_result.dart';
import 'permission_state.dart';
import 'permission_mapping_extension.dart';

final class DefaultPermissionState
    with WidgetsBindingObserver
    implements PermissionState {
  DefaultPermissionState() {
    WidgetsBinding.instance.addObserver(this);
  }

  final _streams = <PermissionIdentity, StreamController<PermissionResult>>{};

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (final controller in _streams.values) {
      controller.close();
    }
    _streams.clear();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-evaluate all active permissions when app resumes.
      for (final identity in _streams.keys) {
        _updatePermission(Permission(id: identity));
      }
    }
  }

  @override
  Stream<PermissionResult> watch(Permission permission) {
    final controller = _streams.putIfAbsent(permission.id, () {
      final sc = StreamController<PermissionResult>.broadcast();
      // Trigger initial check.
      _updatePermission(permission);
      return sc;
    });

    return controller.stream;
  }

  Future<void> _updatePermission(Permission permission) async {
    final result = await request(permission);
    _streams[permission.id]?.add(result);
  }

  @override
  Future<PermissionResult> request(Permission permission) async {
    try {
      final nativePermission = permission.id.toNative;
      final status = await nativePermission.request();
      return _mapStatusToResult(permission, status);
    } catch (_) {
      return PermissionDenied(permission);
    }
  }

  @override
  Future<bool> isGranted(Permission permission) async {
    try {
      final status = await permission.id.toNative.status;
      return status == ph.PermissionStatus.granted ||
          status == ph.PermissionStatus.limited;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> openSettings() async {
    await ph.openAppSettings();
  }

  PermissionResult _mapStatusToResult(Permission permission, ph.PermissionStatus status) =>
      switch (status) {
        ph.PermissionStatus.granted || ph.PermissionStatus.limited => PermissionGranted(permission),
        ph.PermissionStatus.permanentlyDenied || ph.PermissionStatus.restricted => PermissionPermanentlyDenied(permission),
        _ => PermissionDenied(permission),
      };
}
