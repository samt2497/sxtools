local lib

local data = {}
local module = {
  exports = {}
}
module.init = function(payload)
  lib = payload.lib
end
module.exports.about = function(ip)
  local results = {}
  lib.http.get('http://' .. ip, function (res)
    p(res)
    res:on('data', function (chunk)
      p("ondata", {chunk=chunk})
    end)
    res:on('end',function ()
      p(res)
    end)
  end)
    return results
end
return module