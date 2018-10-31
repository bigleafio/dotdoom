;;;  -*- lexical-binding: t; -*-

(setq eshell-rc-script    (expand-file-name ".eshellrc"       "~"))
(setq eshell-aliases-file (expand-file-name ".eshell_aliases" "~"))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eshell prompt
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun +private/eshell--system ()
  ""
  (format "%s@%s " (user-login-name) (system-name)))

(defun +private/eshell--current-git-branch ()
  ""
  (let ((branch (car (cl-loop for match in (split-string (shell-command-to-string "git branch") "\n")
                              if (string-match-p "^\*" match)
                              collect match))))
    (if (not (eq branch nil))
        (format "  (%s)" (substring branch 2))
      "")))

(defun +private/eshell--current-conda-environment ()
  ""
  (if (bound-and-true-p conda-env-current-name)
      (format "  [%s]" conda-env-current-name)
    ""))

(defun +private/eshell-default-prompt ()
  ""
  (concat ;; (if (bobp) "" "\n")
          (propertize (+private/eshell--system)
                      'face 'all-the-icons-maroon)
          (let ((pwd (eshell/pwd)))
            (propertize (if (equal pwd "~")
                            pwd
                          (abbreviate-file-name (shrink-path-file pwd)))
                        'face 'all-the-icons-lblue))
          (propertize (+private/eshell--current-git-branch)
                      'face 'all-the-icons-green)
          (propertize (+private/eshell--current-conda-environment)
                      'face 'all-the-icons-yellow)
          (propertize " λ" 'face (if (zerop eshell-last-command-status) 'success 'error))
          " "))

(after! eshell
  (setq eshell-prompt-function '+private/eshell-default-prompt))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eshell completion
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq bash-completion-nospace t)
  (setq eshell-default-completion-function 'eshell-bash-completion))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eshell visual commands
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load 'esh-opt
  '(progn
     (require 'em-term)
     (require 'em-alias)
     (add-to-list 'eshell-visual-commands "htop")
     (add-to-list 'eshell-visual-commands "ccmake")))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eshell environment variables
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-env! "LC_CTYPE" "LC_ALL" "LANG")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide '+eshell)

;;; +eshell.el ends here
