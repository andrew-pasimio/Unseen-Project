import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:unseen_app/pages/device_manager.dart';

//
class Moods extends StatelessWidget {
  const Moods({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = 32.0;
    const leafSize = 192.0;

    return Center(
      child: SizedBox(
        width: leafSize * 2 + gap,
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: leafSize,
                  child: Mood(name: 'Happy', icon: Icons.face, direction: 0),
                ),
                const SizedBox(width: gap),
                const SizedBox(
                  width: leafSize,
                  child: Mood(name: 'Sad', icon: Icons.face, direction: 1),
                ),
              ],
            ),
            const SizedBox(height: gap),
            Row(
              children: [
                const SizedBox(
                  width: leafSize,
                  child: Mood(name: 'Angry', icon: Icons.face, direction: 1),
                ),
                const SizedBox(width: gap),
                const SizedBox(
                  width: leafSize,
                  child: Mood(
                    name: 'Surprised',
                    icon: Icons.face,
                    direction: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LeafButton(
          direction: 0,
          icon: Icons.settings,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeviceManagerPage()),
            );
          },
        ),
        const SizedBox(height: 24),
        LeafButton(
          direction: 1,
          icon: Icons.wb_cloudy,
          onPressed: () {
            print('Weather button pressed');
          },
        ),
        const SizedBox(height: 24),
        LeafButton(
          direction: 0,
          icon: Icons.person,
          onPressed: () {
            print('Profile button pressed');
          },
        ),
      ],
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({super.key, this.style});

  final TextStyle? style;

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late DateTime _currentTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _scheduleNextMinute();
  }

  void _scheduleNextMinute() {
    final now = DateTime.now();
    final nextMinute = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute + 1,
    );

    _timer = Timer(nextMinute.difference(now), () {
      if (!mounted) {
        return;
      }

      setState(() {
        _currentTime = DateTime.now();
      });
      _scheduleNextMinute();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hour = _currentTime.hour.toString().padLeft(2, '0');
    final minute = _currentTime.minute.toString().padLeft(2, '0');

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(hour, style: widget.style),
          const SizedBox(height: 8),
          Text(minute, style: widget.style),
        ],
      ),
    );
  }
}

// A mood object contains the representation of a single mood: a list of settings that need to be met.
// Building the mood widget creates a button that will trigger the mood's associated action when pressed.
class Mood extends StatelessWidget {
  // The list of settings that need to be met for this mood.
  //final List<String> settings; // TODO make this translate to a list of actual setting objects

  final String name; // The name of the mood
  final IconData icon; // The icon representing the mood

  final int direction;

  const Mood({
    super.key,
    required this.name,
    required this.icon /*required this.settings*/,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return LeafToggle(
      direction: direction,
      icon: icon,
      onPressed: () {
        // Define the action to be triggered when the mood is pressed
        print('Mood ${name} activated');
      },
    );
  }

  // Removed createElement override as it is not needed for StatelessWidget
}

class LeafSlider extends StatefulWidget {
  const LeafSlider({super.key});

  @override
  State<LeafSlider> createState() => _LeafSliderState();
}

class _LeafSliderState extends State<LeafSlider> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      child: Center(
        child: Row(
          children: [
            Icon(Icons.light_mode_outlined, color: Colors.grey.shade700),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 72,
                  trackShape: const _RectangularTrackShape(),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 16,
                  ),
                  overlayShape: SliderComponentShape.noOverlay,
                  activeTrackColor: Colors.grey.shade700,
                  inactiveTrackColor: Colors.grey.shade300,
                  thumbColor: Colors.green.shade700,
                ),
                child: Slider(
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RectangularTrackShape extends RoundedRectSliderTrackShape {
  const _RectangularTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    double additionalActiveTrackHeight = 0,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final canvas = context.canvas;
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final trackPaint = Paint()..color = sliderTheme.inactiveTrackColor!;
    final activePaint = Paint()..color = sliderTheme.activeTrackColor!;

    final trackRRect = BorderRadius.only(
      topLeft: const Radius.circular(32),
      bottomRight: const Radius.circular(32),
    ).toRRect(trackRect);
    canvas.drawRRect(trackRRect, trackPaint);
    final activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );
    canvas.drawRRect(
      BorderRadius.only(topLeft: const Radius.circular(32)).toRRect(activeRect),
      activePaint,
    );
  }
}

class LeafToggle extends StatefulWidget {
  final int direction;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? size;

  const LeafToggle({
    super.key,
    required this.direction,
    this.icon,
    this.onPressed,
    this.size,
  });

  @override
  State<LeafToggle> createState() => _LeafToggleState();
}

// TO DO make it toggleable
class _LeafToggleState extends State<LeafToggle> {
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(widget.direction == 1 ? 32 : 0),
      bottomLeft: Radius.circular(widget.direction == 0 ? 32 : 0),
      topRight: Radius.circular(widget.direction == 0 ? 32 : 0),
      bottomRight: Radius.circular(widget.direction == 1 ? 32 : 0),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: borderRadius,
        child: Ink(
          width: widget.size ?? 192,
          height: widget.size ?? 192,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: borderRadius,
          ),
          child: widget.icon == null ? null : Icon(widget.icon),
        ),
      ),
    );
  }
}

// Same as a LeafToggle but without the stateful behavior.
class LeafButton extends StatelessWidget {
  final int direction;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? size;
  const LeafButton({
    super.key,
    required this.direction,
    this.icon,
    this.onPressed,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(direction == 1 ? 32 : 0),
      bottomLeft: Radius.circular(direction == 0 ? 32 : 0),
      topRight: Radius.circular(direction == 0 ? 32 : 0),
      bottomRight: Radius.circular(direction == 1 ? 32 : 0),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Ink(
          width: size ?? 192,
          height: size ?? 192,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: borderRadius,
          ),
          child: icon == null ? null : Icon(icon),
        ),
      ),
    );
  }
}

class BackgroundImageWidget extends StatefulWidget {
  const BackgroundImageWidget({super.key, required this.child});

  final Widget child;

  @override
  State<BackgroundImageWidget> createState() => _BackgroundImageWidgetState();
}

class _BackgroundImageWidgetState extends State<BackgroundImageWidget> {
  bool _hasInteracted = false;
  Timer? _sleepTimer;
  // TIMER
  static const duration = const Duration(seconds: 30);

  void _wake() {
    _sleepTimer?.cancel();
    if (!_hasInteracted) {
      setState(() {
        _hasInteracted = true;
      });
    }
    _sleepTimer = Timer(duration, () {
      if (!mounted) {
        return;
      }

      setState(() {
        _hasInteracted = false;
      });
    });
  }

  @override
  void dispose() {
    _sleepTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      'lib/materials/images/background_1.jpg',
      fit: BoxFit.cover,
    );

    return Listener(
      onPointerDown: (_) => _wake(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: _hasInteracted ? 6 : 0),
            duration: const Duration(milliseconds: 500),
            builder: (context, sigma, child) {
              return ClipRect(
                child: Transform.scale(
                  scale: 1 + sigma / 100,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                    child: child,
                  ),
                ),
              );
            },
            child: image,
          ),
          IgnorePointer(
            ignoring: !_hasInteracted,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _hasInteracted ? 1 : 0,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
