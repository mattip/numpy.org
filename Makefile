# type `make help` to see all options 

# which "git remote" to push to, handy for forks of this repo
TARGET?=origin

BRANCHEXISTS = $(shell git branch --list $(TARGET)/gh-pages)

all: build

.PHONY: serve html clean deploy help

.SILENT:

serve: public ## serve the website
	hugo --i18n-warnings server -D

html: ## build the website in ./public
	if [ -z "$(BRANCHEXISTS)" ]; then \
		git branch $(TARGET)/gh-pages; \
	fi
	hugo
	touch public/.nojekyll

clean: ## remove the build artifacts, mainly the "public" directory
	rm -rf public
	git worktree prune
	rm -rf .git/wortrees/public

deploy: public ## push the built site to the gh-pages of this repo
	cd public && git add --all && git commit -m"Publishing to gh-pages"
	git push $(TARGET) gh-pages


# Add help text after each target name starting with '\#\#'
help:   ## Show this help.
	@echo "\nHelp for this makefile"
	@echo "Possible commands are:"
	@grep -h "##" $(MAKEFILE_LIST) | grep -v grep | sed -e 's/\(.*\):.*##\(.*\)/    \1: \2/'
 
