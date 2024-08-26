part of 'circular_slider.dart';

/*
class _CurvePainter extends CustomPainter {
  final double angle;
  final CircularSliderAppearance appearance;
  final double startAngle;
  final double angleRange;

  Offset? handler;
  Offset? center;
  late double radius;

  _CurvePainter(
      {required this.appearance, this.angle = 30, required this.startAngle, required this.angleRange});

  @override
  void paint(Canvas canvas, Size size) {
    radius = math.min(size.width / 2, size.height / 2) -
        appearance.progressBarWidth * 0.5;
    center = Offset(size.width / 2, size.height / 2);

    final progressBarRect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);

    Paint trackPaint;
    if (appearance.trackColors != null) {
      final trackGradient = SweepGradient(
        startAngle: degreeToRadians(appearance.trackGradientStartAngle),
        endAngle: degreeToRadians(appearance.trackGradientStopAngle),
        tileMode: TileMode.mirror,
        colors: appearance.trackColors!,
      );
      trackPaint = Paint()
        ..shader = trackGradient.createShader(progressBarRect)
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.stroke
        ..strokeWidth = appearance.trackWidth;
    } else {
      trackPaint = Paint()
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.stroke
        ..strokeWidth = appearance.trackWidth
        ..color = appearance.trackColor;
    }
    drawCircularArc(
        canvas: canvas,
        size: size,
        paint: trackPaint,
        ignoreAngle: true,
        spinnerMode: appearance.spinnerMode);

    if (!appearance.hideShadow) {
      drawShadow(canvas: canvas, size: size);
    }

    final currentAngle = appearance.counterClockwise ? -angle : angle;
    final dynamicGradient = appearance.dynamicGradient;
    final gradientRotationAngle = dynamicGradient
        ? appearance.counterClockwise
            ? startAngle + 10.0
            : startAngle - 10.0
        : 0.0;
    final GradientRotation rotation =
        GradientRotation(degreeToRadians(gradientRotationAngle));

    final gradientStartAngle = dynamicGradient
        ? appearance.counterClockwise
            ? 360.0 - currentAngle.abs()
            : 0.0
        : appearance.gradientStartAngle;
    final gradientEndAngle = dynamicGradient
        ? appearance.counterClockwise
            ? 360.0
            : currentAngle.abs()
        : appearance.gradientStopAngle;
    final colors = dynamicGradient && appearance.counterClockwise
        ? appearance.progressBarColors.reversed.toList()
        : appearance.progressBarColors;

    final progressBarGradient = kIsWeb
        ? LinearGradient(
            tileMode: TileMode.mirror,
            colors: colors,
          )
        : SweepGradient(
            transform: rotation,
            startAngle: degreeToRadians(gradientStartAngle),
            endAngle: degreeToRadians(gradientEndAngle),
            tileMode: TileMode.mirror,
            colors: colors,
          );

    final progressBarPaint = Paint()
      ..shader = progressBarGradient.createShader(progressBarRect)
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = appearance.progressBarWidth;
    drawCircularArc(canvas: canvas, size: size, paint: progressBarPaint);

// Create a Paint object for the border and fill of the dot
  var dotPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = PackageColors.sliderBlackColor; // Black fill color

  var borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = PackageColors.sliderBorderColor // Red border color
    ..strokeWidth = 4.0; // Adjust border thickness as needed

  // currentAngle = appearance.counterClockwise ? -angle : angle;
  Offset handler = degreesToCoordinates(
      center!, -math.pi / 2 + startAngle + currentAngle + 1.5, radius);

  // Draw the filled circle
  canvas.drawCircle(handler, appearance.handlerSize, dotPaint);

  // Draw the border around the circle
  canvas.drawCircle(handler, appearance.handlerSize, borderPaint);

  // Draw a line inside the dot pointing towards the center
  final linePaint = Paint()
    ..color = PackageColors.sliderGreenColor // Color of the line
    ..strokeWidth = 2.0 // Adjust the thickness of the line
    ..style = PaintingStyle.stroke;

  // Calculate the angle from the handler to the center
  final angleToCenter = math.atan2(center!.dy - handler.dy, center!.dx - handler.dx);

  // Calculate the start and end points of the line
  final lineLength = appearance.handlerSize * 0.4; // Adjust the line length as needed
  final startPoint = Offset(
    handler.dx + lineLength * math.cos(angleToCenter),
    handler.dy + lineLength * math.sin(angleToCenter),
  );
  final endPoint = Offset(
    handler.dx - lineLength * math.cos(angleToCenter),
    handler.dy - lineLength * math.sin(angleToCenter),
  );

  // Draw the line
  canvas.drawLine(startPoint, endPoint, linePaint);


    // var dotPaint = Paint()..color = appearance.dotColor;

    // Offset handler = degreesToCoordinates(
    //     center!, -math.pi / 2 + startAngle + currentAngle + 1.5, radius);
    // canvas.drawCircle(handler, appearance.handlerSize, dotPaint);
  }

  drawCircularArc(
      {required Canvas canvas,
      required Size size,
      required Paint paint,
      bool ignoreAngle = false,
      bool spinnerMode = false}) {
    final double angleValue = ignoreAngle ? 0 : (angleRange - angle);
    final range = appearance.counterClockwise ? -angleRange : angleRange;
    final currentAngle = appearance.counterClockwise ? angleValue : -angleValue;
    canvas.drawArc(
        Rect.fromCircle(center: center!, radius: radius),
        degreeToRadians(spinnerMode ? 0 : startAngle),
        degreeToRadians(spinnerMode ? 360 : range + currentAngle),
        false,
        paint);
  }

  drawShadow({required Canvas canvas, required Size size}) {
    final shadowStep = appearance.shadowStep != null
        ? appearance.shadowStep!
        : math.max(
            1, (appearance.shadowWidth - appearance.progressBarWidth) ~/ 10);
    final maxOpacity = math.min(1.0, appearance.shadowMaxOpacity);
    final repetitions = math.max(1,
        ((appearance.shadowWidth - appearance.progressBarWidth) ~/ shadowStep));
    final opacityStep = maxOpacity / repetitions;
    final shadowPaint = Paint()
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    for (int i = 1; i <= repetitions; i++) {
      shadowPaint.strokeWidth = appearance.progressBarWidth + i * shadowStep;
      shadowPaint.color = appearance.shadowColor
          .withOpacity(maxOpacity - (opacityStep * (i - 1)));
      drawCircularArc(canvas: canvas, size: size, paint: shadowPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

*/


