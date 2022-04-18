## 목차
- [학습 내용](#학습-내용)
- [요약](#요약)
- [트러블 슈팅](#트러블-슈팅)
- [학습 키워드](#학습-키워드)


## 학습 내용
간단한 DiaryApp을 만들며 `UICollectionView`, `UITabBarController`등의 내용 학습


## 요약

| Index | Detail                                                                                                                                                                                           |
|-------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 시연 영상 | https://youtu.be/uggqDXEr5sk|
| 구현 기간 | **2022.04.16 ~ 2022.04.18**                                                                                                                                                                      |
| 기술 스택 | - Swift                                                                                                                                                                                          |
| 구현 기능 | - `UICollectionView`을 활용해 일기 리스트 보여줌 <br/> - BottomNavigationBar(`UITabBarController`) 라우팅<br> - 하나의 ViewController 내에서 예외처리 작업을 진행해 필요 가능에 따라 다른 컴포넌트와 기능을 제공 (중복 코드 최소화) <br> - MVVM 디자인 패턴 기반 데이터 처리 | 


## 트러블 슈팅
### UICollectionView Layout Issue
```swift
        let layout = UICollectionViewFlowLayout()
          layout.minimumLineSpacing = 10
          layout.scrollDirection = .vertical
          layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
   ```
- UICollectionView를 선언할 때 위와같이 FlowLayout 객체를 만들고 CollectionView에 할당해줘야됨
    - 그렇지 않을 경우 `Exception NSException * "UICollectionView must be initialized with a non-nil layout parameter" 0x000060000266a430` 오류 발생
    - 왜 오류가 발생하는가? -> **collectionView에서 FlowLayout이 왜 필요한지 알아봄<a>(내용 정리)<a/>**

<br>

### UICollectionViewCell Initializer Setting
````swift 
override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
required init?(coder: NSCoder) {
        fatalError("Not implemented required init?(coder: NSCoder)")
   }
````
  - UICollection의 CustomCell을 만들 때 CustomCell 컨텍스트에서는 위와 같이 이니셜라이저 필요
  - What is `init?(coder: NsCoder)` (`NsCoding`)
    - NSCoding은 프로토콜은 구현하려고하는 클래스로부터 실패 가능한 이니셜라이저를 작성하도록 함.
    - UICollectionController 같은 경우 `NsCoding` 프로토콜을 구현하고 있으므로 상속받은 <b>UICollectionViewCell</b>에서도 `init?(coder: NsCoder)`를 구현해야됨.
<br>
    


### How to Create Reuseble Component in Swift
- 공통적인 속성을 가지고 있는 컴포넌트를 선언할 때 중복 코드를 줄이기 위해서 어떤 접근 방식이 필요할지 고민함
1) UI컴포넌트 자체를 넘기는 방식
   ````swift 
   lazy var globalTitleAttr: UILabel = {
       let label = UILabel()
       label.textColor = .black
       label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
       label.translatesAutoresizingMaskIntoConstraints = false

       return label
   }()

   lazy var contentTitle: UILabel = {
       let label = globalTitleAttr
       label.text = "컨텐츠"

       return label
   }()
   ````
  - 위 같은 접근 방식은 AutoLayout Issue가 발생함.<br>
  

  2) 공통 속성 함수를 전달하는 메소드를 만들어 전달

      ````swift 
        func mainLabelAttr(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }
     
        lazy var contentTitle: UILabel = {
        let label = mainLabelAttr(컨텐츠)
        return label
        }()
     ````
     - 이렇게 공통 프로퍼티를 전달할 수 있고 AutoLayout Issue도 발생하지 않음.
<br>


### viewWillAppear
- 탭뷰로 구성된 두 개의 ViewController에서 하나의 ViewModel로 데이터를 공유한다고 했을 때 하나의 ViewController에서 업데이트된 항목을 다른 ViewController에서 어떻게 데이터를 reload 해야될지 고민함.
- TabBarViewController에서 Delegate 패턴으로 각 ViewController를 Reload하려고 했지만 코드가 굉장히 복잡했음.
- 굉장히 간단하게 각 ViewController에 `viewWillAppear`오바라이드  구현하여 탭뷰로 화면이 전환 될 때 필요한 항목을 업데이트 하도록하여 해결할 수 있었음.
```swift
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()

    } 
```



## 학습 키워드
- UICollectionView
  - FlowLayout
- UITabBarController
  - UITabBarControllerDelegate
- TextView
- Reuseble Attribute Method
- MVVM Design Pattern 
- ovveride initializer
- viewWillAppear







