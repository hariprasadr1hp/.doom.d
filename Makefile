
LINKS_CACHE_FILE := ${HOME}/.local/share/eww_link_log.jsonl
LINKS_CACHE_FILE := ${HOME}/.local/share/eww_link_log.jsonl

all:
	echo "running doom emacs..."

log:
	cat $(LINKS_CACHE_FILE)

clean:
	rm -f $(LINKS_CACHE_FILE)

org-refresh-latex-previews:
	./scripts/org_refresh_latex_previews.sh -v

.PHONY: all log clean

