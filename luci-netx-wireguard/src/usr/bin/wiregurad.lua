#!/usr/bin/lua
require("luci.model.uci")
local http = require("socket.http")
local ltn12 = require("ltn12")
local cjson = require("cjson")
local x = luci.model.uci.cursor()
http.TIMEOUT = 60

function getWiregurad()
    result = nil
    local respbody = {}

    http.request {
        url = "http://192.168.3.61:3000/api/user/?_where=(mac,eq,F8:5E:3C:07:23:15)",
        sink = ltn12.sink.table(respbody)
    }
    if table.concat(respbody) ~= "" then
        json = cjson.decode(table.concat(respbody))
        if json[1] ~= nil then
          result = json[1]
        end
    end
    print(result)
end

getWiregurad()
