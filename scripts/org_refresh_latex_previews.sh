#!/usr/bin/env bash
# Refresh LaTeX previews for org files that have #+startup: latexpreview.
# Requires a running Emacs server (emacsclient).

set -euo pipefail

VERBOSE=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    -v|--verbose) VERBOSE=1; shift ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

log() { [[ $VERBOSE -eq 1 ]] && echo "$@"; }

ORG_DIR="${ORG_DIR:-$HOME/my/org}"

if [[ ! -d "$ORG_DIR" ]]; then
  echo "org-directory not found: $ORG_DIR" >&2
  exit 1
fi

mapfile -t files < <(grep -ril '#+startup:.*latexpreview' "$ORG_DIR" --include='*.org' 2>/dev/null)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No org files with #+startup: latexpreview found in $ORG_DIR"
  exit 0
fi

echo "Found ${#files[@]} file(s) — refreshing LaTeX previews..."

# Write helper elisp to a temp file to avoid bash/elisp quoting issues.
HELPER=$(mktemp /tmp/org-latex-refresh-XXXXXX.el)
trap 'rm -f "$HELPER"' EXIT

cat > "$HELPER" << 'EOF'
(defun --org-latex-refresh-file (path)
  (with-current-buffer (find-file-noselect path)
    (hp-org-update-latex-preview-appearance)
    (org-latex-preview '(64))))

(defun --org-latex-wait ()
  "Block until all latex/dvipng child processes finish (timeout 60 s)."
  (let ((deadline (+ (float-time) 60.0)))
    (while (and (< (float-time) deadline)
                (cl-some (lambda (p)
                           (and (process-live-p p)
                                (let ((name (process-name p)))
                                  (or (string-match-p "latex" name)
                                      (string-match-p "dvipng" name)
                                      (string-match-p "dvisvgm" name)))))
                         (process-list)))
      (accept-process-output nil 0.2))))
EOF

emacsclient --eval "(load-file \"$HELPER\")"

# Escape a path for use inside an elisp string literal.
elisp_escape() { printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'; }

for f in "${files[@]}"; do
  log "  processing: $f"
  ef=$(elisp_escape "$f")
  emacsclient --eval "(progn (--org-latex-refresh-file \"$ef\") (--org-latex-wait))"
  log "  done: $f"
done

echo "Done."
