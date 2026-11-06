for _, force in pairs(game.forces) do
    local technologies = force.technologies
    local recipes = force.recipes

    -- An assistive function for safe recipe activation based on technology
    local function link(recipe_name, tech_name)
        local recipe = recipes[recipe_name]
        local tech = technologies[tech_name]
        if recipe and tech then
            recipe.enabled = tech.researched
        end
    end

    -- 1. Standard combinations of recipes and technologies
    link("kinetic-reactive-displacement", "chalcopyrite-processing")
    link("platinum-thruster", "platinum-thruster")
    link("platinum-plate", "platinum-processing")
    link("catalytic-chemical-plant", "catalytic-chemical-plant")
    link("sulfonated-plastic", "sulfonated-plastic")
    link("calcium-sulfate", "calcium-sulfate")
    link("asphalt-c", "asphalt-and-concrete")
    link("asphalt-c-alt", "asphalt-and-concrete")
    link("blue-rocket", "blue-rocket")

    -- 2. Dry Ice Group (One technology unlocks multiple recipes)
    local tech_dry_ice = technologies["dry-ice"]
    if tech_dry_ice then
        local is_researched = tech_dry_ice.researched
        local dry_ice_recipes = {"dry-ice", "dry-ice-alt", "ice-box", "controlled-petrol-combustion"}
        for _, r_name in ipairs(dry_ice_recipes) do
            if recipes[r_name] then recipes[r_name].enabled = is_researched end
        end
        -- Forced update (from original code)
        tech_dry_ice.researched = is_researched
    end

    -- 3. Recipes from Planet Corundum
    link("red-boiler", "planet-discovery-corrundum")
    link("red-steam-engine", "planet-discovery-corrundum")

    -- 4. A recipe always available
    if recipes["hydrogen-sulfide"] then
        recipes["hydrogen-sulfide"].enabled = true
    end

    -- 5. Logic for Pressure Lab
    -- We check the basic conditions from the original code
    link("pressure-lab", "pressure-lab")

    -- Checking the technology's alternative name
    if technologies["pressure-laboratory"] ~= nil then
        if recipes["pressure-lab"] then recipes["pressure-lab"].enabled = true end
        if technologies["pressure-lab"] then technologies["pressure-lab"].researched = true end
    end

    -- Checking the list of technologies for forced opening of the laboratory
    local tech_list = {"space-steam-production", "platinum-thruster", "dry-ice", "sulfur-poison-capsule", "blue-rocket"}
    local any_researched = false

    for _, t_name in ipairs(tech_list) do
        if technologies[t_name] and technologies[t_name].researched then
            any_researched = true
            break
        end
    end

    if any_researched then
        if recipes["pressure-lab"] then recipes["pressure-lab"].enabled = true end
        if technologies["pressure-lab"] then technologies["pressure-lab"].researched = true end
    end
end
