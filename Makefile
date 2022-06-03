LUA ?= lua
LUACOV ?= luacov

help:
	@echo "use make [COMMAND]"
	@echo "	where COMMAND is"
	@echo "	coverage"
	@echo "	test"

coverage:
	@$(LUACOV)
	@cat luacov.report.out

test: 
	$(LUA) test/init.lua

.PHONY: test coverage help
