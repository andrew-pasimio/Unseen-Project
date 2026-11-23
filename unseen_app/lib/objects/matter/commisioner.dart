import 'peripheral.dart';
/*
* MatterCommissioner class represents a commissioning entity in the Matter protocol.
* It manages a list of peripheral devices and provides methods to add or remove devices to the Thread network.
*/
class MatterCommissioner {
  final String name;
  final String id;
  final List<Peripheral> devices;

  MatterCommissioner({
    required this.name,
    required this.id,
    required this.devices,
  });

  bool addDevice(Peripheral device) {

    if (devices.contains(device)) {
      return false;
    }
    devices.add(device);
    return true;
  }

  bool removeDevice(Peripheral device) {
    return devices.remove(device);
  }

}