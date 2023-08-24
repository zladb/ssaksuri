import 'package:intl/intl.dart';

import '../const/item_category_list.dart';

class DataUtils {
  static String getENGfromKOR({required String word}) {
    switch (word) {
      case '기타':
        return 'etc';

      // 가구류
      case '침대':
        return 'bed';
      case '장롱':
        return 'closet';
      case '서랍':
        return 'drawers';
      case '책상':
        return 'desk';
      case '의자':
        return 'chair';
      case '옷장':
        return 'wardrobe';

      // 대형 전자제품류
      case '컴퓨터':
        return 'computer';
      case '냉장고':
        return 'refrigerator';
      case '에어컨':
        return 'air-conditioner';
      case '세탁기':
        return 'washing-machine';
      case '건조기':
        return 'dryer';
      case '전자레인지':
        return 'microwave';

      // 소형 전자제품류
      case '선풍기':
        return 'fan';
      case '전기포트':
        return 'kettle';
      case '밥솥':
        return 'rice-cooker';
      case '청소기':
        return 'vacuum';
      case '에어프라이어':
        return 'air-fryer';
      case '믹서기':
        return 'blender';
      case '공기청정기':
        return 'air-purifier';

      // 생활용품류
      case '자전거':
        return 'bycicle';
      case '헬스용품':
        return 'barbell';
      case '거울':
        return 'mirror';
      case '시계':
        return 'clock';
      case '이불':
        return 'blanket';
      case '후라이팬':
        return 'frying-pan';

      default:
        return 'null';
    }
  }

  static List<String> getItemListfromCategory({required String category}) {
    switch (category) {
      // 가구류
      case '가구류':
        return item_labels_gagu;

      case '대형 전자제품류':
        return item_labels_big_electric;

      case '소형 전자제품류':
        return item_labels_small_electric;

      case '생활용품류':
        return item_labels_dairy;

      default:
        return ['null'];
    }
  }

  static int getMileageFromCategory({required String category}){
    switch (category) {
    // 가구류
      case '가구류':
        return 1200;

      case '대형 전자제품류':
        return 1500;

      case '소형 전자제품류':
        return 700;

      case '생활용품류':
        return 500;

      default:
        return 0;
    }
  }

  static String getDateFormatted({required DateTime pickedDate}){
    return DateFormat('yyyy-MM-dd').format(pickedDate);
  }
}
