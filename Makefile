MYPY=$(VENV)/bin/mypy
NOTEBOOK=notebooks/mmpl-arch.ipynb

include include/common.mk

pygraphviz:
	@git clone https://github.com/pygraphviz/pygraphviz
	@. $(VENV)/bin/activate && \
	cd pygraphviz && \
	git checkout 6c0876c9bb158452f1193d562531d258e9193f2e && \
	git apply ../patches/graphviz-includes.diff && \
	python setup.py install
	@rm -rf pygraphviz

$(MYPY):
	git clone https://github.com/JukkaL/mypy.git
	. $(VENV)/bin/activate && \
	cd mypy && $(PYTHON) setup.py install
	rm -rf mypy

deps: pygraphviz project-deps

types: $(MYPY)
	@echo "\nChecking types ...\n"
	for FILE in ./lib/*.py; do mypy $$FILE; done

check: flakes types
