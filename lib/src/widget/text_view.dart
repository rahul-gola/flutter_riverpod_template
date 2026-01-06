import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextView extends StatelessWidget {
  const TextView(
    this.text, {
    super.key,
    this.fontSize = 16,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize.sp),
      ),
    );
  }
}

// class TextView extends StatelessWidget {
//   const TextView(
//     String this.data, {
//     super.key,
//     this.style,
//     this.strutStyle,
//     this.textAlign,
//     this.textDirection,
//     this.locale,
//     this.softWrap,
//     this.overflow,
//     this.textScaleFactor,
//     this.textScaler,
//     this.maxLines,
//     this.semanticsLabel,
//     this.semanticsIdentifier,
//     this.textWidthBasis,
//     this.textHeightBehavior,
//     this.selectionColor,
//     this.textSpan,
//   });
//
//   final String? data;
//
//   final InlineSpan? textSpan;
//
//   final TextStyle? style;
//
//   /// {@macro flutter.painting.textPainter.strutStyle}
//   final StrutStyle? strutStyle;
//
//   /// How the text should be aligned horizontally.
//   final TextAlign? textAlign;
//
//   final TextDirection? textDirection;
//
//   final Locale? locale;
//
//   final bool? softWrap;
//
//   final TextOverflow? overflow;
//
//   final double? textScaleFactor;
//
//   final TextScaler? textScaler;
//
//   final int? maxLines;
//
//   final String? semanticsLabel;
//
//   final String? semanticsIdentifier;
//
//   /// {@macro flutter.painting.textPainter.textWidthBasis}
//   final TextWidthBasis? textWidthBasis;
//
//   /// {@macro dart.ui.textHeightBehavior}
//   final ui.TextHeightBehavior? textHeightBehavior;
//
//   final Color? selectionColor;
//
//   @override
//   Widget build(BuildContext context) {
//     final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
//     TextStyle? effectiveTextStyle = style;
//     if (style == null || style!.inherit) {
//       effectiveTextStyle = defaultTextStyle.style.merge(style);
//     }
//     if (MediaQuery.boldTextOf(context)) {
//       effectiveTextStyle = effectiveTextStyle!.merge(
//         const TextStyle(fontWeight: FontWeight.bold),
//       );
//     }
//
//     final TextScaler textScaler = switch ((this.textScaler, textScaleFactor)) {
//       (final TextScaler textScaler, _) => textScaler,
//       // For unmigrated apps, fall back to textScaleFactor.
//       (null, final double textScaleFactor) => TextScaler.linear(
//         textScaleFactor,
//       ),
//       (null, null) => MediaQuery.textScalerOf(context),
//     };
//     Widget result = RichText(
//       textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
//       textDirection: textDirection,
//       // RichText uses Directionality.of to obtain a default if this is null.
//       locale: locale,
//       // RichText uses Localizations.localeOf to obtain a default if this is null
//       softWrap: softWrap ?? defaultTextStyle.softWrap,
//       overflow:
//           overflow ?? effectiveTextStyle?.overflow ?? defaultTextStyle.overflow,
//       textScaler: textScaler,
//       maxLines: maxLines ?? defaultTextStyle.maxLines,
//       strutStyle: strutStyle,
//       textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
//       textHeightBehavior:
//           textHeightBehavior ??
//           defaultTextStyle.textHeightBehavior ??
//           DefaultTextHeightBehavior.maybeOf(context),
//       selectionColor:
//           selectionColor ??
//           DefaultSelectionStyle.of(context).selectionColor ??
//           DefaultSelectionStyle.defaultColor,
//       text: TextSpan(
//         style: effectiveTextStyle,
//         text: data,
//         children: textSpan != null ? <InlineSpan>[textSpan!] : null,
//       ),
//     );
//
//     if (semanticsLabel != null || semanticsIdentifier != null) {
//       result = Semantics(
//         textDirection: textDirection,
//         label: semanticsLabel,
//         identifier: semanticsIdentifier,
//         child: ExcludeSemantics(
//           excluding: semanticsLabel != null,
//           child: result,
//         ),
//       );
//     }
//     return result;
//   }
// }
