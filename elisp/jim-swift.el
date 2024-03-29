
;;https://github.com/swift-emacs/swift-mode#swift-mode => 用M-x package-install-file安装
;;;; 1. `M-x run-swift`
;; M-x swift-mode:send-region
;; 2. `M-x swift-mode:send-buffer` => 绑定C-c C-k # Lisp化,习惯一样

(add-hook
 'swift-mode-hook
 (lambda ()
   (global-set-key
    (kbd "C-c C-k")
    (lambda ()
      (interactive)
      (push-it-real-good
       "M-x" "swift-mode:send-buffer"
       "<return>") ))))

(add-hook
 'swift-mode-hook
 (lambda ()
   (global-set-key
    (kbd "C-c C-c")
    (lambda ()
      (interactive)
      (push-it-real-good
       "M-x" "swift-mode:send-region"
       "<return>") ))))

;; 放常用的一些swift代码模式片段，Emacs来快速批量编辑，就像当初编辑生成小程序一样的,Elisp结合swfit代码来动态生成代码
(defun flex-row-uikit ()
  (interactive)
  (insert "
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    // stackView.addArrangedSubview(view1)
"))

(defun label-uikit ()
  (interactive)
  (insert "
        let titleView = UILabel()
        titleView.font = UIFont.systemFont(ofSize: 18)
        titleView.text = hulu
        titleView.textColor = .red
        contentView.addSubview(titleView) { make in
            make.top.equalTo(8)
            make.height.equalTo(30)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
"))

(defun button-uikit ()
  (interactive)
  (insert "
        let buttonr2 = UIButton()
        buttonr2.setImage(UIImage(named: \"r2d2\"), for: .normal)
        // view.addSubview(buttonr2) && buttonr2.snp.makeConstraints { (make) ...
        view.addSubview(buttonr2) { make in
            make.width.equalTo(32)
            make.height.equalTo(32)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(-20)
        }
        buttonr2.addTarget(self, action: #selector(didTapR2D2Se), for: .touchUpInside)
        //
        @objc private func didTapR2D2Se() {
        }
"))

(defun alert-uikit  ()
  (interactive)
  (insert "self.showToast(message: aaa)"))

(defun svc-jump-to-swiftui ()
  (interactive)
  (insert "
        let hostingController = UIHostingController(rootView: R2D2SwiftUIView())
        self.navigationController?.pushViewController(hostingController, animated: true)
"))

(defun sfu-jump-to-storyboard-vc ()
  (interactive)
  (insert "
// 会加载故事版的版本
struct R2D2UIKitView: UIViewControllerRepresentable {
    typealias UIViewControllerType = R2D2Controller

    func makeUIViewController(context: Context) -> R2D2Controller {
        let sb = UIStoryboard.init(name: \"HuluStoryboard\", bundle: nil)
        let viewController = sb.instantiateViewController(identifier: \"R2D2Controller\") as! R2D2Controller
        return viewController
    }

    func updateUIViewController(_ uiViewController: R2D2Controller, context: Context) {

    }
}
//
NavigationLink(destination: R2D2UIKitView()) { Text(\"故事版\") }
"))

(defun sfu-jump-to-storyboard-vc2 ()
  (interactive)
  (insert "
//故事版UI加一个UIViewControllerRepresentable代理 => 不加载故事版的UIKit版本
struct R2D2UIKitViewControllerAsSwiftUI: UIViewControllerRepresentable {
  typealias UIViewControllerType = R2D2Controller

  func makeUIViewController(context: Context) -> R2D2Controller {
    return R2D2Controller()
  }

  func updateUIViewController(_ uiViewController: R2D2Controller, context: Context) {
    print(\"update view controller\")
  }
}
// ///
    VStack {
      Text(\"Hello, World!\")
      R2D2UIKitViewControllerAsSwiftUI()
            .frame(width: 300, height: 100)
            .background(.red)
    }
"))

(defun timeout-sw ()
  (interactive)
  (insert "
Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(finishedRefresh), userInfo: nil, repeats: true)
//
    @objc func finishedRefresh () {
        // code
    }
"
          ))

(defun topVC-uikit ()
  (interactive)
  (insert
   "
let topVC = UIApplication.getTopViewController()
topVC?.view.makeToast(message, position: .center)
"
   ))

;;  ===== swift ui dsl => su ! => 用熟悉的东西来生成不熟悉的东西，中间用函数转换一下生成规则就行 => 就像小程序xml的生成一样
(defun flex-column-su ()
  (interactive)                         ;; 或者 HStack
  (insert "VStack {
}.padding(.horizontal, 20.0)
.navigationTitle(\"标题\")"))

(defun flex-row-su ()
  (interactive)
  (insert "ZStack {
}.frame(height: 250.0)
.padding(.top, 60.0)"))

(defun text-su ()
  (interactive)
  (insert "
Text(\"button\")
    .font(.caption)
    .foregroundColor(type.color)
    .padding(.horizontal, 10.0)
    .padding(.vertical, 4.0)
    .overlay(RoundedRectangle(cornerRadius: 16).stroke(type.color, lineWidth: 1))
"))

(defun button-su ()
  (interactive)
  (insert
   "
            Button {
                viewModel.toggleRecognitionStatus()
            } label: {
                Text(\"Start\")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(height: 44.0)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(8.0)
            }
            .disabled(!viewModel.isAuthorized)
            .padding(.bottom, 16.0)
"
   ))

(defun for-erb-su ()
  (interactive)
  (insert "
 ForEach(persons) { person in
     Text(person.name)
 }
 .onMove(perform: $persons.move)
 .onDelete(perform: $persons.remove)
"))

(defun list-su ()
  (interactive)
  (insert "
        List {

        }.navigationBarItems(trailing:
            Button(\"Add\") {
            }
        )
"))

(defun input-su ()
  (interactive)
  (insert "
@State private var name = ""
//
 TextField(\"待办事项\", text: $name)
   .padding()
   .background(Color(UIColor.tertiarySystemFill))
   .cornerRadius(9)
   .font(.system(size: 24, weight: .bold, design: .default))
"))

;; 弹出菜单
(defun pop-menu-su ()
  (interactive)
  (insert "
        Menu(\"Options\") {
            Button(\"Order Now\", action: placeOrder)
            Button(\"Adjust Order\", action: adjustOrder)
            Button(\"Cancel\", action: cancelOrder)
        }
"))

(defun image-su ()
  (interactive)
  (insert "
  Image(uiImage: UIImage(contentsOfFile: documentsPath)!)
     .resizable()
     .aspectRatio(contentMode: .fill)
     .frame(width: 250.0, height: 250.0, alignment: .center)
     .border(Color.blue, width: 3.0)
     .clipped()
"))

;; 静态分析用XCode，编辑和阅读还是Emacs最快，还有批量编辑代码生成
(defun xcode ()
  (interactive)
  (shell-command-to-string (concat "open " (buffer-file-name))))

;; === 模板yas TODO
(defun a1 ()
  (interactive)
  (insert
   "(defun a1 ()
  (interactive)
  (insert \"\"))"
   ))


(provide 'jim-swift)
