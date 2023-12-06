;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jeffrey Palmer"
      user-mail-address "jeffrey.palmer@acm.org")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :weight 'light))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; This is a workaround for variable pitch fonts not being sized correctly
(use-package! mixed-pitch
  :config
  (setq mixed-pitch-set-height t)
  (set-face-attribute 'variable-pitch nil :height 150))

(add-hook! 'org-mode-hook #'mixed-pitch-mode)
;; (add-hook! 'org-mode-hook #'solaire-mode)
(setq mixed-pitch-variable-pitch-cursor nil)

;; increase the amount of overlap when scrolling by screenfuls
(setq next-screen-context-lines 6)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dark+)
(after! doom-themes
  (setq doom-themes-enable-bold nil
        doom-themes-enable-italic t))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; Automatically load the saved desktop configuration
;; (add-hook 'window-setup-hook #'doom/quickload-session)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org")

(after! org-clock
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate))

(add-to-list 'org-modules 'org-checklist)

(after! org
  (setq org-agenda-files (list org-directory)
        org-agenda-start-day nil
        org-default-notes-file (concat org-directory "/inbox.org")
        org-enforce-todo-dependencies t
        org-fontify-quote-and-verse-blocks t
        org-src-tab-acts-natively t
        org-src-fontify-natively t
        org-hide-emphasis-markers t
        org-hide-leading-stars t
        org-insert-heading-respect-content t
        org-fold-catch-invisible-edits 'show-and-error
        org-use-speed-commands t
        ;; open org links in the same window
        org-link-frame-setup '((file . find-file))
        ;; calculate completion statistics for multi-level projects
        org-hierarchical-todo-statistics nil
        ;; org-agenda-hide-tags-regexp TODO - figure out what this should be
        ;; don't show scheduled TODO items
        org-agenda-todo-ignore-scheduled 'future
        ;; logging work
        org-log-done 'time
        org-log-into-drawer "LOGBOOK"
        ;; capture settings
        org-capture-templates '(("t" "To Do" entry (file "")
                                 "* TODO %?\n")
                                ("g" "Generic" entry (file "")
                                 "* %?\n")
                                ("j" "Journal Entry"
                                 entry (file+olp+datetree "journal.org")
                                 "* %?")
                                ("l" "A link, for reading later." entry (file "")
                                 "* [[%:link][%:description]]%?"))
        ;; refile settings
        org-refile-targets '((nil :maxlevel . 9)
                             (org-agenda-files :maxlevel . 9))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes 'confirm
        org-log-note-headings '((done        . "CLOSING NOTE %t")
                                (note        . "Note taken on %t")
                                (state       . "State %-12s from %-12S %t")
                                (reschedule  . "Rescheduled from %S on %t")
                                (delschedule . "Not scheduled, was %S on %t")
                                (redeadline  . "New deadline from %S on %t")
                                (deldeadline . "Removed deadline, was %S on %t"))
        org-startup-indented t
        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "TODAY(y)" "IN_PROGRESS(i)" "WAITING(w@/!)" "|" "DONE(d!/!)")
                            (sequence "PROJECT(p)" "ACTIVE(a)" "|" "FINISHED(f!)" "CANCELLED(c@)")
                            (sequence "SOMEDAY(S!)" "MAYBE(m!)"))
        org-todo-keyword-faces '(("TODO" :foreground "DodgerBlue3")
                                 ("NEXT" :foreground "DodgerBlue2")
                                 ("TODAY" :foreground "SpringGreen2")
                                 ("IN_PROGRESS" :foreground "SpringGreen2")
                                 ("DONE" :foreground "forest green")
                                 ("PROJECT" :foreground "cornflower blue")
                                 ("ACTIVE" :foreground "deep sky blue")
                                 ("FINISHED" :foreground "forest green")
                                 ("CANCELLED" :foreground "goldenrod")
                                 ("WAITING" :foreground "coral")
                                 ("SOMEDAY" :foreground "purple")
                                 ("MAYBE" :foreground "purple"))
        org-todo-state-tags-triggers '(("PROJECT" ("project" . t) ("active" . nil))
                                       ("" ("project" . nil) ("active" . nil))
                                       ("ACTIVE" ("active" . t))
                                       ("FINISHED" ("active" . nil))
                                       ("CANCELLED" ("active" . nil))
                                       ("SOMEDAY" ("active" . nil))
                                       ("MAYBE" ("active" . nil)))
        ;; agenda customization
        org-agenda-span 'day
        org-stuck-projects '("/PROJECT|ACTIVE" ("NEXT" "TODAY") nil "")
        org-agenda-compact-blocks nil
        org-agenda-block-separator ?\-
        org-agenda-dim-blocked-tasks nil
        org-agenda-custom-commands
        '(
          ;; a view that supports:
          ;; - most important task of the day
          ;; - secondary tasks
          ;; - other tasks if i have time
          ("d" "Daily View"
           ((agenda "" nil)
            (todo "WAITING"
                  ((org-agenda-overriding-header "Waiting")))
            (tags-todo "/TODAY|IN_PROGRESS"
                       ((org-agenda-overriding-header "Most Important Tasks for Today")))
            (todo "ACTIVE"
                  ((org-agenda-overriding-header "Active Projects")))
            (tags-todo "active/NEXT"
                       ((org-agenda-overriding-header "Active Project Next Tasks")
                        (org-agenda-sorting-strategy '(todo-state-down category-keep))))
            (tags "REFILE"
                  ((org-agenda-overriding-header "Inbox")
                   (org-tags-match-list-sublevels nil)))
            (tags-todo "-active+project/NEXT"
                       ((org-agenda-overriding-header "Other Project Next Tasks")
                        (org-agenda-sorting-strategy '(todo-state-down category-keep))))
            (tags-todo "+active/TODO"
                       ((org-agenda-overriding-header "Active Project Tasks")
                        (org-agenda-sorting-strategy '(todo-state-down category-keep))))))
          ("D" "Review completed tasks"
           ((tags-todo "/DONE"
                       ((org-agenda-overriding-header "Completed Tasks and Projects")))))
          ("n" "Non-Project Tasks"
           ((tags-todo "-project-active/!TODO|NEXT|TODAY"
                       ((org-agenda-overriding-header "Non-Project Tasks")))))
          ("p" "Project Review"
           ((tags-todo "/PROJECT|ACTIVE"
                       ((org-agenda-overriding-header "Stuck Projects")
                        (org-agenda-skip-function '(org-agenda-skip-subtree-if 'todo '("NEXT" "TODAY")))))
            (tags-todo "/ACTIVE"
                       ((org-agenda-overriding-header "Active Projects")
                        (org-agenda-skip-function '(org-agenda-skip-subtree-if 'nottodo '("NEXT" "TODAY")))))
            (tags-todo "/PROJECT"
                       ((org-agenda-overriding-header "Other Projects")
                        (org-agenda-skip-function '(org-agenda-skip-subtree-if 'nottodo '("NEXT" "TODAY")))))
            (tags-todo "-CANCELLED/"
                       ((org-agenda-overriding-header "Reviews Scheduled")
                        (org-agenda-skip-function 'org-review-agenda-skip)
                        (org-agenda-cmp-user-defined 'org-review-compare)
                        (org-agenda-sorting-strategy '(user-defined-down))))))
          ("h" "Habits" tags-todo "STYLE=\"habit\""
           ((org-agenda-overriding-header "Habits")
            (org-agenda-sorting-strategy
             '(todo-state-down effort-up category-keep))))
          ("i" "Inbox" tags "REFILE"
           ((org-agenda-overriding-header "Inbox")
            (org-tags-match-list-sublevels nil))))))


;; Org Roam support
(setq org-roam-directory "~/Documents/OrgRoam")

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

;; glsl support
(use-package! company-glsl
  :config (add-to-list 'company-backends 'company-glsl))

(use-package! flycheck-glsl
  :after (flycheck dash)
  :config (flycheck-glsl-setup))

(use-package! glsl-mode
  :mode "(\\.\\(glsl\\|vert\\|frag\\|geom\\)\\'")

;; Use Colemak-friendly keys for Avy
(after! avy
  ;; should be in this order: t n s e r i a o
  (setq avy-keys '(?t ?n ?s ?e ?r ?i ?a ?o ?g ?m)))

;; Some preferred keybinds
(map! "C-x b" #'consult-buffer)
(map! "M-g g" #'avy-goto-line)
(map! "M-g M-g" #'avy-goto-line)
(map! "s-;" #'avy-goto-char-2)
(map! "M-o" #'ace-window)
(map! "C-c n b" #'org-switchb)

;; Use bitmap indentation highlights
(after! highlight-indent-guides
  (setq highlight-indent-guides-method 'bitmap))

;; Disable completion in org-mode buffers - it's annoying as hell
(use-package! org
  :hook
  (org-mode . (lambda () (company-mode -1))))

;; Disable popup-based completion in all text modes - also annoying as hell
(use-package! company
  :config
  (setq +company-backend-alist (assq-delete-all 'text-mode +company-backend-alist)
        company-idle-delay 0.5)
  (add-to-list '+company-backend-alist '(text-mode (:separate company-yasnippet))))


;; Specify that buffer locations should be reused whenever possible
(setq display-buffer-base-action
      '(display-buffer-reuse-mode-window
        display-buffer-reuse-window
        display-buffer-same-window))
;; If a popup does happen, don't resize windows to be equally sized
(setq even-window-sizes nil)

;; workaround typescript indentation bug
;; force typescript indentation level to 2 spaces so that I don't go insane
(after! typescript-mode
  (setq typescript-indent-level 4))

;; Disable rainbow delimiters - I can't take it
(after! typescript-mode
  (remove-hook 'typescript-mode-hook #'rainbow-delimiters-mode))

;; Doom currently has a bug where org mode buffers are not auto-reverted, causing the agenda to be out of sync
;; This will disable the default Doom auto-revert behavior and go back to normal
(remove-hook 'focus-in-hook #'doom-auto-revert-buffers-h)
(remove-hook 'after-save-hook #'doom-auto-revert-buffers-h)
(remove-hook 'doom-switch-buffer-hook #'doom-auto-revert-buffer-h)
(remove-hook 'doom-switch-window-hook #'doom-auto-revert-buffer-h)

;; Revert dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Always create new workspaces for new projects
(setq +workspaces-on-switch-project-behavior 't)

;; Allow intelligent navigation through sub-words
(global-subword-mode 1)

;; Python mode support
(use-package! python
  :config
  (setq! python-shell-completion-native-enable nil
         python-shell-interpreter "ipython"
         python-shell-interpreter-args "-i --simple-prompt --InteractiveShell.display_page=True"))


;; Ai Assistant mode
(use-package! gptel
  :config
  (setq! gptel-api-key "KEY"
         gptel-host "localhost:5000"
         gptel-default-mode 'org-mode))

;; (use-package! org-ai
;;   :init
;;   (add-hook 'org-mode-hook #'org-ai-mode)
;;   (org-ai-global-mode)
;;   :config
;;   (setq org-ai-openai-chat-endpoint "http://localhost:5000/v1/chat/completions"
;;         org-ai-openai-completion-endpoint "http://localhost:5000/v1/completions"))

