;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "J Daniel Arce"
      user-mail-address "juandanielarce398@gmail.com")

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

;; DIRED CONFIFG
(add-hook 'dired-mode-hook
          (lambda ()
            (text-scale-set 4)))

;; POWERSHELL
(use-package! powershell
  :mode ("\\.ps1\\'" . powershell-mode)
  :config
  (setq powershell-indent 4)
  (setq powershell-location-of-exe
        (executable-find "pwsh")))
;; (or  (executable-find "powershell"))


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
                                        (:name "JavaSE-17" :path "/home/arce/.sdkman/candidates/java/17.0.12-jbr" :default t)])


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
  (require 'dap-go)
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

(use-package! realgud
  :defer t)

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

(defun eww-open-in-browser ()
  "Open the current URL in the default web browser."
  (interactive)
  (let ((url (or (eww-current-url)
                 (read-string "Enter URL: "))))
    (message "Opening URL: %s" url)
    (browse-url-default-browser url)))

(map! :map eww-mode-map
      :desc "Open in external browser" "M-o" #'eww-open-in-browser)

;; KEYMAPS
(map! :leader
      :desc "Kill buffer and window" "b k" #'kill-buffer-and-window)

;; SPELL
;;(setq ispell-dictionary "en_US,es_ES"
;;      ispell-personal-dictionary "~/.dotfiles/.hunspell_personal")

(map! :leader
      :desc "Cambiar diccionario" "t S" #'ispell-change-dictionary)

;; MIPS
(use-package! mips-mode)

;; ANGULAR
;; Configuración de tide
(use-package tide
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(use-package prettier-js
  :hook ((js-mode . prettier-js-mode)
         (typescript-mode . prettier-js-mode)
         (web-mode . prettier-js-mode)))

;; EDITOR
(setq +format-on-save-disabled-modes
      '(dockerfile-mode)
      )

;; DIAPOSITIVAS
(use-package! org-tree-slide
  :after org
  :config
  ;; Tamaño de texto más grande durante la presentación
  (defun my/org-slide-start ()
    (org-display-inline-images)
    (text-scale-increase 2))

  (defun my/org-slide-stop ()
    (text-scale-decrease 2))

  (add-hook 'org-tree-slide-play-hook #'my/org-slide-start)
  (add-hook 'org-tree-slide-stop-hook #'my/org-slide-stop)

  ;; Opciones de navegación (puedes cambiar teclas si quieres)
  (setq org-tree-slide-skip-outline-level 2)
  (setq org-tree-slide-heading-emphasis t))

(use-package! org-tree-slide
  :after org
  :config
  (defun my/org-tree-slide-setup ()
    (org-display-inline-images)
    (text-scale-increase 2))

  (defun my/org-tree-slide-cleanup ()
    (org-remove-inline-images)
    (text-scale-decrease 2))

  (add-hook 'org-tree-slide-play-hook #'my/org-tree-slide-setup)
  (add-hook 'org-tree-slide-stop-hook #'my/org-tree-slide-cleanup))
