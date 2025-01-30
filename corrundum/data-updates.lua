--table.insert(data.raw.lab["lab"].inputs, "electrochemical-science-pack")
data.raw["fluid"]["petroleum-gas"].fuel_value = "0.6MJ"


local all_lab_types = data.raw['lab']
--local all_science_packs = data.raw['tool']['science-pack'] --WHY IS THIS NIL ?!?!??! AND WHY does data.raw['tool'] not iterate to a string

local handle_science_populate = true

--(if planetlib exists and we care) or or we don't want to populate
if ( (mods["PlanetsLib"] ~= nil and settings.startup["consider-planetslib"].value == true) or settings.startup["automatically-populate-labs-with-electrochemical-science"].value == false) then handle_science_populate = false end

if(handle_science_populate == true) then
  for k,v in pairs(all_lab_types) do
      table.insert(v.inputs,"electrochemical-science-pack") --add my science pack to all labs
  end
end


--[[
for k,v in pairs(all_science_packs) do
    table.insert(data.raw["lab"]["pressure-lab"].inputs,v .. ",")
end
--]]


data.raw["assembling-machine"]["catalytic-chemical-plant"].graphics_set.frozen_patch =
{
  north =
  {
    filename = "__space-age__/graphics/entity/frozen/chemical-plant/chemical-plant-frozen.png",
    priority = "high",
    width = 220,
    height = 292,
    shift = util.by_pixel(0.5, -9),
    scale = 0.5
  },
  east =
  {
    filename = "__space-age__/graphics/entity/frozen/chemical-plant/chemical-plant-frozen.png",
    priority = "high",
    x = 220,
    width = 220,
    height = 292,
    shift = util.by_pixel(0.5, -9),
    scale = 0.5
  },
  south =
  {
    filename = "__space-age__/graphics/entity/frozen/chemical-plant/chemical-plant-frozen.png",
    priority = "high",
    x = 220 * 2,
    width = 220,
    height = 292,
    shift = util.by_pixel(0.5, -9),
    scale = 0.5
  },
  west =
  {
    filename = "__space-age__/graphics/entity/frozen/chemical-plant/chemical-plant-frozen.png",
    priority = "high",
    x = 220 * 3,
    width = 220,
    height = 292,
    shift = util.by_pixel(0.5, -9),
    scale = 0.5
  }
}

local recipe_patch = 
{
  type = "change-recipe-productivity",
  recipe = "sulfonated-plastic-production",
  change = 0.1
}

local recipe_patch_2 = 
{
  type = "change-recipe-productivity",
  recipe = "sulfonated-plastic-production-alt",
  change = 0.1
}

table.insert(data.raw.technology["plastic-bar-productivity"].effects,recipe_patch)
table.insert(data.raw.technology["plastic-bar-productivity"].effects,recipe_patch_2)




local brute_force = settings.startup["ignore-everything-brute-force-science-into-pressure-lab"].value
local all_packs = data.raw['tool']
if(brute_force == true) then
  if(mods["PlanetsLib"] ~= nil) then
    data.raw["lab"]["pressure-lab"].include_all_base_lab_science = false --Disable what they want to do.
  end

  data.raw["lab"]["pressure-lab"].inputs = {}
  for k,v in pairs(all_packs) do
    if(v.subgroup == "science-pack") then
      table.insert(data.raw["lab"]["pressure-lab"].inputs,v.name .. ",")
    end
  end
end