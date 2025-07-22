for index, force in pairs(game.forces) do
    local technologies = force.technologies
    local recipes = force.recipes
  

    recipes["kinetic-reactive-displacement"].enabled = technologies["chalcopyrite-processing"].researched
    recipes["platinum-thruster"].enabled = technologies["platinum-thruster"].researched
    recipes["platinum-plate"].enabled = technologies["platinum-processing"].researched
    recipes["catalytic-chemical-plant"].enabled = technologies["catalytic-chemical-plant"].researched
    recipes["sulfonated-plastic"].enabled = technologies["sulfonated-plastic"].researched
    recipes["calcium-sulfate"].enabled = technologies["calcium-sulfate"].researched
    recipes["asphalt-c"].enabled = technologies["asphalt-and-concrete"].researched
    recipes["asphalt-c-alt"].enabled = technologies["asphalt-and-concrete"].researched
    local val = (force.technologies["blue-rocket"].researched)
    recipes["blue-rocket"].enabled = val
    local val = (force.technologies["dry-ice"].researched )
    recipes["dry-ice"].enabled = val
    recipes["dry-ice-alt"].enabled = val
    recipes["ice-box"].enabled = val
    recipes["controlled-petrol-combustion"].enabled = val
    force.technologies["dry-ice"].researched = val
    recipes["hydrogen-sulfide"].enabled = true

    recipes["red-boiler"].enabled = technologies["planet-discovery-corrundum"].researched
    recipes["red-steam-engine"].enabled = technologies["planet-discovery-corrundum"].researched
    recipes["red-steam-engine"].enabled = technologies["planet-discovery-corrundum"].researched
    recipes["pressure-lab"].enabled = technologies["pressure-lab"].researched

    if(technologies["pressure-laboratory"] ~= nil) then
      recipes["pressure-lab"].enabled = true
      technologies["pressure-lab"].researched = true
    end

    if(technologies["space-steam-production"].researched or technologies["platinum-thruster"].researched or technologies["dry-ice"].researched or technologies["sulfur-poison-capsule"].researched or technologies["blue-rocket"].researched ) then
      recipes["pressure-lab"].enabled = true
      technologies["pressure-lab"].researched = true
    end

  end