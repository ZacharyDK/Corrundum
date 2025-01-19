local seconds = 60
local minutes = 60*seconds

--TODO balence recipe time cost.

-- TODO proofread
-- Crafting machine tints.

data:extend(
{
    --BASICS
    
    {
        type ="recipe",
        name ="electrochemical-science-pack",
        category ="catalytic-chemistry",
        icon ="__corrundum__/graphics/icons/electrochemical-science-pack.png",
        enabled = false,
        ingredients = --TODO rebalence based on what is available. Let me put all the recipes in...
        {
          {type ="item", name ="sulfur", amount = 2},
          {type ="item", name ="platinum-plate", amount = 1},
          {type ="fluid", name ="sulfuric-acid", amount = 100} --Maybe a more advanced recipe will make more of this science. With mixed sulfate solution
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
          {type ="item", name ="electrochemical-science-pack", amount = 1}
        },
        allow_productivity = true,
        main_product ="electrochemical-science-pack",
        factoriopedia_description ="Sulfur based science only made on corrundum."
    },

    {
      type ="recipe",
      name ="platinum-plate-production",
      category ="metallurgy",
      icon ="__corrundum__/graphics/icons/platinum-plate.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="platinum-ore", amount = 4},
      },

      energy_required = 10,
      results =
      {
        {type ="item", name ="platinum-plate", amount = 1}
      },
      allow_productivity = true,
      allow_quality = true,
      main_product ="platinum-plate",
      factoriopedia_description ="Refine platinum from ore."
    },
    {
      type ="recipe",
      name ="platinum-plate-production-alt",
      category ="smelting",
      icon ="__corrundum__/graphics/icons/platinum-plate.png",
      enabled = false,
      ingredients =
      {
        {type ="item", name ="platinum-ore", amount = 4},
      },

      energy_required = 12,
      results =
      {
        {type ="item", name ="platinum-plate", amount = 1}
      },
      allow_productivity = true,
      allow_quality = true,
      main_product ="platinum-plate",
      factoriopedia_description ="Refine platinum from ore."
    },
    {
      type ="recipe",
      name ="catalytic-chemical-plant-recipe",
      category ="crafting",
      icon ="__corrundum__/graphics/icons/catalytic-chemical-plant.png",
      enabled = false,
      ingredients =
      {
        {type ="item", name ="platinum-plate", amount = 10},
        {type ="item", name ="electronic-circuit", amount = 2},
        {type ="item", name ="chemical-plant", amount = 1},
        {type ="item", name ="copper-cable", amount = 5},
      },

      energy_required = 20,
      results =
      {
        {type ="item", name ="catalytic-chemical-plant", amount = 1}
      },
      allow_productivity = false,
      allow_quality = true,
      main_product ="catalytic-chemical-plant",
      factoriopedia_description ="Produce a chemical plant that specializes in using platinum as a catalyst."
    },
    {
      type ="recipe",
      name ="pressurized-acid-neutralization",
      category ="chemistry-or-cryogenics",
      icon ="__space-age__/graphics/icons/fluid/acid-neutralisation.png",
      enabled = false,
      subgroup ="fluid-recipes",
      order ="d[other-chemistry]-a[pressurized-acid-neutralisation]",
      auto_recycle = false,
      enabled = false,
      surface_conditions =
      {
        {
          property ="pressure",
          min = 6000,
          max = 6000
        }
      },
      ingredients =
      {
        {type ="item", name ="calcite", amount = 1},
        {type ="fluid", name ="sulfuric-acid", amount = 1000},
        {type ="fluid", name ="water", amount = 180},
      },
      energy_required = 5,
      results =
      {
        {type ="fluid", name ="steam", amount = 12000, temperature = 500}
      },
      allow_productivity = false,
      always_show_products = true,
      show_amount_in_title = false,
      allow_decomposition = false,
      crafting_machine_tint =
      {
        primary = {r = 1.000, g = 0.912, b = 0.036, a = 1.000}, -- #ffe809ff
        secondary = {r = 0.707, g = 0.797, b = 0.335, a = 1.000}, -- #b4cb55ff
        tertiary = {r = 0.681, g = 0.635, b = 0.486, a = 1.000}, -- #ada17bff
        quaternary = {r = 1.000, g = 0.804, b = 0.000, a = 1.000}, -- #ffcd00ff
      },
      factoriopedia_description ="Even higher pressures and surface conditions on Corrundum let us get even more energy from acid neutralization."
    },
    {
      type ="recipe",
      name ="pressurized-acid-neutralization-alt",
      category ="chemistry-or-cryogenics",
      icon ="__space-age__/graphics/icons/fluid/acid-neutralisation.png",
      enabled = false,
      subgroup ="fluid-recipes",
      order ="d[other-chemistry]-a[pressurized-acid-neutralisation]",
      auto_recycle = false,
      enabled = false,
      surface_conditions =
      {
        {
          property ="pressure",
          min = 6000,
          max = 6000
        }
      },
      ingredients =
      {
        {type ="item", name ="calcite", amount = 1},
        {type ="fluid", name ="sulfuric-acid", amount = 1000},
      },
      energy_required = 5,
      results =
      {
        {type ="fluid", name ="steam", amount = 10000, temperature = 500}
      },
      allow_productivity = false,
      always_show_products = true,
      show_amount_in_title = false,
      allow_decomposition = false,
      crafting_machine_tint =
      {
        primary = {r = 1.000, g = 0.912, b = 0.036, a = 1.000}, -- #ffe809ff
        secondary = {r = 0.707, g = 0.797, b = 0.335, a = 1.000}, -- #b4cb55ff
        tertiary = {r = 0.681, g = 0.635, b = 0.486, a = 1.000}, -- #ada17bff
        quaternary = {r = 1.000, g = 0.804, b = 0.000, a = 1.000}, -- #ffcd00ff
      },
      factoriopedia_description ="We need more water to capture all energy released, but this should help get things started."
    },

    {
      type ="recipe",
      name ="dilute-acid-neutralization",
      category ="chemistry-or-cryogenics",
      icon ="__base__/graphics/icons/fluid/water.png",
      enabled = false,
      subgroup ="fluid-recipes",
      order ="d[other-chemistry]-b[pressurized-acid-neutralisation]",
      auto_recycle = false,
      enabled = false,
      surface_conditions =
      {
        {
          property ="pressure",
          min = 0,
          max = 6000
        }
      },
      ingredients =
      {
        {type ="item", name ="calcite", amount = 1},
        {type ="fluid", name ="sulfuric-acid-dilute", amount = 2000},
      },
      energy_required = 2,
      results =
      {
        {type ="fluid", name ="water", amount = 2000, temperature = 100}
      },
      allow_productivity = false,
      always_show_products = true,
      show_amount_in_title = false,
      allow_decomposition = false,
      crafting_machine_tint =
      {
        primary = {r = 1.000, g = 0.912, b = 0.036, a = 1.000}, -- #ffe809ff
        secondary = {r = 0.707, g = 0.797, b = 0.335, a = 1.000}, -- #b4cb55ff
        tertiary = {r = 0.681, g = 0.635, b = 0.486, a = 1.000}, -- #ada17bff
        quaternary = {r = 1.000, g = 0.804, b = 0.000, a = 1.000}, -- #ffcd00ff
      },
      factoriopedia_description ="We need more water to capture all energy released, but this should help get things started."
    },



    --STEP 1 Sulfur Redox 
    {
        type ="recipe",
        name ="petroleum-alkylation",
        category ="catalytic-chemistry",
        icon ="__corrundum__/graphics/icons/petrol-alkylation.png",
        enabled = false,
        ingredients =
        {

          {type ="fluid", name ="sulfuric-acid", amount = 100},
          {type ="fluid", name ="petroleum-gas", amount = 40},
        },

        energy_required = 7,
        results =
        {
          {type ="fluid", name ="light-oil", amount = 10}
        },
        allow_productivity = false,
        allow_quality = false,
        main_product ="light-oil",
        factoriopedia_description ="Large amounts of sulfuric acid can form carbocations, which are used as the basis for alkylation to form new carbon-carbon bonds."
    },
    {
        type ="recipe",
        name ="light-oil-alkylation",
        category ="catalytic-chemistry",
        icon ="__corrundum__/graphics/icons/light-oil-alkylation.png",
        enabled = false,
        ingredients =
        {

          {type ="fluid", name ="sulfuric-acid", amount = 100},
          {type ="fluid", name ="light-oil", amount = 40},
        },

        energy_required = 10,
        results =
        {
          {type ="fluid", name ="heavy-oil", amount = 10}
        },
        allow_productivity = false,
        allow_quality = false,
        main_product ="heavy-oil",
        factoriopedia_description ="Large amounts of sulfuric acid can form carbocations, which are used as the basis for alkylation to form new carbon-carbon bonds. We use this form heavy oil."
    },
    {
        type ="recipe",
        name ="sulfur-combustion",
        category ="chemistry",
        icon ="__corrundum__/graphics/icons/fluid/sulfur-dioxide.png",
        enabled = false,
        surface_conditions =
        {
          {
            property ="pressure",
            min = 300,
            max = 110000
          }
        },
        ingredients =
        {

          {type ="item", name ="sulfur", amount = 1}

        },

        energy_required = 1,
        results =
        {
          {type ="fluid", name ="sulfur-dioxide", amount = 50}
        },
        allow_productivity = true,
        allow_quality = false,
        main_product ="sulfur-dioxide",
        factoriopedia_description ="Burning sulfur lets us get this gas, which we can use to make both sulfuric acid and water."
    },
    {
        type ="recipe",
        name ="hydrogen-sulfide-production",
        category ="catalytic-chemistry",
        icon ="__corrundum__/graphics/icons/fluid/hydrogen-sulfide.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="sulfur", amount = 1},
          {type ="fluid", name ="petroleum-gas", amount = 200},
        },

        energy_required = 15,
        results =
        {
          {type ="fluid", name ="hydrogen-sulfide", amount = 50},
          {type ="fluid", name ="petroleum-gas", amount = 170},
        },
        allow_productivity = false,
        allow_quality = false,
        maximum_productivity = 1,
        main_product ="hydrogen-sulfide",
        factoriopedia_description ="With a platinum catalyst, we can use petroleum to hydrogenate sulfur to get hydrogen sulfide."
    },
    {
        type ="recipe",
        name ="sulfur-reduction",
        category ="chemistry",
        icon ="__base__/graphics/icons/fluid/water.png",
        enabled = false,
        ingredients =
        {

          {type ="fluid", name ="hydrogen-sulfide", amount = 50},
          {type ="fluid", name ="sulfur-dioxide", amount = 50},
        },

        energy_required = 15,
        results =
        {
          {type ="item", name ="sulfur", amount = 2},
          {type ="fluid", name ="water", amount = 100},
        },
        allow_productivity = false,
        allow_quality = false,
        maximum_productivity = 1,
        main_product ="water",
        factoriopedia_description ="Sulfur is reduced to a zero oxidation state, while water is formed."
    },
    {
        type ="recipe",
        name ="sulfurous-oxidation",
        category ="catalytic-chemistry",
        icon ="__base__/graphics/icons/fluid/sulfuric-acid.png",
        enabled = false,
        ingredients =
        {

          {type ="fluid", name ="water", amount = 50},
          {type ="fluid", name ="sulfur-dioxide", amount = 50},
        },

        energy_required = 15,
        results =
        {
          {type ="fluid", name ="sulfuric-acid", amount = 100},
        },
        allow_productivity = true,
        allow_quality = false,
        maximum_productivity = 2,
        main_product ="sulfuric-acid",
        factoriopedia_description ="In the presence of a platinum catalyst, sulfur-dioxide can react with the oxygen to form sulfur trioxide in situ. Sulfur trioxide then reacts with water to form sulfuric acid."
    },

    --STEP 2, Sulfate processing
    {
        type ="recipe",
        name ="hydrogen-sulfide-combustion",
        category ="chemistry",
        icon ="__base__/graphics/icons/fluid/water.png",
        enabled = false,
        ingredients =
        {

          {type ="fluid", name ="hydrogen-sulfide", amount = 100},
        },

        surface_conditions =
        {
          {
            property ="pressure",
            min = 300,
            max = 110000
          }
        },

        energy_required = 15,
        results =
        {
          {type ="fluid", name ="sulfur-dioxide", amount = 200},
          {type ="fluid", name ="water", amount = 200},
        },
        allow_productivity = false,
        allow_quality = false,
        maximum_productivity = 1,
        main_product ="water",
        factoriopedia_description ="Combustion of hydrogen sulfide gives us more components to make sulfuric acid."
    },



    {
        type ="recipe",
        name ="chalcopyrite-refining",
        category ="chemistry",
        icon ="__corrundum__/graphics/icons/fluid/mixed-sulfate-solution.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="chalcopyrite-ore", amount = 5},
          {type ="fluid", name ="sulfuric-acid", amount = 500},
        },

        energy_required = 40,
        results =
        {
          {type ="fluid", name ="mixed-sulfate-solution", amount = 500},
        },
        allow_productivity = true, --I'll allow productivity for now
        allow_quality = false,
        maximum_productivity = 2,
        main_product ="mixed-sulfate-solution",
        auto_recycle = false,
        factoriopedia_description ="Chalcopyrite is FeCuS. We blast the ore heat and concentrated sulfuric acid fully oxidize the metals, forming a mixture of their aqueous sulfate salts."
    },
    {
        type ="recipe",
        name ="reactive-displacement",
        category ="chemistry",
        icon ="__corrundum__/graphics/icons/fluid/iron-sulfate-solution.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="iron-plate", amount = 1},
          {type ="fluid", name ="mixed-sulfate-solution", amount = 200},
        },

        energy_required = 5,
        results =
        {
          {type ="fluid", name ="iron-sulfate-solution", amount = 200},
          {type ="item", name ="copper-ore", amount = 2}
        },
        allow_productivity = false, 
        auto_recycle = false,
        maximum_productivity = 1,
        main_product ="iron-sulfate-solution",
        --factoriopedia_description ="Iron is more reactive than copper. Thus we can use it to displace copper ions in solution. While the copper crystalizes beatifully, it must be reshaped into a workable form."
    },
    {
        type ="recipe",
        name ="force-reduction-iron",
        category ="chemistry",
        icon ="__base__/graphics/icons/iron-ore.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="iron-plate", amount = 1},
          {type ="fluid", name ="iron-sulfate-solution", amount = 200},
          {type ="fluid", name ="water", amount = 100}, --Why do I need more water, its aqueous already. Oh for washing the products...
        },

        energy_required = 15,
        results =
        {
          {type ="fluid", name ="sulfuric-acid-dilute", amount = 280}, --some fluid lost.
          {type ="item", name ="iron-ore", amount = 3}
        },
        allow_productivity = false,
        auto_recycle = false,
        maximum_productivity = 1,
        main_product ="iron-ore",
        --factoriopedia_description ="We can use voltage to pump electronics into the ionic solution. These electrons reduce aqueous ferric ions in to pure iron. However, an iron plate must be used to seed crystal growth, and of course the pure product must be shaped back into plates."
    },
    {
        type ="recipe",
        name ="force-reduction-copper",
        category ="chemistry",
        icon ="__base__/graphics/icons/copper-ore.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="copper-plate", amount = 1},
          {type ="fluid", name ="copper-sulfate-solution", amount = 200},
          {type ="fluid", name ="water", amount = 100},
        },

        energy_required = 17,
        results =
        {
          {type ="fluid", name ="sulfuric-acid-dilute", amount = 280},
          {type ="item", name ="copper-ore", amount = 3}
        },
        allow_productivity = false, 
        maximum_productivity = 1,
        main_product ="copper-ore",
        auto_recycle = false,
        --factoriopedia_description ="Similiar to reduction of ferric sulfate, we pump electrons in and they reduce copper ions."
    },
    -- STEP 3 optimization and plastics, and alkylation. (Alkylation moved to steps 3+4)

    {
        type ="recipe",
        name ="sulfonated-plastic-production",
        category ="catalytic-chemistry",
        icon ="__base__/graphics/icons/plastic-bar.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="solid-fuel", amount = 3},
          {type ="fluid", name ="sulfuric-acid", amount = 110},
          {type ="fluid", name ="sulfur-dioxide", amount = 110},
          {type ="fluid", name ="light-oil", amount = 10},
        },

        energy_required = 5,
        results =
        {
          {type ="item", name ="plastic-bar", amount = 4}
        },
        allow_productivity = true, 
        maximum_productivity = 5,
        main_product ="plastic-bar",
        auto_recycle = false,
        --factoriopedia_description ="With a platinum catalyst, we use sulfur dioxide and oxygen to form sulfur trioxide. Sulfur trioxide reacts with sulfuric acid to form fuming sulfuric acid, which can sulfonate hydrocarbons."
    },
    {
      type ="recipe",
      name ="sulfonated-plastic-production-alt",
      category ="catalytic-chemistry",
      icon ="__base__/graphics/icons/plastic-bar.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="solid-fuel", amount = 2},
        {type ="fluid", name ="sulfuric-acid", amount = 110},
        {type ="fluid", name ="sulfur-dioxide", amount = 110},
        {type ="fluid", name ="heavy-oil", amount = 8},
      },

      energy_required = 7,
      results =
      {
        {type ="item", name ="plastic-bar", amount = 5}
      },
      allow_productivity = true, 
      maximum_productivity = 5,
      main_product ="plastic-bar",
      auto_recycle = false,
      --factoriopedia_description ="With a platinum catalyst, we use sulfur dioxide and oxygen to form sulfur trioxide. Sulfur trioxide reacts with sulfuric acid to form fuming sulfuric acid, which can sulfonate hydrocarbons."
    },



    {
        type ="recipe",
        name ="calcium-sulfate-fish",
        category ="chemistry",
        icon ="__space-age__/graphics/icons/nutrients.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="carbon", amount = 2},
          {type ="item", name ="calcium-sulfate", amount = 2},
          {type ="item", name ="raw-fish", amount = 1}
        },

        energy_required = 2,
        results =
        {
          {type ="item", name ="nutrients", amount = 40}
        },
        allow_productivity = true, 
        maximum_productivity = 2,
        --main_product ="nutrients",
        --factoriopedia_description ="With a nitrogen and phosphorous source, we add more carbon and calcium sulfate to optimize nutrient production."

    },
    {
        type ="recipe",
        name ="calcium-sulfate-bioflux",
        category ="chemistry",
        icon ="__space-age__/graphics/icons/nutrients.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="carbon", amount = 4},
          {type ="item", name ="calcium-sulfate", amount = 4},
          {type ="item", name ="bioflux", amount = 5}
        },

        energy_required = 4,
        results =
        {
          {type ="item", name ="nutrients", amount = 80}
        },
        allow_productivity = true, 
        maximum_productivity = 2,
        --main_product ="nutrients",
        --factoriopedia_description ="With a nitrogen and phosphorous source, we add more carbon and calcium sulfate to optimize nutrient production."

    },
    {
        type ="recipe",
        name ="calcium-sulfate-egg",
        category ="chemistry",
        icon ="__space-age__/graphics/icons/nutrients.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="carbon", amount = 2},
          {type ="item", name ="calcium-sulfate", amount = 2},
          {type ="item", name ="biter-egg", amount = 1}
        },

        energy_required = 2,
        results =
        {
          {type ="item", name ="nutrients", amount = 40}
        },
        allow_productivity = true, 
        maximum_productivity = 2,
        --main_product ="nutrients",
        --factoriopedia_description ="With a nitrogen and phosphorous source, we add more carbon and calcium sulfate to optimize nutrient production."

    },
    {
        type ="recipe",
        name ="calcium-sulfate-production",
        category ="chemistry",
        icon ="__corrundum__/graphics/icons/calcium-sulfate.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="calcite", amount = 2},
          {type ="fluid", name ="sulfuric-acid-dilute", amount = 100},
        },

        energy_required = 10,
        results =
        {
          {type ="item", name ="calcium-sulfate", amount = 2},
          {type ="fluid", name ="water", amount = 100}
        },
        allow_productivity = false, 
        maximum_productivity = 1,
        main_product ="calcium-sulfate",
        --factoriopedia_description ="We neutralize dilute sulfuric acid and collect the salt with evaporation. Adding calcite directly to concentrated sulfuric acid releases a lot of energy, making it difficult to collect a salt that way. Most of the time here is spent drying out the salt."

    },
    {
        type ="recipe",
        name ="sulfuric-acid-dilution",
        category ="chemistry",
        icon ="__corrundum__/graphics/icons/fluid/sulfuric-acid-dilute.png",
        enabled = false,
        ingredients =
        {

          {type ="fluid", name ="sulfuric-acid", amount = 100},
          {type ="fluid", name ="water", amount = 400},
        },

        energy_required = 10,
        results =
        {
          {type ="fluid", name ="sulfuric-acid-dilute", amount = 500},
        },
        allow_productivity = false,
        allow_quality = false, 
        maximum_productivity = 1,
        main_product ="sulfuric-acid-dilute",
        factoriopedia_description ="Add acid to water to dilute safely, not the otherway around."

    },
    {
        type ="recipe",
        name ="sulfuric-acid-concentration",
        category ="chemistry",
        icon ="__base__/graphics/icons/fluid/sulfuric-acid.png",
        enabled = false,
        ingredients =
        {

          {type ="fluid", name ="sulfuric-acid-dilute", amount = 500},
        },

        energy_required = 300,
        results =
        {
          {type ="fluid", name ="sulfuric-acid", amount = 100},
          {type ="fluid", name ="steam", amount = 4400, temperature = 500},
        },
        allow_productivity = false, 
        allow_quality = false,
        maximum_productivity = 1,
        main_product ="sulfuric-acid",
        factoriopedia_description ="We spend alot of energy boiling off water into steam, which can be condensed back into water."

    },
    {
      type ="recipe",
      name ="sulfuric-acid-concentration-alt",
      category ="chemistry",
      icon ="__base__/graphics/icons/fluid/sulfuric-acid.png",
      enabled = false,
      ingredients =
      {

        {type ="fluid", name ="sulfuric-acid-dilute", amount = 500},
      },

      energy_required = 100,
      results =
      {
        {type ="fluid", name ="sulfuric-acid", amount = 100},
      },
      allow_productivity = false, 
      allow_quality = false,
      maximum_productivity = 1,
      main_product ="sulfuric-acid",
      factoriopedia_description ="We spend alot of energy boiling off water, and don't bother to catch it."

    },
    {
        type ="recipe",
        name ="calcium-sulfate-production-alt",
        category ="chemistry",
        icon ="__corrundum__/graphics/icons/calcium-sulfate.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="calcite", amount = 2},
          {type ="fluid", name ="sulfur-dioxide", amount = 50},
        },

        energy_required = 5,
        results =
        {
          {type ="item", name ="calcium-sulfate", amount = 2},
        },
        allow_productivity = false, 
        maximum_productivity = 1,
        main_product ="calcium-sulfate",
        factoriopedia_description ="Sulfur-dioxide and calcium carbonate react to form calcium sulfate and carbon dioxide."

    },
    {
        type ="recipe",
        name ="stone-production",
        category ="chemistry",
        icon ="__base__/graphics/icons/stone.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="calcium-sulfate", amount = 2},
          {type ="item", name ="stone", amount = 1},
          {type ="item", name ="carbon", amount = 2},
        },

        energy_required = 5,
        results =
        {
          {type ="item", name ="stone", amount = 2},
          {type ="fluid", name ="sulfur-dioxide", amount = 50}
        },
        allow_productivity = false, 
        maximum_productivity = 1,
        main_product ="stone",
        factoriopedia_description ="Stone is represented by SiO2 (reactant) and CaSiO3 (product). Analagous to making stone on Vulcanus.",
        auto_recycle = false,

    },

    -- STEP 4. asphalt and concrete production.
    {
        type ="recipe",
        name ="asphalt-production",
        category ="chemistry",
        icon ="__corrundum__/graphics/icons/asphalt.png",
        enabled = false,
        ingredients =
        {

          {type ="fluid", name ="heavy-oil", amount = 35},
          {type ="fluid", name ="sulfuric-acid", amount = 50}
        },

        energy_required = 15,
        results =
        {
          {type ="item", name ="asphalt", amount = 1},
        },
        allow_productivity = true, 
        main_product ="asphalt",
        factoriopedia_description ="We condense heavy oil into a concrete precusor.",
        auto_recycle = false,

    },
    {
        type ="recipe",
        name ="asphalt-production-alt",
        category ="chemistry",
        icon ="__corrundum__/graphics/icons/asphalt.png",
        enabled = false,
        ingredients =
        {

          {type ="fluid", name ="light-oil", amount = 160},
          {type ="fluid", name ="sulfuric-acid", amount = 75}
        },

        energy_required = 10,
        results =
        {
          {type ="item", name ="asphalt", amount = 1},
        },
        allow_productivity = true, 
        main_product ="asphalt",
        factoriopedia_description ="We can also use excess light oil to make asphalt. Reaction is faster, but less efficient.",
        auto_recycle = false,

    },
    {
        type ="recipe",
        name ="concrete-production-from-asphalt",
        category ="crafting-with-fluid",
        icon ="__base__/graphics/icons/concrete.png",
        enabled = false,
        ingredients =
        {

          {type ="item", name ="asphalt", amount = 4},
          {type ="item", name ="stone", amount = 1},
          {type ="fluid", name ="water", amount = 50},
        },

        energy_required = 8,
        results =
        {
          {type ="item", name ="concrete", amount = 10},
        },
        allow_productivity = true, 
        main_product ="concrete",
        factoriopedia_description ="Asphalt and stone makes concrete.",
        auto_recycle = false,

    },
    {
      type ="recipe",
      name ="calcium-sulfate-recovery",
      category ="chemistry",
      icon ="__corrundum__/graphics/icons/calcium-sulfate.png",
      enabled = false,
      ingredients =
      {
        {type = "item", name = "nutrients", amount = 160},
        {type ="fluid", name ="sulfuric-acid", amount = 100}, 
        {type ="fluid", name ="water", amount = 600}, 
        {type ="fluid", name ="light-oil", amount = 150},

      },

      energy_required = 60,
      results =
      {
        {type ="item", name ="calcium-sulfate", amount = 2},
      },
      allow_productivity = true, 
      maximum_productivity = 2,
      main_product ="calcium-sulfate",

    },



    --Other
    {
      type ="recipe",
      name ="pressure-laboratory-recipe",
      category ="crafting",
      icon ="__corrundum__/graphics/icons/pressure-lab.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="chemical-plant", amount = 1},
        {type ="item", name ="platinum-plate", amount = 4},
        {type ="item", name ="lab", amount = 1},
        {type ="item", name ="steam-turbine", amount = 1},
        {type ="item", name ="steel-plate", amount = 10},
      },

      energy_required = 30,
      results =
      {
        {type ="item", name ="pressure-lab", amount = 1},
      },
      allow_productivity = false, 
      main_product ="pressure-lab",

    },
    {
      type ="recipe",
      name ="red-boiler-recipe",
      category ="crafting",
      icon ="__corrundum__/graphics/icons/red-boiler.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="boiler", amount = 1},
        {type ="item", name ="copper-plate", amount = 10},
      },

      energy_required = 7,
      results =
      {
        {type ="item", name ="red-boiler", amount = 1},
      },
      allow_productivity = false, 
      main_product ="red-boiler",

    },
    {
      type ="recipe",
      name ="red-steam-engine-recipe",
      category ="crafting",
      icon ="__corrundum__/graphics/icons/red-steam-engine.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="steam-engine", amount = 1},
        {type ="item", name ="copper-plate", amount = 10},
        {type ="item", name ="iron-plate", amount = 10},
      },

      energy_required = 7,
      results =
      {
        {type ="item", name ="red-steam-engine", amount = 1},
      },
      allow_productivity = false, 
      main_product ="red-steam-engine",

    },
    {
      type ="recipe",
      name ="thruster-fuel-oxidizer-to-steam",
      category ="catalytic-chemistry",
      icon ="__base__/graphics/icons/fluid/steam.png",
      enabled = false,
      ingredients =
      {

        {type ="fluid", name ="thruster-fuel", amount = 500},
        {type ="fluid", name ="water", amount = 250},
        {type ="fluid", name ="thruster-oxidizer", amount = 500},
      },

      energy_required = 20, --Alright, multiplied values wildly. Should be a fair nerf don't want to out class nuclear.
      results =
      {
        {type ="fluid", name ="steam", amount = 500, temperature = 500},
      },
      allow_productivity = true, 
      allow_quality = false,
      auto_recycle = false,
      main_product ="steam",


    },
    {
      type ="recipe",
      name ="carbon-dioxide-to-carbon",
      category ="catalytic-chemistry",
      icon ="__space-age__/graphics/icons/carbon.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="iron-plate", amount = 2},
        {type ="fluid", name = "sulfuric-acid", amount = 100},
        {type ="fluid", name = "carbon-dioxide", amount = 300},
      },

      energy_required = 5, 
      results =
      {
        {type ="item", name ="carbon", amount = 1},
        {type ="fluid", name ="iron-sulfate-solution", amount = 100},
      },
      allow_productivity = true, 
      allow_quality = true,
      auto_recycle = false,
      main_product ="carbon",


    },
    {
      type ="recipe",
      name ="controlled-petrol-combustion",
      category ="chemistry",
      icon = "__corrundum__/graphics/icons/fluid/carbon-dioxide.png",
      enabled = false,
      ingredients =
      {

        {type ="fluid", name = "petroleum-gas", amount = 300},
      },

      energy_required = 1, 
      results =
      {
        {type ="fluid", name = "carbon-dioxide", amount = 600, temperature = 100},
      },
      allow_productivity = true, 
      allow_quality = true,
      auto_recycle = false,
      main_product ="carbon-dioxide",


    },
    {
      type ="recipe",
      name ="ice-box-production",
      category ="crafting",
      icon = "__corrundum__/graphics/icons/ice-box.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="wood", amount = 2},
        {type ="item", name = "plastic-bar", amount = 20},
      },

      energy_required = 2,
      results =
      {
        {type ="item", name ="ice-box", amount = 1},
      },
      allow_productivity = false, 
      allow_quality = true,
      auto_recycle = true,
      main_product ="ice-box",


    },
    {
      type ="recipe",
      name ="dry-ice-production",
      category ="cryogenics",
      icon = "__corrundum__/graphics/icons/dry-ice.png",
      enabled = false,
      ingredients =
      {

        {type ="fluid", name ="carbon-dioxide", amount = 1000},
        {type ="fluid", name ="fluoroketone-cold", amount = 50},
      },

      energy_required = 7,
      results =
      {
        {type ="item", name ="dry-ice", amount = 500},
        {type ="fluid", name ="fluoroketone-hot", amount = 25},
      },
      allow_productivity = true, 
      maximum_productivity = 2,
      allow_quality = true,
      auto_recycle = false,
      main_product ="dry-ice",


    },
    {
      type ="recipe",
      name ="dry-ice-production-alt",
      category ="catalytic-chemistry",
      icon = "__corrundum__/graphics/icons/dry-ice.png",
      enabled = false,
      ingredients =
      {

        {type ="fluid", name ="carbon-dioxide", amount = 1000},
        {type ="fluid", name ="water", amount = 500, maximum_temperature = 21},
      },

      energy_required = 150,
      results =
      {
        {type ="item", name ="dry-ice", amount = 500},
        {type ="fluid", name ="water", amount = 500, temperature = 90},
      },
      allow_productivity = false, 
      --maximum_productivity = true,
      allow_quality = true,
      auto_recycle = false,
      main_product ="dry-ice",


    },
    --Crystalization and recrystalization
    {
      type ="recipe",
      name ="copper-recrystalization",
      category ="chemistry",
      icon ="__corrundum__/graphics/icons/fluid/copper-sulfate-solution.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="copper-plate", amount = 5},
        {type ="fluid", name ="sulfuric-acid", amount = 200},
      },

      energy_required = 4,
      results =
      {
        {type ="fluid", name ="copper-sulfate-solution", amount = 200},
      },
      allow_productivity = false, 
      maximum_productivity = 1,
      main_product ="copper-sulfate-solution",
      auto_recycle = false,

    },
    {
      type ="recipe",
      name ="copper-recrystalization-alt",
      category ="chemistry",
      icon ="__corrundum__/graphics/icons/fluid/copper-sulfate-solution.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="copper-cable", amount = 16},
        {type ="fluid", name ="sulfuric-acid", amount = 200},
      },

      energy_required = 4,
      results =
      {
        {type ="fluid", name ="copper-sulfate-solution", amount = 200},
      },
      allow_productivity = false, 
      maximum_productivity = 1,
      main_product ="copper-sulfate-solution",
      auto_recycle = false,

    },
    {
      type ="recipe",
      name ="iron-recrystalization",
      category ="chemistry",
      icon ="__corrundum__/graphics/icons/fluid/iron-sulfate-solution.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="iron-plate", amount = 5},
        {type ="fluid", name ="sulfuric-acid", amount = 200},
      },

      energy_required = 4,
      results =
      {
        {type ="fluid", name ="iron-sulfate-solution", amount = 200},
      },
      allow_productivity = false, 
      maximum_productivity = 1,
      main_product ="iron-sulfate-solution",
      auto_recycle = false,

    },
    {
      type ="recipe",
      name ="iron-recrystalization-alt",
      category ="chemistry",
      icon ="__corrundum__/graphics/icons/fluid/iron-sulfate-solution.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="iron-gear-wheel", amount = 16},
        {type ="fluid", name ="sulfuric-acid", amount = 200},
      },

      energy_required = 4,
      results =
      {
        {type ="fluid", name ="iron-sulfate-solution", amount = 200},
      },
      allow_productivity = false, 
      maximum_productivity = 1,
      main_product ="iron-sulfate-solution",
      auto_recycle = false,

    },
    {
      type ="recipe",
      name ="iron-stick-recrystalization",
      category ="chemistry",
      icon ="__corrundum__/graphics/icons/fluid/iron-sulfate-solution.png",
      enabled = false,
      ingredients =
      {

        {type ="item", name ="iron-stick", amount = 16},
        {type ="fluid", name ="sulfuric-acid", amount = 200},
      },

      energy_required = 4,
      results =
      {
        {type ="fluid", name ="iron-sulfate-solution", amount = 200},
      },
      allow_productivity = false, 
      maximum_productivity = 1,
      main_product ="iron-sulfate-solution",
      auto_recycle = false,

    },

    --Space goodies
    {
      type ="recipe",
      name ="platinum-thruster-production",
      category ="crafting",
      icon = "__corrundum__/graphics/icons/platinum-thruster-icon.png",
      enabled = false,
      ingredients =
      {
        {type = "item", name = "steel-plate", amount = 20},
        {type = "item", name = "processing-unit", amount = 12},
        {type = "item", name = "electric-engine-unit", amount = 7},
        {type = "item", name = "platinum-plate", amount = 12},
        {type = "item", name = "tungsten-plate", amount = 10},
      },

      energy_required = 10,
      results =
      {
        {type ="item", name ="platinum-thruster", amount = 1},
      },
      allow_productivity = false, 
      allow_quality = true,
      auto_recycle = true,
      main_product ="platinum-thruster",


    },
})