INCLUDE_REPO=git@github.com:masteringmatplotlib/includes.git
INCLUDE_DIR=include
NOTEBOOK=notebooks/mmpl-arch.ipynb

-include include/common.mk
-include include/graphviz.mk
-include include/types.mk

$(INCLUDE_DIR):
	git submodule add $(INCLUDE_REPO) $(INCLUDE_DIR)

deps: pygraphviz project-deps

setup: $(INCLUDE_DIR)
	make project-setup
