import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/typography.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ui/shared_widget/custom_card_container.dart';
import '../../ui/shared_widget/show_toast.dart';
import 'cubit/chat_cubit.dart';
import 'cubit/chat_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().fetchChats();
  }

  Future<void> _launchUrl(String url) async {
    try {
      String fixedUrl = url.replaceAll('+', '').replaceAll(' ', '');

      final Uri uri = Uri.parse(fixedUrl);

      if (await canLaunchUrl(uri)) {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        if (!launched && mounted) {
          CustomToast.showError(context, 'Tidak dapat membuka WhatsApp');
        }
      } else {
        if (mounted) {
          CustomToast.showError(context, 'WhatsApp tidak terinstall');
        }
      }
    } catch (e) {
      if (mounted) {
        CustomToast.showError(context, 'Gagal membuka link: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(),
      body: SafeArea(
        child: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is ChatError) {
              CustomToast.showError(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ChatLoaded) {
              if (state.chats.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: iconXXL,
                        color: black300,
                      ),
                      SizedBox(height: space400),
                      Text(
                        'Tidak ada kontak chat',
                        style: mdMedium.copyWith(color: black500),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => context.read<ChatCubit>().refreshChats(),
                child: ListView.builder(
                  padding: EdgeInsets.all(padding16),
                  itemCount: state.chats.length,
                  itemBuilder: (context, index) {
                    final chat = state.chats[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == state.chats.length - 1 ? 0 : padding16,
                      ),
                      child: _chatCard(chat),
                    );
                  },
                ),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: iconXXL,
                    color: black300,
                  ),
                  SizedBox(height: space400),
                  Text(
                    'Tidak ada kontak chat',
                    style: mdMedium.copyWith(color: black500),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _header() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 4),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Chat",
            style: xlBold,
          ),
          centerTitle: true,
        ),
      ),
    );
  }

  Widget _chatCard(dynamic chat) {
    return GestureDetector(
      onTap: () {
        if (chat.link != null && chat.link.isNotEmpty) {
          _launchUrl(chat.link);
        } else {
          CustomToast.showError(context, 'Link tidak tersedia');
        }
      },
      child: CustomCardContainer(
        height: 200,
        padding: EdgeInsets.zero,
        backgroundColor: const Color(0xFFE8D4C0),
        borderRadius: borderRadius400,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius400),
          child: Stack(
            children: [
              Image.network(
                chat.icon ?? '',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: orange400,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 48,
                      color: black950,
                    ),
                  ),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200,
                    color: orange400,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      black950.withOpacity(0.2),
                      black950.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.name?.toUpperCase() ?? 'CHAT',
                      style: mlBold.copyWith(color: black00),
                    ),
                    SizedBox(height: space200),
                    Text(
                      chat.type ?? '',
                      style: smMedium.copyWith(color: black00),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(padding16),
                    bottomRight: Radius.circular(padding16),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: padding12),
                      decoration: BoxDecoration(
                        color: black00.withOpacity(0.2),
                      ),
                      child: Center(
                        child: Text(
                          'Chat Sekarang',
                          style: lgMedium.copyWith(color: black00),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}