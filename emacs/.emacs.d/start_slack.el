;; --------------------slack----------------------------

;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; (el-get-bundle slack)
;; (el-get-bundle yuya373/helm-slack) ;; optional
(use-package helm-slack :after (slack)) ;; optional
(use-package slack
  :commands (slack-start)
  :init
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  :config
  (slack-register-team
   :name "emacs-slack"
   :default t
   :token "xoxs-sssssssssss-88888888888-hhhhhhhhhhh-jjjjjjjjjj"
   :subscribed-channels '(test-rename rrrrr)
   :full-and-display-names t)

  (slack-register-team
   :name "test"
   :token "xoxs-yyyyyyyyyy-zzzzzzzzzzz-hhhhhhhhhhh-llllllllll"
   :subscribed-channels '(hoge fuga))

  (evil-define-key 'normal slack-info-mode-map
    ",u" 'slack-room-update-messages)
  (evil-define-key 'normal slack-mode-map
    ",c" 'slack-buffer-kill
    ",ra" 'slack-message-add-reaction
    ",rr" 'slack-message-remove-reaction
    ",rs" 'slack-message-show-reaction-users
    ",pl" 'slack-room-pins-list
    ",pa" 'slack-message-pins-add
    ",pr" 'slack-message-pins-remove
    ",mm" 'slack-message-write-another-buffer
    ",me" 'slack-message-edit
    ",md" 'slack-message-delete
    ",u" 'slack-room-update-messages
    ",2" 'slack-message-embed-mention
    ",3" 'slack-message-embed-channel
    "\C-n" 'slack-buffer-goto-next-message
    "\C-p" 'slack-buffer-goto-prev-message)
   (evil-define-key 'normal slack-edit-message-mode-map
    ",k" 'slack-message-cancel-edit
    ",s" 'slack-message-send-from-buffer
    ",2" 'slack-message-embed-mention
    ",3" 'slack-message-embed-channel))

(use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))
