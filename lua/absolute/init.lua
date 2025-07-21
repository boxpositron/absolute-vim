local lua_utils = require("absolute.utils.detect-lua")

package.path = package.path .. lua_utils.GetLatestLuaVersion()

require("absolute.core")
require("absolute.lazy")
require("absolute.helpers")
require("absolute.remap")
