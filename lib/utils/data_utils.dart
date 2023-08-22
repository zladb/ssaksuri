import '../const/item_category_list.dart';

class DataUtils {
  static String getENGfromKOR({required String word}) {
    switch (word) {
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

      // 전자제품류
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

      default:
        return 'null';
    }
  }

  static List<String> getListfromCategory({required String category}) {
    switch (category) {
      // 가구류
      case '가구류':
        return item_category_gagu;

      case '전자제품류':
        return item_category_electric;

      default:
        return ['null'];
    }
  }
}
