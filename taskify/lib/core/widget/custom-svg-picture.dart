import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Customsvgpicture extends StatelessWidget {
  const Customsvgpicture({super.key,
  required this.path,
  this.height,
  this.width,
  //هيك هو راح يلون حسب الثيم لكن لو فولس راح يترك الصورة بلونها الاصلى
  this.withColorFilter=true
  
  });
  //named constructor
  const Customsvgpicture.withColorFilter({
  required this.path,
   this.height,
   this.width,
   }):withColorFilter=false;

  final String path;
  final bool withColorFilter;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path,
      colorFilter:withColorFilter? ColorFilter.mode(Theme.of(context).colorScheme.secondary,
    BlendMode.srcIn
              
               ):null,
              );
  }
}