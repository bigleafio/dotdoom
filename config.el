;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq-default
 user-full-name    "Jason Graham"
 user-mail-address "jgraham20@gmail.com"
 +doom-dashboard-banner-file "bear.png"
 +doom-dashboard-banner-dir "~/.doom.d/"
 +workspaces-switch-project-function #'ignore
 +pretty-code-enabled-modes '(emacs-lisp-mode org-mode)
 +format-on-save-enabled-modes '(not emacs-lisp-mode))

;; (setq-hook! 'minibuffer-setup-hook show-trailing-whitespace nil)

(add-to-list 'org-modules 'org-habit t)

(menu-bar-mode   1)

(setq doom-font (font-spec :family "Source Code Variable" :size 10))
(setq doom-variable-pitch-font (font-spec :family "Source Code Variable"))
(setq doom-unicode-font (font-spec :family "Source Code Variable"))
(setq doom-big-font (font-spec :family "Source Code Variable" :size 16))

(setq frame-title-format '("" "[%b] - Emacs " emacs-version))
(setq doom-theme 'doom-opera)

;; emacs/eshell
(load! "+editor")

;; tools/magit
(setq magit-repository-directories '(("~/work" . 2))
      magit-save-repository-buffers nil)

;; lang/org
(setq org-directory (expand-file-name "~/Notes/")
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ "

      ;; The standard unicode characters are usually misaligned depending on the
      ;; font. This bugs me. Personally, markdown #-marks for headlines are more
      ;; elegant.
      org-bullets-bullet-list '("#"))

(setq org-capture-templates
      '(("t" "Todo"
         entry (file+headline (lambda () (concat org-directory "organizer.org")) "Task List")
         "* TODO %?
DEADLINE: %t
:LOGBOOK:
- State \"TODO\"       from \"\"           %U
:END:
see: %a\n")
        ("n" "Note"
         entry (file+headline (lambda () (concat org-directory "organizer.org")) "Notes")
         "* %?
%U\n%a\n")
        ("b" "Book" entry (file+headline (lambda () (concat org-directory "organizer.org")) "Books")
         "* %?
(C-c C-w to refile to fiction/non-fiction)
see %a
entered on %U\n")
        ("q" "Clock (quick)" plain (clock)
         "%a%?\n")
        ("s" "Emacs tool sharpening"
         entry (file+olp (lambda () (concat org-directory "programming_notes.org"))
                         "Emacs"
                         "Sharpening list")
         "* %?
see %a
entered on %U\n")
        ("S" "General tool sharpening"
         entry (file+olp (lambda () (concat org-directory "programming_notes.org"))
                         "General sharpening")
         "* %?
see %a
entered on %U\n")
        ("d" "Date"
         entry (file+datetree+prompt (lambda () (concat org-directory "dates.org")))
         "* %?
%t
see %a\n")
        ("j" "Journal"
         plain (file+datetree (lambda () (concat org-directory "journal.org")))
         "**** <title>\n%U\n\n%?\n"
         )
        
        ("a"               ; key
         "Article"         ; name
         entry             ; type
        (file+headline "~/Notes/notes.org" "Article")  ; target
        "* %^{Title} %(org-set-tags)  :article: \n:PROPERTIES:\n:Created: %U\n:Linked: %A\n:END:\n%i\nBrief description:\n%?"  ; template
        :prepend t        ; properties
        :empty-lines 1    ; properties
        :created t        ; properties
       ))
)
