
LINKS_CACHE_FILE := ${HOME}/.local/share/eww_link_log.jsonl

.PHONY: all
all:
	echo "running doom emacs..."

.PHONY: log
log:
	cat $(LINKS_CACHE_FILE)

.PHONY: clean
clean:
	rm -f $(LINKS_CACHE_FILE)

