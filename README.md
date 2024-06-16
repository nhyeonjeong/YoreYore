# YoreYore 리드미

## 🧑🏼‍🍳스크린샷
![YoreYore스크린샷final 001](https://github.com/nhyeonjeong/YoreYore/assets/102401977/5b5103fb-b684-4d38-b771-b9f73e25d863)


## 🧑🏼‍🍳프로젝트 소개
> 레시피를 검색하고 북마크로 자주 하는 레시피를 저장할 수 있는 앱
- iOS 1인 개발
- 개발 기간
    - 기간 : 24.3.8 ~ 24.3.24
    - APP Store 출시 / 현재 v1.1.3 - 지속적으로 업데이트 중
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
- Decoder, Singleton, Access Control, Router Pattern, DTO 
- DiffableDataSource, UICompositionalLayout, UICollectionLayoutListConfiguration, animate

## 🧑🏼‍🍳기술설명
- MVVM InputOutput패턴
    - ViewController과 ViewModel을 Observable 클래스를 사용해 MVVM InputOutput패턴으로 작성
    - 비동기코드를 핸들링 하기 위해 Observable 클래스 내부 값 변경시 클로저 실행하여 반응형 코드 작성
- Alamofire을 사용한 네트워크통신 NetworkManager Singleton패턴으로 구성
    - Generic을 사용해 Decodable한 타입들로 디코딩
    - 통신 결과에 따른 completionHandler실행
    - Router Pattern으로 baseURL, method, endpoint 관리
- 테이블마다 싱글톤 Repository 생성, repository에서 CRD 관리, 필터 처리
- 커서기반 페이지네이션

## 🧑🏼‍🍳트러블슈팅
### `1. API통신 Decoder`

1-1) 문제

API통신으로 레시피 정보를 받아올 때 MANUAL_IMG01 ~ MANUAL_IMG20 으로 사진들을 받고, MANUAL01 ~ MANUAL20으로 글을 받고 있음. Row모델로 Decoding할 때 변수를 40개를 쓰는 것으로 했었지만 모델이 너무 길어지고, 설명이 끝난 다음 ""으로 넘어오는 부분까지 저장된다는 점에서 수정이 필요해 보였음. 또한 받아온 모델을 사용할 때 배열이 아닌 변수로 레시피를 나열하기에는 한계가 있을 것이라고 생각.

1-2) 해결

배열로 레시피설명을 사용하는게 좋다고 판단하여 Decode하는 과정에서 바로 이미지 20개, 글20개의 데이터를 배열로 변환하여 저장.
이미지와 레시피 설명이 들어가는 Manual이라는 구조체를 추가로 만들어 init시점에서 Manual배열을 만들도록 구성.
decoding을 하는 과정에서 이미지와 글 모두 ""으로 넘어왔다면 해당 decoding을 멈추고 manuals 배열에 decoding결과 저장.

<details>
<summary>변경 후 Row 모델</summary>
<div markdown="1">
<img width="473" alt="스크린샷 2024-06-09 오전 3 09 29" src="https://github.com/nhyeonjeong/YoreYore/assets/102401977/cf644291-1a92-4381-ad6f-78c1bd49f675">

<img width="731" alt="스크린샷 2024-06-09 오전 3 10 40" src="https://github.com/nhyeonjeong/YoreYore/assets/102401977/0aa50f6e-9d3c-4e05-9eea-791d33508b62">

</div>
</details>

### `2. updateConstraints메서드를 사용해 Dynamic한 CollectionView 높이 구현`

2-1) 문제

tagList를 구현한 부분에서 tag가 많아지면서 collectionView에서 차지하는 높이가 길어질 때마다 다이나믹하게 높이를 변경해주고 싶었지만, 높이를 다이나믹하게 변경하는 대신 줄이 늘어날 때마다 마지막 줄로 포커스되도록 함.

2-2) 해결

UI를 snapkit으로 레이아웃을 잡고 있었는데 이 라이브러리에 updateConstraints라는 메서드를 알고 collectionview의 contentsize가 변경될 때마다 해당 메서드 실행하여 차지하는 높이만큼 높이 변경.
tag가 추가되어 collectionview를 새로 그릴 때마다 updateConstraints실행.
contentsize가 0일때는 collectionview가 아예 사라지는 문제로 최소 높이가 항상 1을 보장하도록 하는 코드 추가.

<details>
<summary>변경 후 코드</summary>
<div markdown="1">

<img width="728" alt="스크린샷 2024-06-09 오전 3 47 00" src="https://github.com/nhyeonjeong/YoreYore/assets/102401977/af37c831-ef69-49b6-a665-309e49c5a319">

</div>
</details>

### `3. Realm모델과 DiffableSource를 같이 사용하기 위한 DTO`

3-1) 문제

북마크는 Realm에 저장이 되도록 했고, 북마크 화면의 collectionview는 Realm에서 가져온 class객체를 DiffableSource로 구현.
하지만 레시피 상세페이지에서 북마크 해제한 후 북마크화면으로 넘어가면 collectionview를 그리는 과정에서 "Object has been deleted or invalidated" 런타임오류 발생.
DiffableSource에서 apply메서드로 뷰를 그릴 때는 이전상태와 비교해서 snapshot형태로 사진을 찍기 때문에 이미 삭제된 객체로는 접근할 수 없었던 것이 오류의 원인.

3-2) 해결

Realm에서 가져온 데이터는 class타입이었음. class객체는 참조타입이기 때문에 삭제후에 접근하려고 할 때 문제가 일어나므로 struct객체로 collectionview를 그리기로 함.
class타입을 원하는 형태의 구조체 Recipe 타입으로 변경하여 사용.

<details>
<summary>변경 후 코드</summary>
<div markdown="1">

<img width="1082" alt="스크린샷 2024-06-10 오후 11 54 26" src="https://github.com/nhyeonjeong/YoreYore/assets/102401977/bb91754c-49c3-4498-9cb2-6f1c8eb0d28b">


</div>
</details>

## 🧑🏼‍🍳기술회고
Observable Class와 didSet 를 사용해 양방향 데이터 바인딩을 적용하였으나, 다양한 상황에서 비동기 처리 및 Operator 의 필요성을 인지하게 되어 RxSwift/Combine 같은 반응형 프로그래밍 구현을 생각해보게 되었습니다. 
OpenSource 적용 시 샘플 코드를 직접 검토하고 경험해보며 타인의 코드를 이해하고 의도를 파악하는 데 도움이 되었던 것 같고, 뿐만 아니라 타인이 이해하기 쉽도록 스스로 가독성있는 코드를 구성하게 되었던 것 같습니다. 
또 CollectionView List Configuration을 도입해 여러 섹션과 셀을 Dynamic하게 구성하면서 FlowLayout 과 CompositionalLayout의 차이를 인지할 수 있었습니다.
