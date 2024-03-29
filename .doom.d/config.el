;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Kevin Liu"
      user-mail-address "kevin@kliu.io")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 32))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org Mode/")
(after! org-agenda
  (setq org-agenda-files (file-expand-wildcards "~/Documents/Org Mode/*.org"))
  (setq org-agenda-span 1)
  (setq org-agenda-start-day nil)
  (setq org-agenda-start-on-weekday nil)
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-deadline-prewarning-if-scheduled 365) ;; days
  (setq org-agenda-skip-scheduled-if-deadline-is-shown t)
  (setq org-agenda-compact-blocks t))
(setq org-startup-truncated nil)
(setq org-startup-indented t)
(setq org-startup-folded nil)
(setq org-startup-latex-with-latex-preview t)
(setq org-blank-before-new-entry '((heading . always) (plain-list-item . auto)))

(after! org-capture
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/Documents/Org Mode/todo.org" "Inbox")
	   "* TODO %?\n %a"))))

(advice-add #'org-capture :around
	                     (lambda (fun &rest args)
			                          (letf! ((#'+org--restart-mode-h #'ignore))
							                      (apply fun args))))


;; Gray out metatasks until subtasks are complete
(setq org-enforce-todo-dependencies t)
(setq org-log-done (quote time))
(setq org-log-redeadline (quote time))
(setq org-log-reschedule (quote time))
(setq org-log-into-drawer t)

(setq org-extend-today-until 6)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! org-super-agenda
  :after org-agenda
  :config
  (org-super-agenda-mode))

(after! org-habit
  (setq org-habit-preceding-days 7
        org-habit-following-days 1
        org-habit-graph-column 80
        org-habit-show-habits-only-for-today t))

(defun kev-agenda ()
  (interactive)
  (let ((org-super-agenda-groups
         `((:name "Events"
            :and (:time-grid t :todo nil))
           (:name "Upcoming"
            ;; Anything due tomorrow, to-do during the day
            :and (:not (:tag "@night")
                  :not (:scheduled future)
                  :deadline (before ,(org-read-date nil nil "+2d")))
            :and (:not (:tag "@night") :habit t))
           (:name "Nightly"
            :and (:not (:scheduled future) :tag "@night"))
           (:name "Someday"
            :order 100
            :todo ("SOMEDAY"))
           (:name "Future"
            :order 101
            :scheduled future)
           (:name "Important"
            :priority "A")
           (:name "Blocked"
            :order 99
            :todo ("WAITING"))
           (:name "Backlog"
            :order 98
            :anything))))
    (org-agenda-list)))

(map! :leader
      :desc "Open agenda"
      "o c" #'kev-agenda)
