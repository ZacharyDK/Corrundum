
require("__base__/prototypes/factoriopedia-util");
local simulations = {}

-----------////////////////////////////////////////////////////////////// INTERMEDIATE PRODUCTS

simulations.factoriopedia_sulfur_ore= { init = make_resource("sulfur-ore") }
simulations.factoriopedia_platinum_ore = { init = make_resource("platinum-ore") }
simulations.factoriopedia_chalcopyrite_ore = { init = make_resource("chalcopyrite_ore") }

return simulations