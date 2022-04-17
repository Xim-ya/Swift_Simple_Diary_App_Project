/*
일기를 추가하는 기능과 일기 수정 찾기 기능을 담당하는 View Controller
이전 View Controller에서 전달 받은 값(isRoutedForDiaryDetail)에 따라 다른 UI 컴퍼넌트와 기능을 제공.
중복 코드를 최소하기 위해 해당 ViewController안에서 예외처리를 진행함.
*/

import UIKit

class AddEditDiaryViewController: UIViewController {
    /* State & Constant Variables */
    let isRoutedForDiaryDetail: Bool
    var diaryVM: DiaryVM?
    let selectedIndex: Int?
    var delegate: UpdateViewDelegate?
    
    
    // Fetch View Model
    init(vm: DiaryVM, isRoutedForDiaryDetail: Bool, selectedIndex: Int?) {
        self.diaryVM = vm
        self.isRoutedForDiaryDetail = isRoutedForDiaryDetail
        self.selectedIndex  = selectedIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    var isEditable = true
    let placeHolders = ["제목을 입력하세요" , "내용을 입력하세요", "날짜를 선택하세요"]
    
    lazy var titleLabel: UILabel = {
        let label = sectionTitleLabelAttr("제목")
        
        return label
    }()
    
    
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
    
    lazy var contentTitleLabel: UILabel = {
        let label = sectionTitleLabelAttr("내용")
        
        return label
    }()
    
    lazy var dateTitleLabel: UILabel = {
        let label = sectionTitleLabelAttr("날짜")
        
        return label
    }()
    
    lazy var contentTextView: UITextView = {
        let textView = roundTableViewAttr()
        textView.delegate = self
        textView.text = placeHolders[1]
        textView.tag = 1
        
        return textView
    }()
    
    lazy var titleTextView: UITextView = {
        let textView = roundTableViewAttr()
        textView.delegate = self
        textView.text = placeHolders[0]
        textView.tag = 0
        textView.textContainer.maximumNumberOfLines = 1
        textView.textContainer.lineBreakMode = .byClipping
        
        return textView
    }()
    
    lazy var dateTextView: UITextView = {
        let textView = roundTableViewAttr()
        textView.delegate = self
        textView.text = "날짜를 선택하세요"
        textView.tag = 2
        textView.isEditable = false
        textView.textContainer.maximumNumberOfLines = 1
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(showDatePickerAlert))
        if !isRoutedForDiaryDetail {
            textView.addGestureRecognizer(gesture)
        }

        return textView
    }()
    