class _CurvePainter extends CustomPainter {
  final double angle;
  final CircularSliderAppearance appearance;
  final double startAngle;
  final double angleRange;

  Offset? handler;
  Offset? center;
  late double radius;

  _CurvePainter(
      {required this.appearance, this.angle = 30, required this.startAngle, required this.angleRange});

  @override
  void paint(Canvas canvas, Size size) {
    radius = math.min(size.width / 2, size.height / 2) -
        appearance.progressBarWidth * 0.5;
    center = Offset(size.width / 2, size.height / 2);

    final progressBarRect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);

    Paint trackPaint;
    if (appearance.trackColors != null) {
      final trackGradient = SweepGradient(
        startAngle: degreeToRadians(appearance.trackGradientStartAngle),
        endAngle: degreeToRadians(appearance.trackGradientStopAngle),
        tileMode: TileMode.mirror,
        colors: appearance.trackColors!,
      );
      trackPaint = Paint()
        ..shader = trackGradient.createShader(progressBarRect)
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.stroke
        ..strokeWidth = appearance.trackWidth;
    } else {
      trackPaint = Paint()
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.stroke
        ..strokeWidth = appearance.trackWidth
        ..color = appearance.trackColor;
    }
    drawCircularArc(
        canvas: canvas,
        size: size,
        paint: trackPaint,
        ignoreAngle: true,
        spinnerMode: appearance.spinnerMode);

    if (!appearance.hideShadow) {
      drawShadow(canvas: canvas, size: size);
    }

    final currentAngle = appearance.counterClockwise ? -angle : angle;
    final dynamicGradient = appearance.dynamicGradient;
    final gradientRotationAngle = dynamicGradient
        ? appearance.counterClockwise
            ? startAngle + 10.0
            : startAngle - 10.0
        : 0.0;
    final GradientRotation rotation =
        GradientRotation(degreeToRadians(gradientRotationAngle));

    final gradientStartAngle = dynamicGradient
        ? appearance.counterClockwise
            ? 360.0 - currentAngle.abs()
            : 0.0
        : appearance.gradientStartAngle;
    final gradientEndAngle = dynamicGradient
        ? appearance.counterClockwise
            ? 360.0
            : currentAngle.abs()
        : appearance.gradientStopAngle;
    final colors = dynamicGradient && appearance.counterClockwise
        ? appearance.progressBarColors.reversed.toList()
        : appearance.progressBarColors;

