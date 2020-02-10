import 'package:flutter/services.dart';

class CustomDigitalInputFormatter extends TextInputFormatter
{

  final int decimalRange;//小数点保留位数

  CustomDigitalInputFormatter({this.decimalRange = 6})
      : assert(decimalRange == null || decimalRange > 0);



  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    // 拿到录入后的字符
    String nValue = newValue.text;
    //当前所选择的文字区域
    TextSelection nSelection = newValue.selection;

    // 先来一波过滤，过滤出数字及小数点
    // 匹配包含数字和小数点的字符
    Pattern p = RegExp(r'(\d+\.?)|(\.?\d+)|(\.?)');
    nValue = p.allMatches(nValue)
        .map<String>((Match match) => match.group(0))
        .join();

    // 用匹配完的字符判断
    if (nValue.startsWith('.')) { //如果小数点开头，我们给他补个0
      nValue = '0.';
    } else if (nValue.contains('.')) {
      //来验证小数点位置
      if (nValue.substring(nValue.indexOf('.') + 1).length > decimalRange) {
        nValue = oldValue.text;
      } else {
        if (nValue.split('.').length > 2) { //多个小数点，去掉后面的
          List<String> split = nValue.split('.');
          nValue = split[0] + '.' + split[1];
        }
      }
    }

    //使光标定位到最后一个字符后面
    nSelection = newValue.selection.copyWith(
      baseOffset: nValue.length,
      extentOffset: nValue.length,
    );

    return TextEditingValue(
        text: nValue,
        selection: nSelection,
        composing: TextRange.empty
    );
  }
}