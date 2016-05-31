local data = {}
local module = {
  exports = {}
}
module.exports.setCodes = function(codes)
  data.codes = codes
end
module.exports.zip = function()
  return data.codes[math.random(1,#data.codes)]
end
return module