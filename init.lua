local exports = {}
local lib = {}
local modules = {}
local metamap = {}
local stats = {
  functions = 0,
  exports = 0
}
local storage = {

}
-- Libraries.
local workpath = '/home/samt2497/sxtools/'
package.path = package.path .. ";/home/samt2497/sxtools/?.lua"
lib.json = require('json')
lib.fs = require('fs')
lib.path = require('path')
lib.net = require('net')
lib.http = require('http')

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
  exports.random.setCodes(codes)
end
exports.die = function()
	os.exit(0)
end

exports.reload = function()

end
-- Extra files
local load_queue = {
  random = 'random.lua',
  spy    = 'spy.lua'
}
for name, file in pairs(load_queue) do
  modules[name] = dofile(workpath .. file)
end

-- Register Modules exports
for key, module in pairs(modules) do
  if(module.init) then
    module.init({
      lib = lib
    })
  end
  if(module.exports) then
    exports[key] = module.exports
  end
end

for key, pointer in pairs(exports) do
  _G[key] = pointer
  stats.exports = stats.exports + 1
end
init()

metamap.exit = exports.die
-- Load Direct maps
setmetatable(_G, {__index =
function(t, k)
  for command, func in pairs(metamap) do
    if k == command then
      return func()
    end
  end
end
})

_G['sxi_status'] = {
  loaded = true
}
print('SXI Loaded: ' .. stats.exports .. ' exports')
