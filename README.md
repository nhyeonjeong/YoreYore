# YoreYore 리드미

## 🧑🏼‍🍳스크린샷

## 🧑🏼‍🍳프로젝트 소개
> 레시피를 검색하고 북마크로 자주 하는 레시피를 저장할 수 있는 앱
- iOS 1인 개발
- 개발 기간
    - 기간 : 24.3.8 ~ 24.3.24
    - APP Store 출시 / 현재 v1.1.2 - 지속적으로 업데이트 중
- 개발 환경
    - 최소버전 15.0
    - 세로모드, 라이트모드만 지원
 
## 🧑🏼‍🍳핵심기능
- 재료나 레시피 이름으로 검색기능
- 레시피종류별 검색
- 레시피 상세설명 확인
- 레시피 북마크저장

## 🧑🏼‍🍳사용한 기술스택
- UIKit, CodeBaseUI, MVVM
- Firebase Analytics, Crashlytics
- Alamofire, Realm, Snapkit, Kingfisher, Parchment, Lottie
- Decoder, Singleton, Access Control, Router Pattern, DTO, ATS, 
- DiffableDataSource, UICompositionalLayout, UICollectionLayoutListConfiguration, animate

## 🧑🏼‍🍳기술설명
- MVVM InputOutput패턴
  > ViewController과 ViewModel을 Observable 클래스를 사용해 MVVM InputOutput패턴으로 작성
  > Observable 클래스 내부 값 변경시 클로저 실행
- Alamofire을 사용한 네트워크통신 NetworkManager Singleton패턴으로 구성
  > Generic을 사용해 Decodable한 타입들로 디코딩
  > 통신 결과에 따른 completionHandler실행
  > Router Pattern으로 baseURL, method, endpoint 관리
- 테이블마다 싱글톤 Repository 생성, repository에서 CRD 관리, 필터 처리
- 커서기반 페이지네이션

## 🧑🏼‍🍳기술회고
일기형식으로 쓰지 말고 아쉬운 점