    final progressBarGradient = kIsWeb
        ? LinearGradient(
            tileMode: TileMode.mirror,
            colors: colors,
          )
        : SweepGradient(
            transform: rotation,
            startAngle: degreeToRadians(gradientStartAngle),
            endAngle: degreeToRadians(gradientEndAngle),
            tileMode: TileMode.mirror,
            colors: colors,
          );

    final progressBarPaint = Paint()
      ..shader = progressBarGradient.createShader(progressBarRect)
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = appearance.progressBarWidth;
    drawCircularArc(canvas: canvas, size: size, paint: progressBarPaint);

    // Create a Paint object for the border of the inner circle
    var borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = PackageColors.lighterOrangeColor // Red border color
      ..strokeWidth = 1; // Adjust border thickness as needed

    // Calculate the radius of the inner circle
    final innerCircleRadius = radius - appearance.trackWidth / 2 - 7; // Adjust as needed

    // Draw the red circle border inside the outer slider bar
    canvas.drawCircle(center!, innerCircleRadius, borderPaint);

    // Create a Paint object for the border and fill of the dot
    var dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = PackageColors.sliderBlackColor; // Black fill color

    var handlerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = PackageColors.sliderBorderColor // Red border color
      ..strokeWidth = 6.0; // Adjust border thickness as needed

    // Calculate the handler position
    Offset handler = degreesToCoordinates(
        center!, -math.pi / 2 + startAngle + currentAngle + 1.5, radius);

    // Draw the filled circle
    canvas.drawCircle(handler, appearance.handlerSize, dotPaint);

    // Draw the border around the circle
    canvas.drawCircle(handler, appearance.handlerSize, handlerPaint);

    // Draw a line inside the dot pointing towards the center
    final linePaint = Paint()
      ..color = PackageColors.sliderGreenColor // Color of the line
      ..strokeWidth = 2.0 // Adjust the thickness of the line
      ..style = PaintingStyle.stroke;

    // Calculate the angle from the handler to the center
    final angleToCenter = math.atan2(center!.dy - handler.dy, center!.dx - handler.dx);

    // Calculate the start and end points of the line
    final lineLength = appearance.handlerSize * 0.3; // Adjust the line length as needed
    final startPoint = Offset(
      handler.dx + lineLength * math.cos(angleToCenter),
      handler.dy + lineLength * math.sin(angleToCenter),
    );
    final endPoint = Offset(
      handler.dx - lineLength * math.cos(angleToCenter),
      handler.dy - lineLength * math.sin(angleToCenter),
    );

    // Draw the line
    canvas.drawLine(startPoint, endPoint, linePaint);
  }

  drawCircularArc(
      {required Canvas canvas,
      required Size size,
      required Paint paint,
      bool ignoreAngle = false,
      bool spinnerMode = false}) {
    final double angleValue = ignoreAngle ? 0 : (angleRange - angle);
    final range = appearance.counterClockwise ? -angleRange : angleRange;
    final currentAngle = appearance.counterClockwise ? angleValue : -angleValue;
    canvas.drawArc(
        Rect.fromCircle(center: center!, radius: radius),
        degreeToRadians(spinnerMode ? 0 : startAngle),
        degreeToRadians(spinnerMode ? 360 : range + currentAngle),
        false,
        paint);
  }

  drawShadow({required Canvas canvas, required Size size}) {
    final shadowStep = appearance.shadowStep != null
        ? appearance.shadowStep!
        : math.max(
            1, (appearance.shadowWidth - appearance.progressBarWidth) ~/ 10);
    final maxOpacity = math.min(1.0, appearance.shadowMaxOpacity);
    final repetitions = math.max(1,
        ((appearance.shadowWidth - appearance.progressBarWidth) ~/ shadowStep));
    final opacityStep = maxOpacity / repetitions;
    final shadowPaint = Paint()
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    for (int i = 1; i <= repetitions; i++) {
      shadowPaint.strokeWidth = appearance.progressBarWidth + i * shadowStep;
      shadowPaint.color = appearance.shadowColor
          .withOpacity(maxOpacity - (opacityStep * (i - 1)));
      drawCircularArc(canvas: canvas, size: size, paint: shadowPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

