local exports = {}
local lib = {}
local stats = {
  functions = 0
}
local storage = {

}
-- Libraries.
lib.json = require('json')
lib.fs = require('fs')
lib.path = require('path')

-- Functions.
local readFile = function(path)
  local f = io.open(path, "rb")
  local content = f:read("*all")
  f:close()
  return content
end
local init = function()
  local data = readFile('/home/samt2497/sxtools/data/zips.json')
  local codes = lib.json.parse(data)
  storage.zipCodes = codes
end
exports.die = function()
	os.exit(0)
end

exports.reload = function()

end
exports.random = {}
exports.random.zip = function()
  return storage.zipCodes[math.random(1,#storage.zipCodes)]
end

for key, pointer in pairs(exports) do
  _G[key] = pointer
  stats.functions = stats.functions + 1
end
init()
_G['sxi_status'] = {
  loaded = true
}
print('SXI Loaded: ' .. stats.functions  .. ' funcs')
