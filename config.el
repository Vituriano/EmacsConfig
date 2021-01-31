(setq user-full-name "Vituriano Oliveira Xisto"
      user-mail-address "viturianooliveira@gmail.com")
;; Font
(setq doom-font (font-spec :family "JetBrains Mono" :size 12)
      doom-big-font (font-spec :family "JetBrains Mono" :size 18))
;; encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-input-method "latin-1")
(global-set-key (kbd "C-/") 'toggle-input-method)
;; Disable default fringe styling
(setq +vc-gutter-default-style nil)
;; Make sure the margin is visible to begin with
(setq-default left-margin-width 1)
;; diable exit confirmation
(setq confirm-kill-emacs nil)
;; chilframe
(setq posframe-arghandler
      (lambda (buffer-or-name key value)
        (or (and (eq key :lines-truncate)
                 (equal ivy-posframe-buffer
                        (if (stringp buffer-or-name)
                            buffer-or-name
                          (buffer-name buffer-or-name)))
                 t)
            value)))
;; Move flycheck to left margin
(setq-default flycheck-indication-mode 'left-margin)
;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;; This determines the style of line numbers in effect
(setq display-line-numbers-type t)
;; pretty symbols
(when window-system
  (add-hook 'prog-mode-hook 'prettify-symbols-mode))
;; Dashboard
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-loaded)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; Treemacs
(use-package treemacs
  :defer t
  :init
  :config
  (progn
    (setq
          treemacs-show-cursor                   nil
          treemacs-space-between-root-nodes      t
          treemacs-width                         30
          treemacs-workspace-switch-cleanup      'files
     )

        (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))))

(use-package treemacs-magit
  :after treemacs magit)

(use-package all-the-icons)

(use-package kaolin-themes
  :config (kaolin-treemacs-theme))

(load-theme 'kaolin-galaxy
            :no-confirm)
(setq
 ;; distinct background for fringe and line numbers
 kaolin-themes-distinct-fringe t
 ;; enable italic style in comments
 kaolin-themes-italic-comments t
 ;; display colered hi-line instead of monochrome
 kaolin-themes-hi-line-colored t
 ;; distinct colors for company popup scrollbar
 kaolin-themes-distinct-company-scrollbar t
 ;; modeline border
 kaolin-themes-modeline-border t
 ;; distinct #+TITLE, ...
 kaolin-themes-distinct-metakeys t
 ;; distinct colors for company popup scrollbar
 kaolin-themes-distinct-company-scrollbar t)
;; Float minibuffer
(use-package ivy-posframe
  :diminish ivy-posframe-mode
  :custom-face
  (ivy-posframe ((t (:background "#333244"))))
  :hook
  (ivy-mode . ivy-posframe-mode)
  :config
  ;; custom define height of post frame per function
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
  (ivy-posframe-mode 1))
