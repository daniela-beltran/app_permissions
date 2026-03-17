import 'package:permission_handler/permission_handler.dart' as ph;
import 'permission_identity.dart';

extension PermissionMapping on PermissionIdentity {
  ph.Permission get toNative => switch (this) {
        StoragePermission() => ph.Permission.storage,
        BluetoothPermission() => ph.Permission.bluetooth,
        BluetoothScanPermission() => ph.Permission.bluetoothScan,
        BluetoothConnectPermission() => ph.Permission.bluetoothConnect,
        BluetoothAdvertisePermission() => ph.Permission.bluetoothAdvertise,
        CameraPermission() => ph.Permission.camera,
        ContactsPermission() => ph.Permission.contacts,
        GalleryPermission() => ph.Permission.photos,
        NotificationsPermission() => ph.Permission.notification,
        LocationPermission() => ph.Permission.location,
        LocationAlwaysPermission() => ph.Permission.locationAlways,
        LocationWhenInUsePermission() => ph.Permission.locationWhenInUse,
      };
}
