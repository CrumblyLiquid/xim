all: luapi

luapi:
	curl https://raw.githubusercontent.com/xournalpp/xournalpp/refs/heads/master/plugins/luapi_application.def.lua -o luapi.lua

clean:
	rm ./luapi.lua
