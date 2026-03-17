sealed class PermissionIdentity {
  const PermissionIdentity(this.value, this.defaultLabel);

  final String value;

  final String defaultLabel;

  @override
  bool operator ==(Object other) =>
      other is PermissionIdentity && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}

// Storage Permissions
final class StoragePermission extends PermissionIdentity {
  const StoragePermission() : super('storage', 'Storage');
}

// Bluetooth Permissions
final class BluetoothPermission extends PermissionIdentity {
  const BluetoothPermission() : super('bluetooth', 'Bluetooth');
}
final class BluetoothScanPermission extends PermissionIdentity {
  const BluetoothScanPermission() : super('bluetooth_scan', 'Bluetooth Scan');
}
final class BluetoothConnectPermission extends PermissionIdentity {
  const BluetoothConnectPermission() : super('bluetooth_connect', 'Bluetooth Connect');
}
final class BluetoothAdvertisePermission extends PermissionIdentity {
  const BluetoothAdvertisePermission() : super('bluetooth_advertise', 'Bluetooth Advertise');
}

// Camera Permissions
final class CameraPermission extends PermissionIdentity {
  const CameraPermission() : super('camera', 'Camera');
}

// Contacts Permissions
final class ContactsPermission extends PermissionIdentity {
  const ContactsPermission() : super('contacts', 'Contacts');
}

// Gallery / Photos Permissions
final class GalleryPermission extends PermissionIdentity {
  const GalleryPermission() : super('gallery', 'Gallery');
}

// Notifications Permissions
final class NotificationsPermission extends PermissionIdentity {
  const NotificationsPermission() : super('notifications', 'Notifications');
}

// Location Permissions
final class LocationPermission extends PermissionIdentity {
  const LocationPermission() : super('location', 'Location');
}
final class LocationAlwaysPermission extends PermissionIdentity {
  const LocationAlwaysPermission() : super('location_always', 'Location Always');
}
final class LocationWhenInUsePermission extends PermissionIdentity {
  const LocationWhenInUsePermission() : super('location_when_in_use', 'Location When In Use');
}


/// Predefined singleton instances for common permissions.
abstract final class Permissions {
  static const storage = StoragePermission();
  static const bluetooth = BluetoothPermission();
  static const bluetoothScan = BluetoothScanPermission();
  static const bluetoothConnect = BluetoothConnectPermission();
  static const bluetoothAdvertise = BluetoothAdvertisePermission();
  static const camera = CameraPermission();
  static const contacts = ContactsPermission();
  static const gallery = GalleryPermission();
  static const notifications = NotificationsPermission();
  static const location = LocationPermission();
  static const locationAlways = LocationAlwaysPermission();
  static const locationWhenInUse = LocationWhenInUsePermission();
}
