import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/typography.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen>
    with TickerProviderStateMixin {
  late MobileScannerController cameraController;
  late AnimationController _torchBlinkController;
  bool _isTorchOn = false;
  bool _hasScanned = false;
  bool _isPermissionGranted = false;
  bool _isDarkEnvironment = false;
  bool _isAutoTorchBlinking = false;
  int _brightnessCheckCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();

    _torchBlinkController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _torchBlinkController.addStatusListener((status) {
      if (_isAutoTorchBlinking && status == AnimationStatus.completed) {
        cameraController.toggleTorch();
        Future.delayed(Duration(milliseconds: 500), () {
          if (_isAutoTorchBlinking && mounted) {
            cameraController.toggleTorch();
            _torchBlinkController.forward(from: 0);
          }
        });
      }
    });
    Future.delayed(Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isDarkEnvironment = true;
        });
        _startAutoTorchBlink();
      }
    });
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      setState(() {
        _isPermissionGranted = true;
      });

      cameraController = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing: CameraFacing.back,
        torchEnabled: false,
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Izin kamera diperlukan untuk scan QR')),
        );
      }
    }
  }

  void _startAutoTorchBlink() {
    if (!_isAutoTorchBlinking) {
      setState(() {
        _isAutoTorchBlinking = true;
      });
      cameraController.toggleTorch();
      _torchBlinkController.forward(from: 0);
    }
  }

  void _stopAutoTorchBlink() {
    if (_isAutoTorchBlinking) {
      setState(() {
        _isAutoTorchBlinking = false;
      });
      _torchBlinkController.stop();
      if (_isTorchOn == false) {
        cameraController.toggleTorch();
      }
    }
  }

  @override
  void dispose() {
    _torchBlinkController.stop();
    _torchBlinkController.dispose();

    if (_isAutoTorchBlinking) {
      _isAutoTorchBlinking = false;
    }

    if (_isPermissionGranted) {
      cameraController.dispose();
    }
    super.dispose();
  }

  void _toggleTorch() {
    setState(() {
      _isTorchOn = !_isTorchOn;
    });

    if (_isAutoTorchBlinking) {
      _stopAutoTorchBlink();
    }

    cameraController.toggleTorch();
  }

  @override
  Widget build(BuildContext context) {
    final scanAreaSize = MediaQuery.of(context).size.width * 0.75;

    return Scaffold(
      backgroundColor: black00,
      appBar: AppBar(
        backgroundColor: black00,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: black950,
            size: iconM,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Scan QR',
          style: xlBold.copyWith(color: black950),
        ),
        centerTitle: false,
      ),
      body: !_isPermissionGranted
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 64, color: black950),
            SizedBox(height: 16),
            Text(
              'Meminta izin kamera...',
              style: lgMedium.copyWith(color: black950),
            ),
          ],
        ),
      )
          : Stack(
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                if (_hasScanned) return;
                _brightnessCheckCount++;
                if (_brightnessCheckCount % 5 == 0 && capture.image != null) {
                  _analyzeBrightnessFromImage(capture.image!);
                }

                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final String? code = barcodes.first.rawValue;
                  if (code != null) {
                    setState(() {
                      _hasScanned = true;
                    });
                    if (_isAutoTorchBlinking) {
                      _stopAutoTorchBlink();
                    }

                    Navigator.pop(context, code);
                  }
                }
              },
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: ScannerOverlayPainter(
                scanAreaSize: scanAreaSize,
                borderColor: black00,
              ),
            ),
          ),

          Center(
            child: Container(
              width: scanAreaSize,
              height: scanAreaSize,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: black00, width: 4),
                          left: BorderSide(color: black00, width: 4),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: black00, width: 4),
                          right: BorderSide(color: black00, width: 4),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: black00, width: 4),
                          left: BorderSide(color: black00, width: 4),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: black00, width: 4),
                          right: BorderSide(color: black00, width: 4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  _isDarkEnvironment
                      ? 'assets/icons/ic_scan_flash_on.svg'
                      : 'assets/icons/ic_scan_flash_off.svg',
                  colorFilter: ColorFilter.mode(
                    black00,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: _toggleTorch,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _isTorchOn ? Icons.flash_on : Icons.flash_off,
                  color: black00,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _analyzeBrightnessFromImage(dynamic image) async {
    try {
      final bytes = await image.bytes;
      if (bytes == null) return;
      int totalBrightness = 0;
      int sampleCount = 0;

      for (int i = 0; i < bytes.length; i += 300) {
        if (i + 2 < bytes.length) {
          int r = bytes[i];
          int g = bytes[i + 1];
          int b = bytes[i + 2];
          int brightness = ((r * 299) + (g * 587) + (b * 114)) ~/ 1000;
          totalBrightness += brightness;
          sampleCount++;
        }
      }

      if (sampleCount > 0) {
        double averageBrightness = totalBrightness / sampleCount;
        bool isDark = averageBrightness < 60;

        if (mounted && _isDarkEnvironment != isDark) {
          setState(() {
            _isDarkEnvironment = isDark;
          });
          if (isDark && !_isTorchOn) {
            _startAutoTorchBlink();
          } else if (!isDark) {
            _stopAutoTorchBlink();
          }
        }
      }
    } catch (e) {
    }
  }
}

class ScannerOverlayPainter extends CustomPainter {
  final double scanAreaSize;
  final Color borderColor;

  ScannerOverlayPainter({
    required this.scanAreaSize,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final scanAreaRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanAreaSize,
      height: scanAreaSize,
    );

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRect(scanAreaRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}