    lazy var addBarBtnItem: UIBarButtonItem = {
        let barBtnItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addDiaryHandler))
        barBtnItem.tintColor = .gray
        barBtnItem.isEnabled = false
        
        return barBtnItem
    }()
    
    lazy var groupButton: UIStackView = {
        var editConfig = UIButton.Configuration.plain()
        editConfig.title = "수정"
        editConfig.baseForegroundColor = .systemBlue

        var delConfig = editConfig
        delConfig.title = "삭제"
        delConfig.baseForegroundColor = .systemRed

        let editBtn = UIButton(configuration: editConfig, primaryAction: nil)
        let delBtn = UIButton(configuration: delConfig, primaryAction: nil)

        let stackView = UIStackView()
        stackView.addArrangedSubview(editBtn)
        stackView.addArrangedSubview(delBtn)
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    lazy var favBarBtn: UIBarButtonItem = {
        let barBtn = UIBarButtonItem(image: nil, style: .done, target: self, action: #selector(toggleFavorite))
        barBtn.tintColor = .systemYellow
        
        return barBtn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(titleTextView)
        view.addSubview(contentTitleLabel)
        view.addSubview(contentTextView)
        view.addSubview(dateTitleLabel)
        view.addSubview(dateTextView)
        self.navigationItem.rightBarButtonItem = addBarBtnItem
        setLayout()
        
        if isRoutedForDiaryDetail {
            setDetailDiaryFeature()
        }
    }
    
    // 즐겨찾기 Toggle 메소드
    @objc private func toggleFavorite() {
        diaryVM?.toggleFavorite(selectedIndex!, favBarBtn)
    }
    
    
    
    // Diary 인스턴스를 호출하여 받아옴
    private func fetchSelectedDiary() {
        let selectedDiary: DiaryVM.Diary = (diaryVM?.selectedDiary(selectedIndex!))!
        titleTextView.text = selectedDiary.title
        titleTextView.textColor = .black
        contentTextView.text = selectedDiary.content
        contentTextView.textColor = .black
        dateTextView.text = selectedDiary.date
        dateTextView.textColor = .black
    }

    // `일기 상세페이지` 기능이 필요할 경우 추가적으로 필요한 기능들을 셋팅
    private func setDetailDiaryFeature() {
        fetchSelectedDiary()
        // GroupButton 설정
        view.addSubview(groupButton)
        groupButton.topAnchor.constraint(equalTo: dateTextView.bottomAnchor, constant: 30).isActive = true
        groupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // RightBarButton 설정
        self.navigationItem.rightBarButtonItem = favBarBtn
        guard let isPassedDiaryFavorite = diaryVM?.selectedDiary(selectedIndex!).isFavorite else { return }
        if isPassedDiaryFavorite {
            favBarBtn.image = UIImage(systemName: "star.fill")
        } else {
            favBarBtn.image = UIImage(systemName: "star")
        }
  
    }
    

    
    private func setLayout() {
        /* Title */
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        /* TextView */
        titleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        titleTextView.layoutIfNeeded()
        
        /* Title */
        contentTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentTitleLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 40).isActive = true
        
        /* TextView */
        let responsiveHeight = view.frame.size.height * 0.2
        contentTextView.topAnchor.constraint(equalTo: contentTitleLabel.bottomAnchor, constant: 6).isActive = true
        contentTextView.heightAnchor.constraint(equalToConstant: responsiveHeight).isActive = true
        contentTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        /* Title */
        dateTitleLabel.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 40).isActive = true
        dateTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        /* TextView */
        dateTextView.topAnchor.constraint(equalTo: dateTitleLabel.bottomAnchor, constant: 6).isActive = true
        dateTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        dateTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
    }
    
    // MARK: Reusble Attribute Functions
    /// Sectino Title
    func sectionTitleLabelAttr(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }
    
    /// Rounded Table View
    func roundTableViewAttr() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.isEditable = !isRoutedForDiaryDetail
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .gray
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        textView.isScrollEnabled = false
        
        return textView
    }
    
    
    
    // MARK: INTENTS
    
    /// Show DatePicker Alert Modal
    @objc private func showDatePickerAlert() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "ko_KO") as Locale
        
        let dateChooserAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubview(datePicker)
        dateChooserAlert.addAction(UIAlertAction(title: "선택완료", style: .cancel, handler: { action in
            let selectedDate = datePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let formattedDateString = dateFormatter.string(from: selectedDate)
            self.dateTextView.text = formattedDateString
            self.dateTextView.textColor = .black
            self.validationCheck()
        }))
        dateChooserAlert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        present(dateChooserAlert, animated: true, completion: nil)
        
    }
    
    /// Validation Check, if Input Filled turn on Toggle Item Button
    private func validationCheck() {
        if isFilledWithInput(titleTextView) && isFilledWithInput(contentTextView) && isFilledWithInput(dateTextView) {
            addBarBtnItem.tintColor = .systemBlue
            addBarBtnItem.isEnabled = true
        } else {
            addBarBtnItem.tintColor = .gray
            addBarBtnItem.isEnabled = false
        }
        
        func isFilledWithInput(_ textView: UITextView) -> Bool {
            textView.textColor == .black && textView.text.count > 0 ? true :  false
        }
    }
    
    /// Add Diary Model Ojbect To View Model Controller
    @objc private func addDiaryHandler() {
        let diary =  DiaryModel.Diary(id: UUID(), title: titleTextView.text, content: contentTextView.text, date: dateTextView.text)
        diaryVM?.addDiary(diary: diary)
        delegate?.reloadCollectionView()
        _ = navigationController?.popToRootViewController(animated: true) // 이전 View Controller로 이동
        
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
}

extension AddEditDiaryViewController: UITextViewDelegate {
    
    // Set TextFiled Interaction Effect.
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView.tag {
        case 0 :
            if titleTextView.text == placeHolders[0] {
                titleTextView.text = nil
                titleTextView.textColor = .black
                
            }
        case 1 :
            if contentTextView.text == placeHolders[1] {
                contentTextView.text = nil
                contentTextView.textColor = .black
            }
        default :
            print("Doesn't Match")
        }
    }
    
    // Reset to TextField Initial Condition If User Doesn't Filled Any Text
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView.tag {
        case 0:
            setInputFieldInteraction(aimTextView: titleTextView, tag: 0)
        case 1:
            setInputFieldInteraction(aimTextView: contentTextView, tag: 1)
        case 2:
            setInputFieldInteraction(aimTextView: dateTextView, tag: 2)
        default :
            print("Doesn't Match")
        }
        
        func setInputFieldInteraction(aimTextView: UITextView, tag: Int) {
            if aimTextView.text.isEmpty {
                aimTextView.text = placeHolders[tag]
                aimTextView.textColor = .gray
            }
            validationCheck()
        }
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        switch textView.tag {
        case 0:
            let result = setTextInputCondition(aimTextView: titleTextView, maxCh: 24)
            return result
        case 1:
            let result = setTextInputCondition(aimTextView: contentTextView, maxCh: 240)
            return result
            
        default :
            print("Doesn't Match")
        }
        
        /* Set Max Character Lenght Condition ANd Show Alert Dialog if it needed */
        func setTextInputCondition(aimTextView: UITextView, maxCh: Int) -> Bool {
            let currentText = aimTextView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
            validationCheck()
            if updatedText.count > maxCh {
                return false
            } else {
                return updatedText.count <= maxCh
            }
            
        }
        return true
    }
    
    /* Alert Dialog */
    private func showMaxCharCountAlert() {
        let alert = UIAlertController(title: "경고", message: "최대 입력 가능한 문자를 초과했습니다.", preferredStyle: .alert)
        let confirmBtn = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(confirmBtn)
        present(alert, animated: true, completion: nil)
    }
}



/// Edit Diary View Controller 에서 사용



