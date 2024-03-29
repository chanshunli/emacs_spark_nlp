(defun biancheng-api-jack ()
  (interactive)
  (setq project-name "BCPro/biancheng-api")
  (setq start-cljs-file "/Users/lisp/BCPro/biancheng-api/src/main/cljs/biancheng_breakfast/app.cljs")
  (setq start-clj-file "/Users/lisp/BCPro/biancheng-api/src/main/clojure/biancheng_api/core.clj")
  (call-interactively #'jackj))

(defun datalog-code-semantic-search-jack ()
  (interactive)
  (setq project-name "DatalogPro/datalog-code-semantic-search")
  (setq start-cljs-file "/Users/lisp/DatalogPro/datalog-code-semantic-search/src/cljs/hulunote/core.cljs")
  (setq start-clj-file "/Users/lisp/DatalogPro/datalog-code-semantic-search/src/clj/functor_api/core.clj")
  (call-interactively #'jackj))

(defun functor-api-jack ()
  (interactive)
  (setq project-name "OfCourseIStillLoveYou/hulunote-backend")
  (setq start-cljs-file "/Users/lisp/OfCourseIStillLoveYou/hulunote-backend/src/cljs/hulunote/core.cljs")
  (setq start-clj-file "/Users/lisp/OfCourseIStillLoveYou/hulunote-backend/src/clj/functor_api/core.clj")
  (call-interactively #'jackj))

(defun algorithm-visualizer-jack ()
  (interactive)
  (setq project-name "CljPro/algorithm-visualizer-gpter-fper")
  (setq start-cljs-file "/Users/lisp/CljPro/algorithm-visualizer-gpter-fper/src/main/cljs/functional_programming_visualgo_fp/app.cljs")
  (setq start-clj-file "/Users/lisp/CljPro/algorithm-visualizer-gpter-fper/src/main/clojure/functional_programming_visualgo/core.clj")
  (call-interactively #'jackj))

(defun hulunote-backend-jack ()
  (interactive)
  (setq project-name "hulunote-team/hulunote-backend")
  (setq start-cljs-file "/Users/lisp/hulunote-team/hulunote-backend/src/cljs/hulunote/core.cljs")
  (setq start-clj-file "/Users/lisp/hulunote-team/hulunote-backend/src/clj/functor_api/core.clj")
  (call-interactively #'jackj))

(defun hulunote-en-jack ()
  (interactive)
  (setq project-name "OfCourseIStillLoveYou/hulunote-backend-en")
  (setq start-cljs-file "/Users/lisp/OfCourseIStillLoveYou/hulunote-backend-en/src/cljs/hulunote/core.cljs")
  (setq start-clj-file "/Users/lisp/OfCourseIStillLoveYou/hulunote-backend-en/src/clj/functor_api/core.clj")
  (call-interactively #'jackj))

(defun fp-visualgo-jack ()
  (interactive)
  (setq project-name "CljPro/functional-programming-visualgo")
  (setq start-cljs-file "/Users/lisp/CljPro/functional-programming-visualgo/src/main/cljs/functional_programming_visualgo_fp/app.cljs")
  (setq start-clj-file "/Users/lisp/CljPro/functional-programming-visualgo/src/main/clojure/functional_programming_visualgo/core.clj")
  (call-interactively #'jackj))

;; =========================

(defun biancheng-rider-mini-jack ()
  (interactive)
  (setq miniprogram-project-path "/Users/lisp/WeChatProjects/biancheng-rider")
  (setq miniprogram-file "/Users/lisp/WeChatProjects/biancheng-rider/src/mini_program_cljs_example/core.cljs")
  (call-interactively #'miniprogram-jack))

(defun hulunote-mini-jack ()
  (interactive)
  (setq miniprogram-project-path "/Users/lisp/HuluPro/hulunote-miniprogram")
  (setq miniprogram-file "/Users/lisp/HuluPro/hulunote-miniprogram/src/hulunote/core.cljs")
  (call-interactively #'miniprogram-jack))


(defun datoms-url ()
  (interactive)
  (insert
   "
(def athens-url \"http://127.0.0.1:6688/data/athens.datoms\")
(def help-url   \"http://127.0.0.1:6688/data/help.datoms\")
(def ego-url    \"http://127.0.0.1:6688/data/ego.datoms\")
"))

;; ds-dom的万能钥匙 ;; `ls -R`的功能
;; (pull ?node [:db/id :dom/tag :class {:_child ...}]) ## 反向
;; ;; 递归查询所有的子节点来看看结构对不对,发现h2的子节点没有div:zhihu
(defun ds-dom ()
  (interactive)
  (insert
   "
(pull ?content-node [:db/id :dom/tag :class {:child ...}])
"))

;; 万能的missing
(defun ds-miss ()
  (interactive)
  (insert
   "
[?node _ _]
"))

(defun to-ds ()
  (interactive)
  (insert
   "
(clojure.walk/postwalk
    (fn [x]
      (if (map? x)
        ;; {:nav (:content x)}
        (cond
          (not-empty (:parid x))
          , (do
              {:nav (:content x) :child (:parid x)})
          :else
          , (do
              {:nav (:content x)}))
        x))
    [@(re-frame/subscribe [:get-nav-sub-tree [:id id]])])
"))

(setq my-hulu-api "https://www.hulunote.com/myapi/quick-text-put/7fcbdbafe18e4ff68c02f83254644b82")

(provide 'jim-env)
