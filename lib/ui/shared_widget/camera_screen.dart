import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/shared_widget/custom_button.dart';

import '../color.dart';
import '../typography.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final int maxImages;

  const CameraScreen({
    super.key,
    required this.cameras,
    this.maxImages = 5,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  FlashMode _flashMode = FlashMode.off;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<String> _capturedImages = [];
  bool _isProcessing = false;
  bool _isCamera = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isCamera ? black950 : Color(0xFFFEFFFF),
      body: Stack(
        children: [
          Positioned.fill(
            child: _isCamera ? _buildCameraView() : _buildGalleryView(),
          ),

          if (_isProcessing)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 3,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Memproses foto...",
                        style: mdMedium.copyWith(color: black00),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    SizedBox(height: space450),
                    Center(
                      child: IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            color: black00,
                            border: Border.all(color: primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(borderRadius200),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isCamera = true;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: paddingL,
                                    vertical: paddingS,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _isCamera ? primaryColor : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(borderRadius150),
                                      bottomLeft: Radius.circular(borderRadius150),
                                      topRight: Radius.circular(_isCamera ? 0 : 0),
                                      bottomRight: Radius.circular(_isCamera ? 0 : 0),
                                    ),
                                  ),
                                  child: Text(
                                    "Kamera",
                                    style: xsMedium.copyWith(
                                        color: _isCamera ? black00 : black950),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isCamera = false;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: paddingL,
                                    vertical: paddingS,
                                  ),
                                  decoration: BoxDecoration(
                                    color: !_isCamera ? primaryColor : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(borderRadius150),
                                      bottomRight: Radius.circular(borderRadius150),
                                      topLeft: Radius.circular(!_isCamera ? 0 : 0),
                                      bottomLeft: Radius.circular(!_isCamera ? 0 : 0),
                                    ),
                                  ),
                                  child: Text(
                                      "Galery",
                                      style: xsMedium.copyWith(
                                          color: !_isCamera ? black00 : black950)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomControls(),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraView() {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: CameraPreview(_controller),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: black00),
          );
        }
      },
    );
  }

  Widget _buildGalleryView() {
    return Container(
      color: Color(0xFFFEFFFF),
      child: _capturedImages.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(padding20),
              child: Column(
                children: [
                  Icon(Icons.photo_library_outlined, size: 64, color: black300),
                  SizedBox(height: 16),
                  Text(
                    "Belum ada foto yang dipilih",
                    style: mdRegular.copyWith(color: black600),
                  ),
                  SizedBox(height: space600),
                  CustomButton(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: padding12, horizontal: paddingXL),
                    onPressed: _pickFromGallery,
                    child: Text(
                      "Pilih dari Galeri",
                      style: mdMedium.copyWith(color: black00),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          : Padding(
        padding: EdgeInsets.only(
          top: 140,
          left: 16,
          right: 16,
          bottom: 140,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: _capturedImages.length + (_capturedImages.length < widget.maxImages ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == 0 && _capturedImages.length < widget.maxImages) {
              return GestureDetector(
                onTap: _pickFromGallery,
                child: Container(
                  decoration: BoxDecoration(
                    color: black100.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: black300,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined, color: black600, size: 32),
                      SizedBox(height: 4),
                      Text(
                        "Tambah",
                        style: xsRegular.copyWith(color: black600),
                      ),
                    ],
                  ),
                ),
              );
            }
            final imageIndex = _capturedImages.length < widget.maxImages ? index - 1 : index;

            if (imageIndex < 0 || imageIndex >= _capturedImages.length) {
              return SizedBox.shrink();
            }
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius300),
                  child: Image.file(
                    File(_capturedImages[imageIndex]),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _capturedImages.removeAt(imageIndex);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(padding6),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: navy500.withOpacity(0.3),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: black00,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  left: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: paddingXS, vertical: 3),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: navy500.withOpacity(0.3),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      "${imageIndex + 1}",
                      style: xxsRegular.copyWith(
                        color: black00,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: _isCamera
                ? [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ]
                : [
              black150,
              black150.withOpacity(0.9),
            ],
          ),
        ),
        padding: EdgeInsets.only(bottom: 20, top: 20, left: 16, right: 16),
        child: _isCamera ? _buildCameraControls() : _buildGalleryControls(),
      ),
    );
  }

  Widget _buildCameraControls() {
    return SizedBox(
      height: 70,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: _isProcessing ? null : _takePicture,
              child: Container(
                width: 90,
                height: 90,
                padding: EdgeInsets.all(space100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: black00, width: 4),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: black00,
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _toggleFlash,
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(right: paddingXL),
                    decoration: BoxDecoration(
                      color: black00,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _flashMode == FlashMode.off
                          ? Icons.flash_off
                          : _flashMode == FlashMode.auto
                          ? Icons.flash_auto
                          : Icons.flash_on,
                      size: 26,
                      color: primaryColor,
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: _switchCamera,
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(right: space050),
                    decoration: BoxDecoration(
                      color: black00,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.cameraswitch_rounded,
                      size: 28,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleFlash() async {
    if (!_controller.value.isInitialized) return;

    if (_controller.description.lensDirection == CameraLensDirection.front) {
      setState(() => _flashMode = FlashMode.off);
      await _controller.setFlashMode(FlashMode.off);
      return;
    }

    FlashMode next;
    if (_flashMode == FlashMode.off) {
      next = FlashMode.auto;
    } else if (_flashMode == FlashMode.auto) {
      next = FlashMode.always;
    } else {
      next = FlashMode.off;
    }

    await _controller.setFlashMode(next);

    setState(() {
      _flashMode = next;
    });
  }

  Widget _buildGalleryControls() {
    return CustomButton(
      backgroundColor: _capturedImages.isEmpty ? black300 : primaryColor,
      padding: EdgeInsets.symmetric(vertical: padding16),
      onPressed: _capturedImages.isEmpty
          ? null
          : () {
        Navigator.pop(context, _capturedImages);
      },
      child: Text(
        _capturedImages.isEmpty
            ? "Pilih Foto"
            : "Gunakan ${_capturedImages.length} Foto",
        style: mdSemiBold.copyWith(color: black00),
      ),
    );
  }

  Future<void> _takePicture() async {
    if (_capturedImages.length >= widget.maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maksimal ${widget.maxImages} foto'),
          backgroundColor: red100,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      await Future.delayed(Duration(milliseconds: 500));

      setState(() {
        _capturedImages.add(image.path);
        _isProcessing = false;
        _isCamera = false;
      });
    } catch (e) {
      print('Error taking picture: $e');
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengambil foto'),
          backgroundColor: red100,
        ),
      );
    }
  }

  Future<void> _pickFromGallery() async {
    if (_capturedImages.length >= widget.maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maksimal ${widget.maxImages} foto'),
          backgroundColor: red100,
        ),
      );
      return;
    }

    try {
      final List<XFile> images = await _picker.pickMultiImage();

      if (images.isNotEmpty) {
        final remainingSlots = widget.maxImages - _capturedImages.length;
        final imagesToAdd = images.take(remainingSlots).toList();

        setState(() {
          _capturedImages.addAll(imagesToAdd.map((img) => img.path));
        });

        if (images.length > remainingSlots) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hanya ${remainingSlots} foto yang ditambahkan (maksimal ${widget.maxImages})'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      print('Error picking from gallery: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memilih foto dari galeri'),
          backgroundColor: red100,
        ),
      );
    }
  }

  Future<void> _switchCamera() async {
    final cameras = widget.cameras;
    if (cameras.length < 2) return;

    final currentCamera = _controller.description;
    final newCamera = cameras.firstWhere(
          (camera) => camera != currentCamera,
      orElse: () => cameras[0],
    );

    await _controller.dispose();

    _controller = CameraController(
      newCamera,
      ResolutionPreset.high,
    );

    setState(() {
      _initializeControllerFuture = _controller.initialize();
    });
  }
}