;;; batsh-mode.el --- A major mode for the Batsh programming language -*- lexical-binding: t -*-

;; Version: 0.0.1
;; Author: XXIV
;; Keywords: files, batsh
;; Package-Requires: ((emacs "24.3"))
;; Homepage: https://github.com/thechampagne/batsh-mode

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; A major mode for the Batsh programming language.

;;;; Installation

;; You can use built-in package manager (package.el) or do everything by your hands.

;;;;; Using package manager

;; Add the following to your Emacs config file

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)
;; (package-initialize)

;; Then use `M-x package-install RET batsh-mode RET` to install the mode.
;; Use `M-x batsh-mode` to change your current mode.

;;;;; Manual

;; Download the mode to your local directory.  You can do it through `git clone` command:

;; git clone git://github.com/thechampagne/batsh-mode.git

;; Then add path to batsh-mode to load-path list — add the following to your Emacs config file

;; (add-to-list 'load-path
;; 	     "/path/to/batsh-mode/")
;; (require 'batsh-mode)

;; Use `M-x batsh-mode` to change your current mode.

;;; Code:

(defconst batsh-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?/  ". 12" table)
    (modify-syntax-entry ?\n ">"    table)
    (modify-syntax-entry ?\" "\"" table)
    table))


(defconst batsh-keywords
  '("if" "else" "while" "function"
    "global" "return"))


(defconst batsh-builtins
  '("print" "println" "call" "bash"
    "batch" "readdir" "exists"))


(defconst batsh-constants
  '("true" "false"))


(defconst batsh-font-lock-keywords
  (list
   `(,(regexp-opt batsh-constants 'words) . font-lock-constant-face)
   `(,(regexp-opt batsh-keywords 'symbols) . font-lock-keyword-face)
   `(,(concat (regexp-opt batsh-builtins 'words)  "[[:space:]]*(") . (1 font-lock-builtin-face ))
   `("[[:space:]]*\\<\\([a-zA-Z0-9_]*\\)\\>\\>[[:space:]]*(" (1 font-lock-function-name-face))
   `("function[[:space:]]*\\<\\([a-zA-Z0-9_]*\\)\\>\\>[[:space:]]*(" (1 font-lock-function-name-face))
   `("global[[:space:]]*\\<\\([a-zA-Z0-9_]*\\)\\>\\>" (1 font-lock-variable-name-face))
   `("\\<\\([a-zA-Z0-9_]*\\)\\>\\>[[:space:]]*=" (1 font-lock-variable-name-face))))

;;;###autoload
(define-derived-mode batsh-mode prog-mode "Batsh"
  "A major mode for the Batsh programming language."
  :syntax-table batsh-mode-syntax-table
  (setq-local font-lock-defaults '(batsh-font-lock-keywords))
  (setq-local comment-start "// ")
  (setq-local comment-end ""))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.batsh\\'" . batsh-mode))

(provide 'batsh-mode)

;;; batsh-mode.el ends here
