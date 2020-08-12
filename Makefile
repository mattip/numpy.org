# type `make help` to see all options 

all: build

.PHONY: serve html clean github help

serve: ## serve the website
	@hugo --i18n-warnings server -D

html: ## build the website
	@hugo
	@touch public/.nojekyll

clean: ## remove the build artifacts, mainly the "public" directory
	@rm -rf public

github: | clean html ## push the built site to the gh-pages of this repo
	@sh ./publish_to_ghpages.sh origin


# Add help text after each target name starting with '\#\#'
help:   ## Show this help.
	@echo "\nHelp for this makefile"
	@echo "Possible commands are:"
	@grep -h "##" $(MAKEFILE_LIST) | grep -v grep | sed -e 's/\(.*\):.*##\(.*\)/    \1: \2/'
 
