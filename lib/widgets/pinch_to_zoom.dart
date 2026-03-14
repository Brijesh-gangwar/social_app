import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class PinchToZoom extends StatefulWidget {
  const PinchToZoom({
    super.key,
    required this.child,
    this.overlayBuilder,
    this.borderRadius = BorderRadius.zero,
  });

  final Widget child;
  final WidgetBuilder? overlayBuilder;
  final BorderRadius borderRadius;

  @override
  State<PinchToZoom> createState() => _PinchToZoomState();
}

class _PinchToZoomState extends State<PinchToZoom>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  Rect? _startRect;
  Offset _startFocalPoint = Offset.zero;
  Offset _localFocalPoint = Offset.zero;
  Offset _translation = Offset.zero;
  double _scale = 1.0;
  bool _isZooming = false;
  int _pointerCount = 0;

  late final AnimationController _resetController;
  late final Animation<double> _resetCurve;
  double _resetStartScale = 1.0;
  Offset _resetStartOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    )
      ..addListener(_handleResetTick)
      ..addStatusListener(_handleResetStatus);
    _resetCurve = CurvedAnimation(
      parent: _resetController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _resetController
      ..removeListener(_handleResetTick)
      ..removeStatusListener(_handleResetStatus)
      ..dispose();
    _removeOverlay();
    super.dispose();
  }

  void _handleResetTick() {
    final value = _resetCurve.value;
    _scale = lerpDouble(_resetStartScale, 1.0, value) ?? 1.0;
    _translation = Offset.lerp(_resetStartOffset, Offset.zero, value) ?? Offset.zero;
    _overlayEntry?.markNeedsBuild();
  }

  void _handleResetStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _removeOverlay();
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    if (_pointerCount < 2) return;
    if (_overlayEntry != null) return;

    _resetController.stop();

    _startRect = _getRect();
    _startFocalPoint = details.focalPoint;
    _localFocalPoint = details.localFocalPoint;
    _scale = 1.0;
    _translation = Offset.zero;

    _overlayEntry = _buildOverlay();
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
    _isZooming = true;
    setState(() {});
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (_overlayEntry == null) return;

    _scale = details.scale.clamp(1.0, 4.0);
    _translation = details.focalPoint - _startFocalPoint;
    _overlayEntry?.markNeedsBuild();
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    if (_overlayEntry == null) return;

    _resetStartScale = _scale;
    _resetStartOffset = _translation;
    _resetController.forward(from: 0);
  }

  Rect _getRect() {
    final renderObject = context.findRenderObject();
    if (renderObject is RenderBox) {
      final topLeft = renderObject.localToGlobal(Offset.zero);
      return topLeft & renderObject.size;
    }
    return Rect.zero;
  }

  OverlayEntry _buildOverlay() {
    return OverlayEntry(
      builder: (context) {
        final rect = _startRect ?? Rect.zero;
        final zoomT = ((_scale - 1) / 2).clamp(0.0, 1.0);
        final overlayOpacity =
            lerpDouble(0.12, 0.55, zoomT) ?? (zoomT * 0.55);
        final overlayChild = widget.overlayBuilder?.call(context) ?? widget.child;

        return IgnorePointer(
          ignoring: true,
          child: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black.withOpacity(overlayOpacity),
                ),
              ),
              Positioned.fromRect(
                rect: rect,
                child: Transform(
                  alignment: Alignment.topLeft,
                  transform: Matrix4.identity()
                    ..translate(_translation.dx, _translation.dy)
                    ..translate(_localFocalPoint.dx, _localFocalPoint.dy)
                    ..scale(_scale)
                    ..translate(-_localFocalPoint.dx, -_localFocalPoint.dy),
                  child: ClipRRect(
                    borderRadius: widget.borderRadius,
                    child: overlayChild,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (_isZooming) {
      _isZooming = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _pointerCount += 1,
      onPointerUp: (_) => _pointerCount = max(0, _pointerCount - 1),
      onPointerCancel: (_) => _pointerCount = max(0, _pointerCount - 1),
      child: GestureDetector(
        onScaleStart: _handleScaleStart,
        onScaleUpdate: _handleScaleUpdate,
        onScaleEnd: _handleScaleEnd,
        child: Opacity(
          opacity: _isZooming ? 0.0 : 1.0,
          child: widget.child,
        ),
      ),
    );
  }
}
