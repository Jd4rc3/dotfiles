;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 16))
;;(setq doom-big-font (font-spec :family "JetBrainsMono Nerd Font"))
(setq doom-big-font (font-spec :family "Iosevka Nerd Font"))
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'gruber-darker)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;


;; POWERSHELL
(use-package! powershell
  :mode ("\\.ps1\\'" . powershell-mode)
  :config
  (setq powershell-indent 4)
  (setq powershell-location-of-exe
        (executable-find "pwsh"))
     ;; (or  (executable-find "powershell"))
)

(use-package! lsp-pwsh
  :hook (powershell-mode . lsp-deferred)
  :config
  (setq lsp-pwsh-mseditorservices-path
        (expand-file-name "~/.config/emacs/.local/etc/lsp/pwsh/PowerShellEditorServices/"))
  (setq lsp-pwsh-mseditorservices-log-level "Normal"))

;; JAVA
(use-package! lsp-java-boot
  :after lsp-mode
  :config
  (add-hook 'lsp-mode-hook #'lsp-lens-mode)
  (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode))

(setq lsp-java-annotation-processors ["org.eclipse.jdt.annotation"])

(setq lsp-java-configuration-runtimes '[
  (:name "JavaSE-1.8" :path "/home/arce/.sdkman/candidates/java/8.0.432-tem")
  (:name "JavaSE-17" :path "/home/arce/.sdkman/candidates/java/17.0.13-tem" :default t)
    ])

;;LSP GENERAL
(use-package! lsp-mode
  :config
  (setq lsp-log-io t))
  ;(add-hook 'lsp-mode-hook #'lsp-lens-mode)

;; DAP-MODE
(use-package! dap-mode
  :after lsp-mode
  :config
  (dap-auto-configure-mode)
  (require 'dap-java)
  (require 'dap-pwsh)
  (require 'dap-node)
    (dap-node-setup))

(map! :leader
      :prefix ("d" . "dap")
      :desc "Debug" "d" #'dap-debug
      :desc "Debug restart" "r" #'dap-debug-restart
      :desc "Go to locals" "l" #'dap-ui-locals
      :desc "Toggle Breakpoint" "b" #'dap-breakpoint-toggle
      :desc "Next" "n" #'dap-next
      :desc "Continue" "c" #'dap-continue
      :desc "In" "i" #'dap-step-in
      :desc "Out" "o" #'dap-step-out
      :desc "Go to sessions" "s" #'dap-ui-sessions)

(use-package! company-lsp
  :after lsp
  :config
  (setq company-backends '(company-lsp)))

(use-package! helm-lsp
  :after (lsp-mode helm)
  :config
  (map! :leader
        :desc "LSP Workspace Symbol" "c s" #'helm-lsp-workspace-symbol))

;;(define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol)


;; tree-sitter config
(setq +tree-sitter-hl-enabled-modes '(python-mode go-mode Dockerfile java-mode powershell-mode csharp-mode))

(use-package! tree-sitter
  :hook (prog-mode . tree-sitter-mode)
  :config
  (global-tree-sitter-mode)
  (use-package! tree-sitter-langs))


;; ENV CONFIG
(use-package! exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs '("PATH")))

;; CSHARP
;;(global-set-key (kbd "C-c n") 'sharper-main-transient)
(use-package! sharper
  :demand t
  :bind
  ("C-c n" . sharper-main-transient))

(after! csharp-mode
  (add-hook 'csharp-mode-hook #'lsp-deferred))

;;DIRENV
(use-package! envrc
  :config
  (envrc-global-mode))

;;HELM
(setq helm-M-x-fuzzy-match t)  ;; Activa la coincidencia difusa
(setq helm-M-x-requires-pattern nil)  ;; Permite seleccionar comandos sin necesidad de patrones previos
(setq helm-display-header-line nil) ;; Desactivar la cabecera para mejorar la vista

;;GRADLE
(use-package! gradle-mode
  :defer t
  :config
  (setq gradle-executable-path  "/home/arce/.sdkman/candidates/gradle/8.11.1/bin/gradle"))

;; DISCORD
(use-package! elcord
  :config
  (setq elcord-editor-icon "emacs_icon")
  (elcord-mode))
