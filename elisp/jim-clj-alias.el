(defun eval-clj-code (clj-code)
  "in clj repl:  (eval-clj-code \"(map inc [1 2 3])\") => [2 3 4]
   in cljs repl: (eval-clj-code \"(js/console.log 11111)\")"
  (interactive)
  (thread-first
      (cider-nrepl-sync-request:eval
       clj-code)
    (nrepl-dict-get "value")
    (read)))

(defun appdb ()
  (interactive)
  (eval-clj-code "(cljs.pprint/pprint @re-frame.db/app-db)"))

(defun insert-appdb ()
  (interactive)
  (insert "(cljs.pprint/pprint @re-frame.db/app-db)"))

(defun page-reload ()
  (interactive)
  (eval-clj-code "(.reload js/location)"))

(defun clear-storage ()
  (interactive)
  (eval-clj-code "(.clear js/localStorage)"))

(defun interpreter-list ()
  "用万能的list树和Postwalk解释器算法来写算法"
  (interactive)
  (insert "(clojure.walk/postwalk-demo [[1 2] [3 4 [5 6]] [7 8]])"))

(defun print-tree ()
  "打印树的结构先后顺序"
  (interactive)
  (insert "
(defn print-tree [original]
  (loop [loc (zip/seq-zip (seq original))]
    (if (zip/end? loc)
      (zip/root loc)
      (recur (zip/next
                (do (println (zip/node loc))
                    loc))))))
(print-tree [1 '(a (i ii iii) c) 2])
"
))


(defun postwalk-any ()
  "通过类型特征工程来cond递归解释 => 深度学习自动化特征工程"
  (interactive)
  (insert  "
  (clojure.walk/postwalk
   (fn [x]
       (cond
        (vector? x) (prn (str \"Walked: \" x))
        :else x))
   [[1 2] [3 4 [5 6]] [7 8]])
")
  )

(defun self-recur-child ()
  "自身调用自身: 每一次就递归把child给填进去"
  (interactive)
  (insert
   "
(defn render-ds-child
  [node-id]
  (let [note (get-child node-id)]
    [:ul
     (for [;; 每一次就递归把child给填进去
           ch (:child note)]
       (let [{:keys [id content]} ch]
         [:li
          ;; 当前层
          [:span content]
          ;; 子层
          (render-ds-child id)]))]))
"))

(defun recur ()
  "递归脚手架: 开始输入值,递归死循环,递归停止条件,从高阶函数的重复特征(用Postwalk函数来快速找数据特征值cond,然后改写成尾递归的方式)到递归"
  (interactive)
  (insert
   "
(def factorial
  (fn [n]
    (loop [cnt n
           acc 1]
      (if (zero? cnt)
        acc
        (recur (dec cnt) (* acc cnt))))))
"))

(defun recur1 ()
  (interactive)
  (insert
   "
(loop [ele start-ele]
  (if (re-matches #\"some-div-id-(.*)\"  (.-id ele))
    (.-id ele)
    (recur (.-parentElement ele))))
"))

(defun recur2 ()
  (interactive)
  (insert
   "
(loop [i 0]
    (when (< i 5)
      (println i)
      (recur (inc i))))
"))

(defun recur-cond ()
  "多分支递归脚手架"
  (interactive)
  (insert
   "
(loop [x 1]
  (println \"x= \" x)
  (cond
    (> x 20) (println \"ending at \" x )
    (even? x) (recur (* 2 x))
    :else (recur (+ x 1))))
"))

(defun recur-macro ()
  "递归宏是展开成一段代码列表: 如计算器宏 # 和and宏类似 ## 切成一小部分一小部分求值解释器解释，就行and宏一样，## 而eval本身也是这样的批量实现方式"
  (interactive)
  (insert
   "
(defmacro macr [n]
  (if (zero? n)
    1
    `(* ~n (macr ~(dec n)))))
(clojure.walk/macroexpand-all '(macr 5))
"))
;; (clojure.walk/macroexpand-all '(macr 5))
;; (clojure.core/* 5 (clojure.core/* 4 (clojure.core/* 3 (clojure.core/* 2 (clojure.core/* 1 1)))))

(defun recur-macro2 ()
  (interactive)
  (insert
   "
(defmacro and
  ([] true)
  ([x] x)
  ([x & next]
   `(let [and# ~x]
      (if and# (and ~@next) and#))))
"))
;;(clojure.walk/macroexpand-all '(and false nil 8888))
;;(let* [and__5514__auto__ false] (if and__5514__auto__ (let* [and__5514__auto__ nil] (if and__5514__auto__ 8888 and__5514__auto__)) and__5514__auto__))

(defun clj-doc ()
  (interactive)
  (insert
   "(clojure.repl/source and)"))

(defun macro-exp ()
  (interactive)
  (insert
   "(clojure.pprint/pprint (clojure.walk/macroexpand-all '(and 1 2)))"))

(defun recur-pair ()
  "互相递归的一对"
  (interactive)
  (insert
   "
(defn get-span-1
  [vect]
  (if (= (count (last vect)) 1)
    (last (last vect))
    (map-list (rest vect))))

(defn map-list
  [lis]
  (map
    (fn [item]
      (if (string? item)
        item
        (get-span-1 item)))
    lis))
"))


(defun for-key ()
  (interactive)
  (insert "^{:key item}"))

(defun input-default ()
  (interactive)
  (insert "placeholder"))

(defun clojure-uniq ()
  "老是会忘记的名称: alias别名一下自己的理解的,能记住的名字"
  (interactive)
  (insert "(distinct)"))

(defun on-change-event ()
  (interactive)
  (insert "(.. e -target -value)"))

(defun is-comp? ()
  "判断一个React组件引用是否正确: util模式 => 元解释器模式开发"
  (interactive)
  (let*
      ((code (format
              "(try [(reagent.debug/assert-some %s \"Component\")] (catch :default e \"这不是一个React组件\"))"
              (thing-at-point 'symbol))))
    (let*
        ((res (format "%s" (eval-clj-code code))))
      (if (string= res "[nil]")
          (message "这是一个React组件")
        (message res)))))

(defun js->clj ()
  "用于将js的对象转为cljs的对象来编辑"
  (interactive)
  (insert " (cljs.pprint/pprint (js->clj js/obj :keywordize-keys true))"))

(defun cond-map ()
  (interactive)
  (insert "(cond-> {:id 1}
a (assoc :name 11)
b (assoc :title 22))
 "))

(defun cljc-fn ()
  (interactive)
  (insert "(defn read-stri [s]
  #?(:clj (clojure.core/read-string s)
     :cljs (cljs.reader/read-string s)))"))

(defun cljc-ns ()
  (interactive)
  (insert "
(ns test.ns
  (:require
   #?@(:clj
       [[clojure.string :as str]
        [clojure.core.async :as async]]
       :cljs
       [[clojure.string :as str]
        [cljs.core.async :as async]]))
  #?(:cljs
     (:require-macros
      [cljs.core.async.macros :as asyncm :refer (go go-loop)])))"))

;; M-x cider-connect `Figwheel: Starting nREPL server on port: 5088` =>
(defun figwheel-cljs-client-start ()
  (interactive)
  (progn
    (insert "(use 'figwheel-sidecar.repl-api)\n")
    (insert "(cljs-repl)\n")
    (sleep-for 2)
    (rename-buffer (replace-regexp-in-string " " " CLJS " (buffer-name)))))

(defun eval-clj-selected (start end)
  (interactive "r")
    (if (use-region-p)
        (let ((regionp (buffer-substring start end)))
            (message (eval-clj-code regionp)))))

(provide 'jim-clj-alias)
