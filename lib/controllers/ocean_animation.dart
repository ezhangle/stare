import 'package:rive/rive.dart';

class OceanAnimationController
    extends RiveAnimationController<RuntimeArtboard> {
  late RuntimeArtboard _artboard;

  LinearAnimationInstance? _idle;
  LinearAnimationInstance? _jump;

  bool playJump = false;
  double idleLeft = 0;

  @override
  bool init(RuntimeArtboard core) {
    _artboard = core;
    _idle = _artboard.animationByName("idle");
    _jump = _artboard.animationByName("go");
    isActive = true;
    return _idle != null;
  }

  void stopIdle() {
    _idle?.animation.loop = Loop.oneShot;
    idleLeft = (_idle?.animation.durationSeconds ?? 0) - (_idle?.time ?? 0);
  }

  @override
  void apply(RuntimeArtboard core, double elapsedSeconds) {
    if (playJump) {
      // dolphin jump
      if (_idle?.time != _idle?.animation.durationSeconds) {
        _idle?.animation.apply(_idle!.time, coreContext: core);
        _idle?.advance(elapsedSeconds);
        return;
      }
      _jump?.animation.apply(_jump!.time, coreContext: core);
      _jump?.advance(elapsedSeconds);
    } else {
      // idle loop
      _idle?.animation.apply(_idle!.time, coreContext: core);
      _idle?.advance(elapsedSeconds);
    }
  }
}
