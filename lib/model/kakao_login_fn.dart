import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('Kakao Login');

void _getUserInfo() async {
  try {
    User user = await UserApi.instance.me();
    _logger.info(
        '사용자 정보 요청 성공: 회원번호: ${user.id}, 닉네임: ${user.kakaoAccount?.profile?.nickname}');
  } catch (error) {
    _logger.severe('사용자 정보 요청 실패: $error');
  }
}

Future<void> signInWithKakao() async {
  if (await AuthApi.instance.hasToken()) {
    try {
      AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
      _logger.info('토큰 유효성 체크 성공: ${tokenInfo.id} ${tokenInfo.expiresIn}');
      _getUserInfo();
    } catch (error) {
      if (error is KakaoException && error.isInvalidTokenError()) {
        _logger.warning('토큰 만료: $error');
      } else {
        _logger.severe('토큰 정보 조회 실패: $error');
      }

      await loginWithKakaoAccount();
    }
  } else {
    _logger.warning('발급된 토큰 없음');
    await loginWithKakaoAccount();
  }
}

Future<void> loginWithKakaoAccount() async {
  if (await isKakaoTalkInstalled()) {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      _logger.info('카카오톡으로 로그인 성공: ${token.accessToken}');
      _getUserInfo();
    } catch (error) {
      _logger.severe('카카오톡으로 로그인 실패: $error');

      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }

      await _loginWithKakaoAccountFallback();
    }
  } else {
    await _loginWithKakaoAccountFallback();
  }
}

Future<void> _loginWithKakaoAccountFallback() async {
  try {
    OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
    _logger.info('카카오계정으로 로그인 성공: ${token.accessToken}');
    _getUserInfo();
  } catch (error) {
    _logger.severe('카카오계정으로 로그인 실패: $error');
  }
}