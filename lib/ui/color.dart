import 'dart:ui';
import 'package:flutter/material.dart';

/// Base color
const Color primaryColor = Color(0xFF292861);
const Color primaryColor700 = Color(0xFFC80D0D);
const Color secondaryColor = Color(0xff292860);
const Color secondaryColor_60 = Color(0x99292861); //opacity 60
const Color errorColor = Color(0xFFff4542);
const Color successColor = Color(0xFF21742b);
const gradientMenu = LinearGradient(
  colors: [Color(0xFF292861), Color(0xFF67717A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const gradientPromo = LinearGradient(
  colors: [Color(0xFF2D3C8A), Color(0xFF3A4BA4)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color shimmerColor = Color(0xFFB4B4B4);
const Color shimmerHighlightColor = Color(0xFFFFFFFF);
const Color transparentColor = Color(0xff00ffffff);

// Black
const Color black00 = Color(0xFFFFFFFF);
const Color black50 = Color(0xFFFAFAFA);
const Color black100 = Color(0xFFF4F4F5);
const Color black150 = Color(0xFFFEFFFF);
const Color black200 = Color(0xFFE4E4E7);
const Color black250 = Color(0xFFF5FBFF);
const Color black300 = Color(0xFFD4D4D8);
const Color black350 = Color(0xFFF1F1F9);
const Color black400 = Color(0xFF6B7280);
const Color black450 = Color(0xFFF7F7F7);
const Color black500 = Color(0xFF9B9B9B);
const Color black600 = Color(0xFF52525B);
const Color black650 = Color(0xFF9CA3AF);
const Color black650_20 = Color(0xFF9CA3AF);
const Color black700_70 = Color(0xB2131415); // 70% opacity
const Color black750 = Color(0xFF4B5563);
const Color black750_20 = Color(0xFF4B5563);
const Color black800 = Color(0xFF111827);
const Color black900 = Color(0xFF18181B);
const Color black950 = Color(0xFF000000);
const Color black950_10 = Color(0xFF030712); // 10% opacity

// Navy
const Color navy50 = Color(0xFFE4E9F2);
const Color navy100 = Color(0xFFCCD6E6);
const Color navy200 = Color(0xFFF2F5FD);
const Color navy200_20 = Color(0xFFAABBD633); // 20% opacity
const Color navy300 = Color(0xFFCCE9FF);
const Color navy400 = Color(0xFF0C44FF);
const Color navy500 = Color(0xFF4176E3);
const Color navy500_20 = Color(0xFF2A549933); // 20% opacity
const Color navy600 = Color(0xFF292860);
const Color navy700 = Color(0xFF002A6E);
const Color navy800 = Color(0xFF002158);
const Color navy900 = Color(0xFF001942);

// Orange
const Color orange50 = Color(0xFFFFF5ED);
const Color orange100 = Color(0xFFFE8D4);
const Color orange200 = Color(0xFFCCDA9);
const Color orange200_20 = Color(0xFFCCDA933); // 20% opacity
const Color orange300 = Color(0xFFAA72);
const Color orange400 = Color(0xFFE7F3E);
const Color orange500 = Color(0xFFFFE8D3);
const Color orange500_20 = Color(0xFFD581233); // 20% opacity
const Color orange600 = Color(0xFFFF3800);
const Color orange700 = Color(0xFFFF3800);
const Color orange800 = Color(0xFF9C2310);
const Color orange900 = Color(0xFF7E2010);

// Blue
const Color blue50 = Color(0xFFEEFAFF);
const Color blue100 = Color(0xFFD8F3FF);
const Color blue200 = Color(0xFFBAEBFF);
const Color blue200_20 = Color(0xFFBAEBFF33); // 20% opacity
const Color blue300 = Color(0xFF97F7D1);
const Color blue400 = Color(0xFF4D9A95);
const Color blue500 = Color(0xFF23BCF7);
const Color blue500_20 = Color(0xFF2DB1FF33); // 20% opacity
const Color blue600 = Color(0xFF5040FF);
const Color blue700 = Color(0xFF5433FE);
const Color blue800 = Color(0xFF1362BA);
const Color blue900 = Color(0xFF165492);

// Green
const Color green50 = Color(0xFFF1FBEA);
const Color green100 = Color(0xFFDEF6D1);
const Color green200 = Color(0xFFC0EEA8);
const Color green200_20 = Color(0xFFC0EEA833); // 20% opacity
const Color green300 = Color(0xFF97E076);
const Color green400 = Color(0xFF8FC907);
const Color green500 = Color(0xFF58BF2F);
const Color green500_20 = Color(0xFF58BF2F33); // 20% opacity
const Color green600 = Color(0xFF3E9020);
const Color green700 = Color(0xFF316E1D);
const Color green800 = Color(0xFF2B581C);
const Color green900 = Color(0xFF264B1C);

// Yellow
const Color yellow50 = Color(0xFFFEFBE8);
const Color yellow100 = Color(0xFFFFF7C2);
const Color yellow200 = Color(0xFFFEB88);
const Color yellow200_20 = Color(0xFFFEB8833); // 20% opacity
const Color yellow300 = Color(0xFFFD744);
const Color yellow400 = Color(0xFFF8BA2C);
const Color yellow500 = Color(0xFFFFBC00);
const Color yellow500_20 = Color(0xFFF4AC0433); // 20% opacity
const Color yellow600 = Color(0xFFCE7F00);
const Color yellow700 = Color(0xFFA45A04);
const Color yellow800 = Color(0xFF87460C);
const Color yellow900 = Color(0xFF733910);

// Red
const Color red50 = Color(0xFFFEF4F2);
const Color red100 = Color(0xFFFEE6E2);
const Color red200 = Color(0xFFDD2CB);
const Color red200_20 = Color(0xFFDD2CB33); // 20% opacity
const Color red300 = Color(0xFFBB33A6);
const Color red400 = Color(0xFFF68673);
const Color red500 = Color(0xFFEC5F47);
const Color red500_20 = Color(0xFFEC5F4733); // 20% opacity
const Color red600 = Color(0xFFF54748);
const Color red700 = Color(0xFFB6351F);
const Color red800 = Color(0xFF972F1D);
const Color red900 = Color(0xFF7D2D1F);

// Text
const Color textNeutralPrimary = Color(0xFF09090B);
const Color textDarkPrimary = Color(0xFF1F1F1F);
const Color textDarkSecondary = Color(0xFF757575);
const Color textDarkTertiary = Color(0xFF9E9E9E);
const Color textLightPrimary = Color(0xFFFFFFFF);
const Color textLightSecondary = Color(0xFFE0E0E0);
const Color textNeutralSecondary = Color(0xFF71717A);
const Color textWhitePrimary = Color(0xFFFFFFFF);
const Color textWhiteSecondary = Color(0xFFD4D4D8);
const Color textDisabled = Color(0xFF9E9E9E);
const Color textPrimary = Color(0xFF292861);
const Color textPrimaryPressed = Color(0xFFA50F0F);
const Color textSecondary = Color(0xFFFF530A);
const Color textSecondaryPressed = Color(0xFFF03C06);
const Color textDanger = Color(0xFFE83F3C);
const Color textPressed = Color(0xFF8C2624);
const Color textSuccess = Color(0xFF8FC907);
const Color textSuccessPressed = Color(0xFF6F9D06);
const Color textWarning = Color(0xFFFFBC00);
const Color textWarningPressed = Color(0xFFE29100);
const Color textInfo = Color(0xFF4176E3);
const Color textInfoPressed = Color(0xFF2E54A1);
const Color textButtonPrimary = Color(0xFFFFFFFF);
const Color textButtonSecondaryDefault = Color(0xFF003284);
const Color textButtonSecondaryHover = Color(0xFF002a6e);
const Color textButtonSecondaryPressed = Color(0xFF292861);
const Color textButtonOutlined = Color(0xFF09090B);
const Color textButtonDanger = Color(0xFFFFFFFF);
const Color textButtonSuccess = Color(0xFFFFFFFF);
const Color textButtonWarning = Color(0xFFFFFFFF);

// Icon
const Color iconNeutralPrimary = Color(0xFF18181B);
const Color iconDarkPrimary = Color(0xFF1F1F1F);
const Color iconDarkSecondary = Color(0xFF9E9E9E);
const Color iconDarkTertiary = Color(0xFF9E9E9E);
const Color iconLightPrimary = Color(0xFFFFFFFF);
const Color iconLightSecondary = Color(0xFFE0E0E0);
const Color iconLightDisabled = Color(0xFF9E9E9E);
const Color iconNeutralSecondary = Color(0xFF71717A);
const Color iconWhite = Color(0xFFFFFFFF);
const Color iconDisabled = Color(0xFFa1a1aa);
const Color iconPrimary = Color(0xFF292861);
const Color iconPrimaryPressed = Color(0xFFA50F0F);
const Color iconSecondary = Color(0xFFFF530A);
const Color iconSecondaryPressed = Color(0xFFF03C06);
const Color iconDanger = Color(0xFFE83F3C);
const Color iconDangerPressed = Color(0xFF8C2624);
const Color iconSuccess = Color(0xFF8FC907);
const Color iconSuccessPressed = Color(0xFF6F9D06);
const Color iconWarning = Color(0xFFFFBC00);
const Color iconWarningPressed = Color(0xFFE29100);
const Color iconLoading = Color(0xFFE0E0E0);
const Color iconInfo = Color(0xFF4176E3);
const Color iconInfoPressed = Color(0xFF2E54A1);
const Color iconButtonPrimary = Color(0xFFFFFFFF);
const Color iconTextSecondaryDefault = Color(0xFF003284);
const Color iconButtonSecondaryHover = Color(0xFF002a6e);
const Color iconButtonSecondaryPressed = Color(0xFF002158);
const Color iconButtonOutlined = Color(0xFF09090B);
const Color iconButtonDanger = Color(0xFFFFFFFF);
const Color iconButtonSuccess = Color(0xFFFFFFFF);
const Color iconButtonWarning = Color(0xFFFFFFFF);

// Bg
const Color bg = Color(0xFFFFFFFF);
const Color bgLight = Color(0xFFFFFFFF);
const Color bgDark = Color(0xFF0A0A0A);
const Color bgSurfaceNeutralLight = Color(0xFFF5F5F5);
const Color bgSurfaceNeutralDark = Color(0xFFEDEDED);
const Color bgBlack = Color(0xFF18181B);
const Color bgSurfaceNeutral = Color(0xFFF4F4F5);
const Color bgSurfaceNeutral2 = Color(0xFFE4E4E7);
const Color bgSurfacePrimary = Color(0xFFFFF1F1);
const Color bgSurfaceSecondary = Color(0xFFFFF5ED);
const Color bgSurfaceDanger = Color(0xFFFFECEC);
const Color bgSurfaceSuccess = Color(0xFFFAFDF1);
const Color bgSurfaceWarning = Color(0xFFFFFEF0);
const Color bgSurfaceInfo = Color(0xFFF2F5FD);
const Color bgHoverNeutral = Color(0xFFE4E4E7);
const Color bgHoverPrimary = Color(0xFFCCD6E6);
const Color bgHoverDanger = Color(0xFFFEE6E2);
const Color bgHoverSuccess = Color(0xFFDEF6D1);
const Color bgHoverWarning = Color(0xFFFFF7C2);
const Color bgHoverInfo = Color(0xFFD8F3FF);
const Color bgFillNeutral = Color(0xFF71717A);
const Color bgFillPrimary = Color(0xFFED1515);
const Color bgFillSecondary = Color(0xFFFF7B37);
const Color bgFillDanger = Color(0xFFE83F3C);
const Color bgFillSuccess = Color(0xFF8FC907);
const Color bgFillWarning = Color(0xFFFFBC00);
const Color bgFillInfo = Color(0xFF4176E3);
const Color bgButtonPrimaryDefault = Color(0xFFED1515);
const Color bgButtonPrimaryHover = Color(0xFFC80D0D);
const Color bgButtonPrimaryPressed = Color(0xFFA50F0F);
const Color bgButtonInfoDefault = Color(0xFF4176E3);
const Color bgButtonInfoHover = Color(0xFF3B6BCF);
const Color bgButtonInfoPressed = Color(0xFF2E54A1);
const Color bgButtonSecondaryDefault = Color(0xFFFF530A);
const Color bgButtonSecondaryHover = Color(0xFFF03C06);
const Color bgButtonSecondaryPressed = Color(0xFFF03C06);
const Color bgButtonOutlinedDefault = Color(0xFFFFFFFF);
const Color bgButtonOutlinedHover = Color(0xFFF4F4F5);
const Color bgButtonOutlinedPressed = Color(0xFFE4E4E7);
const Color bgButtonDangerDefault = Color(0xFFE83F3C);
const Color bgButtonDangerHover = Color(0xFFB5312F);
const Color bgButtonDangerPressed = Color(0xFF8C2624);
const Color bgButtonSuccessDefault = Color(0xFF8FC907);
const Color bgButtonSuccessHover = Color(0xFF6F9D06);
const Color bgButtonSuccessPressed = Color(0xFF567A04);
const Color bgButtonWarningDefault = Color(0xFFFFBC00);
const Color bgButtonWarningHover = Color(0xFFE29100);
const Color bgButtonWarningPressed = Color(0xFFBB6602);
const Color bgDisabled = Color(0xFFC2C2C2);
const Color bgButtonContainedDisabled = Color(0xFFC2C2C2);
const Color bgButtonOutlinedDisabled = Color(0xFFEDEDED);
// const Color bgButtonOutlinedDefault   = Color(0xFFFFFFFF);
const Color bgForm = Color(0xFFFFFFFF);
const Color bgModal = Color(0xFFFFFFFF);
const Color bgBackdrop = Color(0x333F3F46);
const Color bgSwitch = Color(0xFFD4D4D8);
const Color bgButtonSwitch = Color(0xFFFFFFFF);
const Color iconBlack = Color(0xFF6B7280);

// Border
const Color borderNeutral = Color(0xFFE4E4E7);
const Color borderNeutralLight = Color(0x1A0A0A0A);
const Color borderNeutralDark = Color(0x290A0A0A);
const Color borderLight = Color(0xFFFFFFFF);
const Color borderDark = Color(0xFF0A0A0A);
const Color borderSurfacePrimary = Color(0xFFFFDFDF);
const Color borderSurfaceSecondary = Color(0xFFFFE8D4);
const Color borderSurfaceDanger = Color(0xFFFFC5C4);
const Color borderSurfaceSuccess = Color(0xFFE1F4B2);
const Color borderSurfaceInfo = Color(0xFFC4D5F6);
const Color borderSurfaceWarning = Color(0xFFFFFAC5);
const Color borderTransparentDark = Color(0xFF0A0A0A0A);
const Color borderTransparentLight = Color(0xFFFFFFFF1F);
const Color borderPrimary = Color(0xFFCCD6E6);
const Color borderSecondary = Color(0xFFFE8D4);
const Color borderDanger = Color(0xFFFEE6E2);
const Color borderSuccess = Color(0xFFDEF6D1);
const Color borderWarning = Color(0xFFFFF7C2);
const Color borderInfo = Color(0xFFD8F3FF);
const Color borderDisabled = Color(0xFFD4D4D8);
const Color borderFillNeutral = Color(0xFF52525B);
const Color borderFillPrimary = Color(0xFFED1515);
const Color borderFillSecondary = Color(0xFFFF530A);
const Color borderFillDanger = Color(0xFF9DDD08);
const Color borderFillSuccess = Color(0xFF3E9020);
const Color borderFillWarning = Color(0xFFFFBC00);
const Color borderFillInfo = Color(0xFF4176E3);
const Color borderButtonOutlinedDefault = Color(0xFFD4D4D8);
const Color borderButtonOutlinedFocused = Color(0xFF404040);
const Color borderButtonOutlinedPressed = Color(0xFFa1a1aa);
const Color borderButtonFocused = Color(0xFF2A549933);
const Color borderButtonDangerFocused = Color(0xFFEC5F4733);
const Color borderButtonSuccessFocused = Color(0xFF58BF2F33);
const Color borderButtonWarningFocused = Color(0xFFF4AC0433);
const Color borderFormDefault = Color(0xFFE4E4E7);
const Color borderFormDanger = Color(0xFFD64026);
const Color borderSelectField = Color(0x14030712);
const Color borderTable = Color(0xA0A0A0A);
const Color tosca = Color(0xFF33A2A9);
const Color bgDeposit = Color(0xFF345BF4);

/// Jacarta
const Color jacarta50 = Color(0xFFf0f0f9);
const Color jacarta100 = Color(0xFFe6e5f5);
const Color jacarta200 = Color(0xFFd7d6f0);
const Color jacarta200_20 = Color(0xFFd7d6f033);
const Color jacarta300 = Color(0xFFb3b1e2);
const Color jacarta400 = Color(0xFF8f8cd3);
const Color jacarta500 = Color(0xFF6a67c5);
const Color jacarta500_20 = Color(0xFF666aee33);
const Color jacarta600 = Color(0xFF4845b5);
const Color jacarta700 = Color(0xFF393790);
const Color jacarta800 = Color(0xFF2b296c);
const Color jacarta900 = Color(0xFF1c1b46);
const Color jacarta950 = Color(0xFF0d0d21);

/// Sunglow
const Color sunglow50 = Color(0xFFfefbe8);
const Color sunglow100 = Color(0xFFfef7c3);
const Color sunglow200 = Color(0xFFfeed8a);
const Color sunglow300 = Color(0xFFfedb46);
const Color sunglow400 = Color(0xFFfbca24);
const Color sunglow500 = Color(0xFFebad07);
const Color sunglow500_20 = Color(0xFFebad0733);
const Color sunglow600 = Color(0xFFcb8503);
const Color sunglow700 = Color(0xFFa15e07);
const Color sunglow800 = Color(0xFF854a0e);
const Color sunglow900 = Color(0xFF713c12);
