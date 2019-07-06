;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.
(defun use-prettier-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (prettier (and root
                        (expand-file-name "node_modules/prettier/bin-prettier.js"
                                          root))))
    (when (and prettier (file-executable-p prettier))
      (setq-local prettier-js-command prettier))))

(defun use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))


(defun bravi/haskell-mode-hook ()
  (setq evil-auto-indent nil))


(defun bravi/clojure-mode-hook ()
  "setup some clojure specific configs"
  (add-to-list 'clojure-align-binding-forms "r/with-let")
  (add-hook 'clojure-mode-hook #'aggressive-indent-mode)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode-disable)
  )


(defun bravi/org-mode-hook ()
  "Stop the org-level headers from increasing in height"
  (dolist (face '(org-level-1
                  org-level-2
                  org-level-3
                  org-level-4
                  org-level-5))
    (set-face-attribute face nil :weight 'semi-bold :height 1.0)))


(defun bravi/magit-mode-hook ()
  "Change the keybindings back to defaults in magit"
  (define-key magit-status-mode-map (kbd "<tab>") #'magit-section-toggle))


;; clojure / clojurescript
(add-hook 'clojure-mode-hook #'bravi/clojure-mode-hook)

(add-hook 'flycheck-mode-hook #'use-eslint-from-node-modules)
(add-hook 'haskell-mode-hook #'bravi/haskell-mode-hook)
(add-hook 'magit-mode-hook #'bravi/magit-mode-hook)
(add-hook 'org-mode-hook #'bravi/haskell-mode-hook)
(add-hook 'prettier-js-mode-hook #'use-prettier-from-node-modules)
(add-hook 'rjsx-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
