/*
일기를 추가하는 기능과 일기 수정 찾기 기능을 담당하는 View Controller
이전 View Controller에서 전달 받은 값(isRoutedForDiaryDetail)에 따라 다른 UI 컴퍼넌트와 기능을 제공.
중복 코드를 최소하기 위해 해당 ViewController안에서 예외처리를 진행함.
*/

import UIKit

class AddEditDiaryViewController: UIViewController {
    /* State & Constant Variables */
    let isRoutedForDiaryDetail: Bool
    var isEditingMode = false
    var diaryVM: DiaryVM?
    var delegate: UpdateViewDelegate?
    let selectedId: UUID
    
    
    // Fetch View Model
    init(vm: DiaryVM, isRoutedForDiaryDetail: Bool, selectedId: UUID) {
        self.diaryVM = vm
        self.isRoutedForDiaryDetail = isRoutedForDiaryDetail
        self.selectedId = selectedId
        super.init(nibName: nil, bundle: nil)
    }
    
    var isEditable = true
    let placeHolders = ["제목을 입력하세요" , "내용을 입력하세요", "날짜를 선택하세요"]
    
    lazy var titleLabel: UILabel = {
        let label = ReusebleAttribute.sectionTitleLabelAttr("제목")
        
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
        let label = ReusebleAttribute.sectionTitleLabelAttr("내용")
        
        return label
    }()
    
    lazy var dateTitleLabel: UILabel = {
        let label = ReusebleAttribute.sectionTitleLabelAttr("날짜")
        
        return label
    }()
    
    lazy var contentTextView: UITextView = {
        let textView = ReusebleAttribute.roundTableViewAttr(isRoutedForDiaryDetail)
        textView.delegate = self
        textView.text = placeHolders[1]
        textView.tag = 1
        
        return textView
    }()
    
    lazy var titleTextView: UITextView = {
        let textView = ReusebleAttribute.roundTableViewAttr(isRoutedForDiaryDetail)
        textView.delegate = self
        textView.text = placeHolders[0]
        textView.tag = 0
        textView.textContainer.maximumNumberOfLines = 1
        textView.textContainer.lineBreakMode = .byClipping
        
        return textView
    }()
    
    lazy var dateTextView: UITextView = {
        let textView = ReusebleAttribute.roundTableViewAttr(isRoutedForDiaryDetail)
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
    
    lazy var editEndBtn: UIButton = {
        let btn = ReusebleAttribute.singeGroupButton(btnTitle: "수정", color: .systemBlue)
        btn.addTarget(self, action: #selector(turnEditMode), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var delBtn: UIButton = {
        let btn = ReusebleAttribute.singeGroupButton(btnTitle: "삭제", color: .systemRed)
        btn.addTarget(self, action: #selector(deleteDiary), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var groupButton: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(editEndBtn)
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
    
    lazy var completeEditBarBtn: UIBarButtonItem = {
        let barBtn = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(turnEditMode))
        barBtn.tintColor = .systemBlue
        
        return barBtn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [titleLabel, titleTextView, contentTitleLabel, contentTextView, dateTitleLabel, dateTextView].forEach { ele in
            view.addSubview(ele)
        }
        self.navigationItem.rightBarButtonItem = addBarBtnItem
        setLayout()
        
        if isRoutedForDiaryDetail {
            setDetailDiaryFeature()
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
    func validationCheck() {
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
        if isRoutedForDiaryDetail {
            let diary =  DiaryModel.Diary(id: selectedId, title: titleTextView.text, content: contentTextView.text, date: dateTextView.text)
            diaryVM?.editDiary(selectedId, diary)
            delegate?.reloadCollectionView()
            showAlert(title: "수정 완료", message: nil)
        } else {
            let diary =  DiaryModel.Diary(id: UUID(), title: titleTextView.text, content: contentTextView.text, date: dateTextView.text)
            diaryVM?.addDiary(diary: diary)
            delegate?.reloadCollectionView()
            _ = navigationController?.popToRootViewController(animated: true) // 이전 View Controller로 이동
        }
    }
    
    
    /// 즐겨찾기 Toggle 메소드
    @objc private func toggleFavorite() {
        diaryVM?.toggleFavorite(selectedId, favBarBtn)
        delegate?.reloadCollectionView()
    }
    
    
    
    /// Diary 인스턴스를 호출하여 받아옴
    private func fetchSelectedDiary() {
        let selectedDiary: DiaryVM.Diary = (diaryVM?.selectedDiary(selectedId))!
        titleTextView.text = selectedDiary.title
        titleTextView.textColor = .black
        contentTextView.text = selectedDiary.content
        contentTextView.textColor = .black
        dateTextView.text = selectedDiary.date
        dateTextView.textColor = .black
    }

    /// `일기 상세페이지` 기능이 필요할 경우 추가적으로 필요한 기능들을 셋팅
    private func setDetailDiaryFeature() {
        fetchSelectedDiary()
        // GroupButton 설정
        view.addSubview(groupButton)
        groupButton.topAnchor.constraint(equalTo: dateTextView.bottomAnchor, constant: 30).isActive = true
        groupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // RightBarButton 설정
        self.navigationItem.rightBarButtonItem = favBarBtn
        guard let isPassedDiaryFavorite = diaryVM?.selectedDiary(selectedId)?.isFavorite else { return }
        if isPassedDiaryFavorite {
            favBarBtn.image = UIImage(systemName: "star.fill")
        } else {
            favBarBtn.image = UIImage(systemName: "star")
        }
    }
    
    /// GroupButton의 `수정`버튼을 클릭하여 텍스트를 수정 가능하게 함.
    @objc private func turnEditMode() {
        if !isEditingMode {
            toggleActivate(true)
        } else {
            toggleActivate(false)
        }
        
        func toggleActivate(_ turnOn: Bool) {
            isEditingMode = turnOn
            titleTextView.isEditable = turnOn
            contentTextView.isEditable = turnOn
            if turnOn {
                editEndBtn.configuration?.title = "완료"
                let gesture = UITapGestureRecognizer(target: self, action:  #selector(showDatePickerAlert))
                dateTextView.addGestureRecognizer(gesture)
            } else {
                editEndBtn.configuration?.title = "수정"
                let gesture = UITapGestureRecognizer(target: self, action: nil)
                dateTextView.addGestureRecognizer(gesture)
                addDiaryHandler()
            }
        }
    }
    
    /// 일기 삭제
    @objc func deleteDiary() {
        let alert = UIAlertController(title: "경고", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "확인", style: .default) { _ in
            self.diaryVM?.deleteDiary(self.selectedId)
            self.delegate?.reloadCollectionView()
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
}

