import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shantika_agen/ui/shared_widget/custom_card.dart';
import 'package:shantika_agen/ui/shared_widget/network_image_view.dart';
import 'package:with_space_between/with_space_between.dart';

// import '../../features/article/detail_article_screen.dart';
import '../color.dart';
import '../dimension.dart';
import '../typography.dart';
import 'circle_image_view.dart';

class CustomCardArticle extends StatelessWidget {
  final String title;
  final String content;
  final String img;
  final String date;
  final String desc;
  final String slug;

  const CustomCardArticle({
    super.key,
    required this.title,
    required this.content,
    required this.img,
    required this.date,
    required this.desc,
    required this.slug,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: bg,
      borderRadius: BorderRadius.circular(borderRadius500),
      shadow: const [],
      borderSide: BorderSide(color: borderNeutral),
      onTap: () {},
      // => Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => DetailArticleScreen(slug: slug),
      //   ),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(space400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleImageView(
                            radius: 15,
                            url: 'https://avatar.iran.liara.run/public',
                          ),
                          Expanded(
                            child: Text(
                              title,
                              style: smMedium.copyWith(color: textDarkPrimary),
                            ),
                          ),
                        ].withSpaceBetween(width: space300),
                      ),
                      // Text(
                      //   content,
                      //   style: mdBold.copyWith(color: textDarkPrimary),
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 3,
                      // ),
                      HtmlWidget(content),
                    ].withSpaceBetween(height: space200),
                  ),
                ),
                const SizedBox(width: space300),
                ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius200),
                  child: NetworkImageView(
                    url: img,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: xsMedium.copyWith(color: textDarkSecondary),
                ),
                SvgPicture.asset(
                  "assets/images/ic_more.svg",
                  height: 20,
                  width: 20,
                ),
              ],
            ),
            Text(
              desc,
              style: smRegular.copyWith(color: textDarkPrimary),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ].withSpaceBetween(height: space300),
        ),
      ),
    );
  }
}
