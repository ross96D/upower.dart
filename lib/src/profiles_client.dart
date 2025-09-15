// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object ./lib/src/upower.xml

import 'dart:async';
import 'package:dbus/dbus.dart';

/// Signal data for org.freedesktop.UPower.PowerProfiles.ProfileReleased.
class _OrgFreedesktopUPowerPowerProfilesProfileReleased extends DBusSignal {
  int get cookie => values[0].asUint32();

  _OrgFreedesktopUPowerPowerProfilesProfileReleased(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

class _OrgFreedesktopUPowerPowerProfiles extends DBusRemoteObject {
  /// Stream of org.freedesktop.UPower.PowerProfiles.ProfileReleased signals.
  late final Stream<_OrgFreedesktopUPowerPowerProfilesProfileReleased> profileReleased;

  _OrgFreedesktopUPowerPowerProfiles(DBusClient client, String destination, DBusObjectPath path)
      : super(client, name: destination, path: path) {
    profileReleased = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'org.freedesktop.UPower.PowerProfiles',
            name: 'ProfileReleased',
            signature: DBusSignature('u'))
        .asBroadcastStream()
        .map((signal) => _OrgFreedesktopUPowerPowerProfilesProfileReleased(signal));
  }

  /// Sets org.freedesktop.UPower.PowerProfiles.ActiveProfile
  Future<void> setActiveProfile(String value) async {
    await setProperty('org.freedesktop.UPower.PowerProfiles', 'ActiveProfile', DBusString(value));
  }

  /// Sets org.freedesktop.UPower.PowerProfiles.BatteryAware
  Future<void> setBatteryAware(bool value) async {
    await setProperty('org.freedesktop.UPower.PowerProfiles', 'BatteryAware', DBusBoolean(value));
  }

  /// Invokes org.freedesktop.UPower.PowerProfiles.HoldProfile()
  Future<int> callHoldProfile(String profile, String reason, String application_id,
      {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.UPower.PowerProfiles', 'HoldProfile',
        [DBusString(profile), DBusString(reason), DBusString(application_id)],
        replySignature: DBusSignature('u'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asUint32();
  }

  /// Invokes org.freedesktop.UPower.PowerProfiles.ReleaseProfile()
  Future<void> callReleaseProfile(int cookie,
      {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.UPower.PowerProfiles', 'ReleaseProfile', [DBusUint32(cookie)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.UPower.PowerProfiles.SetActionEnabled()
  Future<void> callSetActionEnabled(String action, bool enabled,
      {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.UPower.PowerProfiles', 'SetActionEnabled',
        [DBusString(action), DBusBoolean(enabled)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }
}

enum UPowerProfilePerformanceDegraded {
  /// The computer is sitting on the user's lap
  lapDetected,

  /// The computer is close to overheating
  highOperatingTemperature,

  /// Performance is not degraded
  none,

  /// Performance degraded for an unknown reason
  unrecognized;

  static UPowerProfilePerformanceDegraded from(String value) {
    return switch (value) {
      'lap-detected' => lapDetected,
      'high-operating-temperature' => highOperatingTemperature,
      '' => none,
      String() => unrecognized,
    };
  }
}

class UPowerProfileActionInfo {
  /// Action name
  final String name;

  /// Human-readable description of the action
  final String description;

  /// Boolean indicating whether the action is enabled or not.
  final bool enabled;

  UPowerProfileActionInfo({required this.name, required this.description, required this.enabled});

  factory UPowerProfileActionInfo.from(Map<String, DBusValue> values) {
    return UPowerProfileActionInfo(
      name: values['Name']?.asString() ?? values['Action']?.asString() ?? '',
      description: values['Description']?.asString() ?? '',
      enabled: values['Enabled']?.asBoolean() ?? false,
    );
  }

  @override
  bool operator ==(covariant UPowerProfileActionInfo other) {
    return name == other.name && description == other.description && enabled == other.enabled;
  }

  @override
  int get hashCode => Object.hashAll([name, description, enabled]);
}

/// A list of dictionaries representing the current profile holds.
/// The keys in the dict are "ApplicationId", "Profile" and "Reason", and correspond to
/// the "application_id", "profile" and "reason" arguments passed to the HoldProfile() method.
class UPowerProfileActiveProfileHolds {
  final String applicationId;
  final String profile;
  final String reason;

  UPowerProfileActiveProfileHolds({
    required this.applicationId,
    required this.profile,
    required this.reason,
  });

  factory UPowerProfileActiveProfileHolds.from(Map<String, DBusValue> values) {
    return UPowerProfileActiveProfileHolds(
      applicationId: values['ApplicationId']?.asString() ?? '',
      profile: values['Profile']?.asString() ?? '',
      reason: values['Reason']?.asString() ?? '',
    );
  }

  @override
  bool operator ==(covariant UPowerProfileActiveProfileHolds other) {
    return applicationId == other.applicationId && profile == other.profile && reason == other.reason;
  }

  @override
  int get hashCode => Object.hashAll([applicationId, profile, reason]);
}

class UPowerProfileProfile {
  final String driver;
  final String profile;

  UPowerProfileProfile({required this.driver, required this.profile});

  factory UPowerProfileProfile.from(Map<String, DBusValue> values) {
    return UPowerProfileProfile(
      driver: values['Driver']?.asString() ?? '',
      profile: values['Profile']?.asString() ?? '',
    );
  }

  @override
  bool operator ==(covariant UPowerProfileProfile other) {
    return driver == other.driver && profile == other.profile;
  }

  @override
  int get hashCode => Object.hashAll([driver, profile]);
}

/// Class to manage upower profiles
class UPowerProfile {
  final _OrgFreedesktopUPowerPowerProfiles _object;
  final bool _closeBus;
  StreamSubscription? _propertiesChangedSubscription;
  final _properties = <String, DBusValue>{};
  final _propertiesChangedController = StreamController<List<String>>.broadcast();

  /// This signal will be emitted if the profile is released because the "ActiveProfile" was manually changed.
  /// The signal will only be emitted to the process that originally called "HoldProfile".
  late Stream<int> profileReleased = _object.profileReleased.map((e) => e.cookie);

  /// The type of the currently active profile. It might change automatically if a profile is held,
  /// using the "HoldProfile" function.
  String get activeProfile => _properties['ActiveProfile']?.asString() ?? '';
  set activeProfile(String profile) {
    _object.setActiveProfile(profile);
  }

  /// This will be set if the performance power profile is running in degraded mode,
  /// with the value being used to identify the reason for that degradation.
  /// As new reasons can be added, it is recommended that front-ends show a generic reason
  /// if they do not recognize the value
  UPowerProfilePerformanceDegraded get performanceDegraded =>
      UPowerProfilePerformanceDegraded.from(_properties['PerformanceDegraded']?.asString() ?? '');

  /// An array of key-pair values representing each profile. The key named "Driver" (s) identifies
  /// the power-profiles-daemon backend code used to implement the profile.
  ///
  /// The key named "Profile" (s) will be one of:
  /// - "power-saver" (battery saving profile)
  /// - "balanced" (the default profile)
  /// - "performance" (a profile that does not care about noise or battery consumption)
  ///
  /// Only one of each type of profile will be listed, with the daemon choosing the more
  /// appropriate "driver" for each profile type.
  ///
  /// This list is guaranteed to be sorted in the same order that the profiles are listed above.
  List<UPowerProfileProfile> get profiles =>
      _properties['Profiles']
          ?.asArray()
          .map((v) => UPowerProfileProfile.from(v.asStringVariantDict()))
          .toList() ??
      [];

  /// An array of strings listing each one of the "actions" implemented in the running daemon.
  /// This is used by API users to figure out whether particular functionality is available in a version
  /// of the daemon.
  List<String> get actions => _properties['Actions']?.asStringArray().toList() ?? [];

  /// Info about each action.
  List<UPowerProfileActionInfo> get actionsInfo =>
      _properties['ActionsInfo']
          ?.asArray()
          .map((v) => UPowerProfileActionInfo.from(v.asStringVariantDict()))
          .toList() ??
      [];

  /// A list of dictionaries representing the current profile holds.
  /// The keys in the dict are "ApplicationId", "Profile" and "Reason", and correspond to
  /// the "application_id", "profile" and "reason" arguments passed to the HoldProfile() method.
  List<UPowerProfileActiveProfileHolds> get activeProfileHolds =>
      _properties['ActiveProfileHolds']
          ?.asArray()
          .map((v) => UPowerProfileActiveProfileHolds.from(v.asStringVariantDict()))
          .toList() ??
      [];

  /// The version of the power-profiles-daemon software.
  String get version => _properties['Version']?.asString() ?? '';

  /// Whether the daemon is using upower to detect battery and AC adapter changes.
  bool get batteryAware => _properties['batteryAware']?.asBoolean() ?? false;
  set batteryAware(bool value) {
    _object.setBatteryAware(value);
  }

  /// Stream of property names as they change.
  Stream<List<String>> get propertiesChanged => _propertiesChangedController.stream;

  UPowerProfile({DBusClient? bus})
      : _closeBus = bus == null,
        _object = _OrgFreedesktopUPowerPowerProfiles(
            bus ?? DBusClient.system(),
            'org.freedesktop.UPower.PowerProfiles',
            DBusObjectPath('/org/freedesktop/UPower/PowerProfiles')) {
    //
  }

  Future<void> connect() async {
    // Already connected
    if (_propertiesChangedSubscription != null) {
      return;
    }

    _propertiesChangedSubscription = _object.propertiesChanged.listen((signal) {
      if (signal.propertiesInterface == 'org.freedesktop.UPower.PowerProfiles') {
        _updateProperties(signal.changedProperties);
      }
    });
    _updateProperties(await _object.getAllProperties('org.freedesktop.UPower.PowerProfiles'));
  }

  Future<void> close() async {
    if (_propertiesChangedSubscription != null) {
      await _propertiesChangedSubscription!.cancel();
      _propertiesChangedSubscription = null;
    }
    if (_closeBus) {
      await _object.client.close();
    }
  }

  void _updateProperties(Map<String, DBusValue> properties) {
    _properties.addAll(properties);
    _propertiesChangedController.add(properties.keys.toList());
  }

  /// This sets a particular action to be enabled or disabled. The daemon will only allow the action
  /// to be executed on power state changes if it is enabled.
  Future<void> setActionEnabled(String action, bool enabled) {
    return _object.callSetActionEnabled(action, enabled);
  }

  /// This removes the hold that was set on a profile.
  Future<void> releaseProfile(int cookie) {
    return _object.callReleaseProfile(cookie);
  }

  /// This forces the passed profile (either 'power-saver' or 'performance') to be activated until
  /// either the caller quits, "ReleaseProfile" is called, or the "ActiveProfile" is changed by the user.
  ///
  /// This should be used programmatically by OS components when, eg. high- performance workloads
  /// are started with the "performance" profile, or battery will soon be critically low with
  /// the "power-saver" profile.
  ///
  /// When conflicting profiles are requested to be held, the 'power-saver' profile will be activated
  /// in preference to the 'performance' profile.
  Future<int> holdProfile(String profile, String reason, String applicationId) {
    return _object.callHoldProfile(profile, reason, applicationId);
  }
}
