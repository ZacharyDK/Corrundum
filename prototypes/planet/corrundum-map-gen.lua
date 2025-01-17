local planet_map_gen = require("__space-age__/prototypes/planet/planet-map-gen")

--build off of space ages planet gen.



--PLANET MAP GEN
planet_map_gen.corrundum = function() --TODO add all my decorations.
    return
    {
        property_expression_names =
        {
          elevation = "elevation_lakes",-- "corrundum_elevation",
          temperature = "corrundum_temperature",
          moisture = "corrundum_moisture",
          aux = "aux_basic",
          cliffiness = "cliffiness_basic",
          cliff_elevation = "cliff_elevation_from_elevation",
          ["entity:platinum-ore:probability"] = "corrundum_platinum_ore_probability",
          ["entity:platinum-ore:richness"] = "corrundum_platinum_ore_richness",
          ["entity:sulfur-ore:probability"] = "corrundum_sulfur_ore_probability",
          ["entity:sulfur-ore:richness"] = "corrundum_sulfur_ore_richness",
          ["entity:calcite:probability"] = "corrundum_calcite_probability",
          ["entity:calcite:richness"] = "corrundum_calcite_richness",
          ["entity:chalcopyrite-ore:probability"] = "corrundum_chalcopyrite_ore_probability",
          ["entity:chalcopyrite-ore:richness"] = "corrundum_chalcopyrite_ore_richness",
        },
        cliff_settings =
        {
          name = "cliff-fulgora",
          control = "fulgora_cliff",
          cliff_elevation_interval = 40,
          cliff_elevation_0 = 80,
          cliff_smoothing = 0
        },
  
        autoplace_controls =
        {
          --Controls now show up except we have several problems. 1 no chalcopyrite or sulfur. 2. Platium needs big mining drills.
          ["platinum_ore"] = {},
          ["calcite"] = {},
          ["sulfur_ore"] = {},
          ["chalcopyrite_ore"] = {},
          ["corrundum-petroleum"] = {},
          ["corrundum_volcanism"] = {},
          ["corrundum-cliff"] = {},
        },
        autoplace_settings =
        {
          ["tile"] =
          {
            settings =
            {
              --nauvis tiles
              ["volcanic-soil-dark"] = {},
              ["volcanic-soil-light"] = {},
              ["volcanic-ash-soil"] = {},
              --end of nauvis tiles
              ["petroleum-tile"] = {},


            }
          },
          ["decorative"] =
          {
            settings =
            {
              -- nauvis decoratives

              -- end of nauvis
              --["vulcanus-rock-decal-large"] = {},
              --["vulcanus-crack-decal-large"] = {},
              --["vulcanus-crack-decal-huge-warm"] = {},
              --["vulcanus-dune-decal"] = {},
              --["vulcanus-sand-decal"] = {},
              ["calcite-stain"] = {},
              ["calcite-stain-small"] = {},
              ["sulfur-stain"] = {},
              ["sulfur-stain-small"] = {},

              ["crater-small"] = {},
              ["crater-large"] = {},
              --["pumice-relief-decal"] = {},
              --["small-volcanic-rock"] = {},
              --["medium-volcanic-rock"] = {},
              --["tiny-volcanic-rock"] = {},
              --["tiny-rock-cluster"] = {},
              --["small-sulfur-rock"] = {},
              --["tiny-sulfur-rock"] = {},
              --["sulfur-rock-cluster"] = {},
              
            }
          },
          ["entity"] =
          {
            settings =
            {
             
              ["calcite"] = {},
              ["sulfur-ore"] = {},
              ["chalcopyrite-ore"] = {},
              ["platinum-ore"] = {},
              ["crater-cliff"] = {},
              ["huge-corrundum-rock"] = {}

            }
          }
        }
    }
end

return planet_map_gen