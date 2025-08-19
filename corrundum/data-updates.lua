table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "petroleum-tile") --shoud fixed bug that petrol tile is not coverage 

--table.insert(data.raw.lab["lab"].inputs, "electrochemical-science-pack")
data.raw["fluid"]["petroleum-gas"].fuel_value = "0.6MJ"


local all_lab_types = data.raw['lab']

local handle_science_populate = true


if (settings.startup["automatically-populate-labs-with-electrochemical-science"].value == false) then handle_science_populate = false end

if(handle_science_populate == true) then
  for k,v in pairs(all_lab_types) do
      table.insert(v.inputs,"electrochemical-science-pack") --add my science pack to all labs
  end
end

if not handle_science_populate then
  table.insert(data.raw["lab"]["pressure-lab"].inputs,"electrochemical-science-pack") --I don't add electrochemical-science-pack to my own prototype. This ensures that I still add it somewhere.
end



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
  recipe = "sulfonated-plastic",
  change = 0.1
}

local recipe_patch_2 = 
{
  type = "change-recipe-productivity",
  recipe = "sulfonated-plastic-production-alt",
  change = 0.1
}

local recipe_patch_3 = 
{
  type = "change-recipe-productivity",
  recipe = "rocket-fuel-catalytic-chemistry",
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

local update_discovery = settings.startup["require-vulcanus-before-corrundum"].value

if(update_discovery == true) then
  data.raw["technology"]["planet-discovery-corrundum"].unit = 
  {
      count = 1000,
      ingredients =
      {
          { "automation-science-pack",      1 },
          { "logistic-science-pack",        1 },
          { "chemical-science-pack",        1 },
          { "space-science-pack",           1 },
          { "metallurgic-science-pack",     1 },
      },
      time = 60
  }
  data.raw["technology"]["planet-discovery-corrundum"].prerequisites = { "space-platform-thruster","metallurgic-science-pack"}
end

local update_reduction_recipes = settings.startup["force-reduction-requires-plates"].value
if(update_reduction_recipes == true) then
  data.raw["recipe"]["force-reduction-iron"].ingredients = 
  {
    {type ="item", name ="iron-plate", amount = 1},
    {type ="fluid", name ="iron-sulfate-solution", amount = 200},
    {type ="fluid", name ="water", amount = 100},
  }

  data.raw["recipe"]["force-reduction-copper"].ingredients = 
  {
    {type ="item", name ="copper-plate", amount = 1},
    {type ="fluid", name ="copper-sulfate-solution", amount = 200},
    {type ="fluid", name ="water", amount = 100},
  }

end


--local alt_unlocks = {"planet-discovery-corrundum"}
--data.raw["recipe"]["lightning-rod"].alternative_unlock_methods =alt_unlocks 

---Other mod compatibility
if(mods["castra"]) then
  table.insert(data.raw["technology"]["special-ammo-productivity"].effects,
  {       
    type = "change-recipe-productivity",
    recipe = "sulfur-poison-capsule",
    change = 0.1
  }
  )

  table.insert(data.raw["technology"]["explosive-ammo-productivity"].effects,
  {       
    type = "change-recipe-productivity",
    recipe = "blue-rocket",
    change = 0.1
  }
  )

end

if(mods["cubium"]) then
  data:extend(
    {        
        {
            type ="recipe",
            name ="electrochemical-science-pack-cubic",
            category ="catalytic-chemistry",
            subgroup = "cubic",
            icons = 
            {
              {
                icon = "__cubium__/graphics/icons/matter-cube-yellow.png",
                scale = 0.9
              },
              {
                icon = "__corrundum__/graphics/icons/electrochemical-science-pack.png",
                scale = 0.6,
              }
            },
            enabled = false,
            ingredients = --TODO rebalence based on what is available. Let me put all the recipes in...
            {
              {type ="item", name ="sulfur", amount = 2},
              {type ="item", name ="platinum-plate", amount = 1},
              {type ="fluid", name ="sulfuric-acid", amount = 100}, 
              {type = "item", name = "inverted-microcube", amount = 1},
              {type = "fluid", name = "dream-concentrate", amount = 50},
            },
            surface_conditions =
            {
                {
                    property ="pressure",
                    min = 6000,
                    max = 6000
                },
                {
                    property ="magnetic-field",
                    min = 99,
                    max = 99
                }
            },
            energy_required = 15,
            results =
            {
              {type ="item", name ="electrochemical-science-pack", amount = 2},
              {type = "item", name = "inverted-dormant-microcube", amount = 1, ignored_by_productivity = 9999}
            },
            allow_productivity = true,
            main_product ="electrochemical-science-pack",
            factoriopedia_description ="Sulfur based science only made on corrundum.",
            crafting_machine_tint =
            {
              primary = {r = 1.000, g = 0.912, b = 0.036, a = 1.000}, --rgb(255, 132, 9)
              secondary = {r = 0.707, g = 0.797, b = 0.335, a = 1.000}, --rgb(203, 160, 85)
              tertiary = {r = 0.681, g = 0.635, b = 0.486, a = 1.000}, --rgb(190, 147, 97)
              quaternary = {r = 1.000, g = 0.804, b = 0.000, a = 1.000}, --rgb(255, 136, 0)
            },
            order = "a",
        },
    }
  )

  table.insert(data.raw["technology"]["cube-mastery-4"].effects,
  {       
    type = "unlock-recipe",
    recipe = "electrochemical-science-pack-cubic",
  }
  )
end

if(mods["vanilla_galore_continued"]) then
  table.insert(data.raw["technology"]["pipe-productivity-infinite"].effects,
  {       
    type = "change-recipe-productivity",
    recipe = "steel-plate-pipe",
    change = 0.1
  }
  )

end