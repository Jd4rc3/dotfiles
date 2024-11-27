;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 16))
;;(setq doom-big-font (font-spec :family "JetBrainsMono Nerd Font"))
(setq doom-big-font (font-spec :family "Iosevka Nerd Font"))

(setq doom-theme 'gruber-darker)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")


;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys


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

(setq lsp-java-content-provider-preferred "fernflower")

(setq lsp-java-vmargs '("-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Dsun.zip.disableMemoryMapping=true" "-Xmx2G" "-Xms100m"))

(setq lsp-java-configuration-runtimes '[
  (:name "JavaSE-1.8" :path "/home/arce/.sdkman/candidates/java/8.0.432-tem")
  (:name "JavaSE-17" :path "/home/arce/.sdkman/candidates/java/17.0.12-jbr" :default t)
    ])

;;LSP GENERAL


(after! lsp-mode
  :config

  (setq lsp-completion-trigger-characters '("."))
  (setq lsp-log-io t))
 ;; (setq lsp-completion-provider :none)
  ;(add-hook 'lsp-mode-hook #'lsp-lens-mode)

(use-package! tempel
  :bind (("M-+" . tempel-complete)
         ("M-*" . tempel-expand))
  :config
  (add-to-list 'completion-at-point-functions #'tempel-expand))

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

(use-package! helm-lsp
  :after (lsp-mode helm)
  :config
  (map! :leader
        :desc "LSP Workspace Symbol" "c s" #'helm-lsp-workspace-symbol))

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
(use-package! sharper
  :demand t
  :bind
  ("C-c n" . sharper-main-transient))

;;DIRENV
(use-package! envrc
  :config
  (envrc-global-mode))

;;HELM
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

;; LOOKUP ONLINE
(setq browse-url-browser-function 'eww-browse-url)

;; KEYMAPS
(map! :leader
      :desc "Kill buffer and window" "b k" #'kill-buffer-and-window)
