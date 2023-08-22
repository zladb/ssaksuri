
class DataUtils {
  static String getENGfromKOR({required String word}) {
    switch (word) {
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
      default:
        return 'null';
    }
  }
}