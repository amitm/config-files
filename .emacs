;; create a backup file directory
(defun make-backup-file-name (file)
(concat "~/.emacs_backups/" (file-name-nondirectory file) "~"))

(setq-default indent-tabs-mode nil)    ; use only spaces and no tabs-mode                                            (setq default-tab-width 4)
(setq-default py-indent-offset 4)

(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins")
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/global-mode 1)

(require 'pymacs)

(add-to-list 'load-path "~/.emacs.d/")
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(require 'python-mode)

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete-1.3")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "pycheckers"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init)))
(load-library "flymake-cursor")
(global-set-key [f10] 'flymake-goto-prev-error)
(global-set-key [f11] 'flymake-goto-next-error)