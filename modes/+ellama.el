;;; modes/+ellama.el -*- lexical-binding: t; -*-

(setq
 llm-local-host (or (getenv "LLM_LOCAL_HOST") nil)
 llm-local-port (or (getenv "LLM_LOCAL_PORT") nil)
 llm-local-default-chat-model (or (getenv "LLM_LOCAL_DEFAULT_CHAT_MODEL") nil)
 llm-local-default-embedding-model (or (getenv "LLM_LOCAL_DEFAULT_EMBEDDING_MODEL") nil)
 llm-server-scheme (or (getenv "LLM_SERVER_SCHEME") nil)
 llm-server-host (or (getenv "LLM_SERVER_HOST") nil)
 llm-server-port (or (getenv "LLM_SERVER_PORT") nil)
 llm-server-default-chat-model (or (getenv "LLM_SERVER_DEFAULT_CHAT_MODEL") nil)
 llm-server-default-embedding-model (or (getenv "LLM_SERVERDEFAULT_EMBEDDING_MODEL") nil)
 llm-default-coding-model (or (getenv "LLM_DEFAULT_CODING_MODEL") nil)
 llm-default-summary-model (or (getenv "LLM_DEFAULT_SUMMARY_MODEL") nil)
 llm-default-translation-model (or (getenv "LLM_DEFAULT_TRANSLATION_MODEL") nil))

(use-package ellama
  :ensure t
  :bind ("C-c e" . ellama)
  ;; send last message in chat buffer with C-c C-c
  :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
  :init
  ;; setup key bindings
  ;; (setopt ellama-keymap-prefix "C-c e")
  ;; language you want ellama to translate to
  (setopt ellama-language "German")
  (setopt ellama-auto-scroll t)

  ;; could be llm-openai for example
  (require 'llm-ollama)
  (setopt ellama-provider
  	  (make-llm-ollama
  	   ;; this model should be pulled to use it
  	   ;; value should be the same as you print in terminal during pull
  	   :chat-model llm-local-default-chat-model
  	   :embedding-model llm-local-default-embedding-model
  	   :default-chat-non-standard-params '(("num_ctx" . 8192))))

  (setopt ellama-summarization-provider
  	  (make-llm-ollama
  	   :chat-model llm-default-summary-model
  	   :embedding-model llm-local-default-embedding-model
  	   :default-chat-non-standard-params '(("num_ctx" . 32768))))

  (setopt ellama-coding-provider
  	  (make-llm-ollama
  	   :chat-model llm-default-coding-model
  	   :embedding-model llm-local-default-embedding-model
  	   :default-chat-non-standard-params '(("num_ctx" . 32768))))

  (setopt ellama-naming-provider
  	  (make-llm-ollama
  	   :chat-model llm-local-default-chat-model
  	   :embedding-model llm-local-default-embedding-model
  	   :default-chat-non-standard-params '(("stop" . ("\n")))))

  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)

  (setopt ellama-translation-provider
  	  (make-llm-ollama
  	   :chat-model llm-default-translation-model
  	   :embedding-model llm-local-default-embedding-model
  	   :default-chat-non-standard-params
  	   '(("num_ctx" . 32768))))

  (setopt ellama-extraction-provider
          (make-llm-ollama
  	   :chat-model llm-local-default-chat-model
  	   :embedding-model llm-local-default-embedding-model
  	   :default-chat-non-standard-params
  	   '(("num_ctx" . 32768))))

  ;; customize display buffer behaviour
  ;; see ~(info "(elisp) Buffer Display Action Functions")~
  (setopt ellama-chat-display-action-function #'display-buffer-full-frame)
  (setopt ellama-instant-display-action-function #'display-buffer-at-bottom)
  (setopt ellama-spinner-enabled t)
  (setopt ellama-spinner-type "progress-bar")

  :config
  ;; show ellama context in header line in all buffers
  (ellama-context-header-line-global-mode -1)

  ;; show ellama session id in header line in all buffers
  (ellama-session-header-line-global-mode -1)

  ;; handle scrolling events
  (advice-add 'pixel-scroll-precision :before #'ellama-disable-scroll)
  (advice-add 'end-of-buffer :after #'ellama-enable-scroll))
