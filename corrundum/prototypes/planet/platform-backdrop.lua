-- Platform backdrop: how corrundum looks from orbit behind a space platform.
-- 2.1 moved platform_surface_render_parameters onto each SpaceLocationPrototype;
-- a planet without it falls back to a generic Nauvis-looking sphere. We deepcopy
-- nauvis's parameters (assigned by Space Age in base-data-updates, so they exist by
-- data-final-fixes) and swap in corrundum's own equirectangular planet maps.

local corrundum = data.raw.planet["corrundum"]
local nauvis = data.raw.planet["nauvis"]

if corrundum and nauvis and nauvis.platform_surface_render_parameters then
  local params = util.table.deepcopy(nauvis.platform_surface_render_parameters)
  local bd = params.platform_backdrop

  local function tex(name)
    return { filename = "__corrundum__/graphics/space/" .. name, width = 2048, height = 1024 }
  end

  bd.rotation_seconds    = -420  -- slow, majestic spin (clouds are baked into the albedo, so they co-rotate)
  bd.planet_axis          = { 18, -3 }  -- tilt toward the southern hemisphere so the blue caldera sits high in view
  bd.planet_surface      = tex("corrundum-planet.png")
  bd.planet_normal       = tex("corrundum-planet-normal.png")
  bd.planet_reflectivity = tex("corrundum-planet-reflectivity.png")
  bd.planet_emission     = tex("corrundum-planet-emission.png")

  -- Clouds are BAKED INTO the albedo (white swirls) rather than using the engine's global_cloud
  -- layer: that layer blends as a tone at `cloudiness` opacity and badly DARKENS a planet with a
  -- sparse (mostly-dark) cloud deck like ours, crushing the lit side. Baking keeps the surface
  -- bright, vivid and fully lit while still showing the reference's white cloud swirls.
  bd.global_cloud        = nil
  bd.global_cloud_normal = nil
  bd.global_cloud_flow   = nil
  bd.cloudiness          = 0

  -- The blue corundum calderas glow on their own, day or night.
  bd.emission_scalar             = 1.5
  bd.emission_scales_with_shadow = false

  -- Faint cool atmosphere rim (no brown cast), slightly softer specular than Nauvis.
  bd.atmosphere_color   = { 0.05, 0.09, 0.10, 0.07 }
  bd.specular_intensity = 0.8

  params.platform_backdrop = bd
  corrundum.platform_surface_render_parameters = params
end
