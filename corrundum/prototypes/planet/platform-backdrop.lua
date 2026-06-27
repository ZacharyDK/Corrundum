--Taken from space-age base-data-updates.lua. Using fulgora as a template.
data.raw.planet["corrundum"].platform_surface_render_parameters = util.table.deepcopy(data.raw.planet["nauvis"].platform_surface_render_parameters)
-- Need to have surface render parameters, otherwise we access a nil value when we try to define a backdrop
data.raw.planet["corrundum"].platform_surface_render_parameters.platform_backdrop =
{
  emission_scales_with_shadow = false,
  --radius = data.raw.planet["nauvis"].platform_surface_render_parameters.platform_backdrop.radius * 0.7,
  radius = 772, -- Vulcaus's radius
  rotation_seconds = data.raw.planet["nauvis"].platform_surface_render_parameters.platform_backdrop.rotation_seconds / 1.8,
  --light_radius = data.raw.planet["nauvis"].platform_surface_render_parameters.platform_backdrop.light_radius * 0.75,
  cloudiness = 0.6,
  surface_vertical_offset = 0.1,
  cloud_vertical_offset = 0.07,
  specular_intensity = 0.7,
  specular_color = {0.95, 0.83, 0.52, 1},
  atmosphere_color = {0.072, 0.073, 0.067, 0.1}, -- vulcaus
  cloud_flow_intensity = 1.5, --
  cloud_panning_rate = 0.1,
  planet_axis = {3.0, 13.0},

  --planet_axis_deviation_amplitude = {10.0, 10.0}, -- Fulgora
  --planet_axis_deviation_seconds = {890.5/1.8, 753.7/1.8}, -- Fulgora
  --position = {-400, 270}, -- Fulgora
  planet_axis_deviation_amplitude = {10.0, 10.0}, -- Vulcanus
  planet_axis_deviation_seconds = {890.5*2/4.66, 753.7*2/4.66},  -- Vulcanus
  position = {-680, 601},  -- Vulcanus

  parallax_strength = {0.95, 0.95},
  light_direction = {-0.42, 0.23, 0.4},
  light_intensity_contrast = 0.3,
  light_radius = 5.9,
  hero_clouds_are_emissive = true,
  hero_clouds =
  {
    {
      sprite_index = 1,
      rotate_with_planet = false,
      positions = {{0.2, 0.5}},
      position_deviation = {-0.05, -0.3},
      rotation_deviation = 100.0,
      starting_frame_offset = 0,
      size = {0.3, 0.3}
    },
    {
      sprite_index = 1,
      rotate_with_planet = false,
      positions = {{0.21, 0.7}},
      position_deviation = {0.05, -0.2},
      rotation_deviation = 1.0,
      starting_frame_offset = 24,
      size = {0.3, 0.3}
    },
    {
      sprite_index = 1,
      rotate_with_planet = false,
      positions = {{0.21, 0.9}},
      position_deviation = {-0.05, -0.4},
      rotation_deviation = 1.0,
      starting_frame_offset = 32,
      size = {0.3, 0.3}
    },
    {
      sprite_index = 1,
      rotate_with_planet = false,
      positions = {{0.21, 0.9}},
      position_deviation = {-0.05, -0.4},
      rotation_deviation = 1.0,
      starting_frame_offset = 64,
      size = {0.3, 0.3}
    }
  },
  hero_cloud_texture_1 = util.sprite_load("__space-age__/graphics/space/planet-lightning",{
    frame_count = 12,
    frame_sequence = {1,2,3,4,5,6,7,8,9,10,11,12,
    12,12,12,12,12,12,12,12,12,12,
    12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,},
    --12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12},
  animation_speed = 0.5
  }),
  planet_surface =
  {
    filename = "__corrundum__/graphics/space/corrundum.png", --Surface image derived from Nauvis
    width = 2048,
    height = 1024
  },
  planet_normal =
  {
    filename = "__space-age__/graphics/space/nauvis-normal.png",
    width = 2048,
    height = 1024
  },
  planet_reflectivity =
  {
    filename = "__space-age__/graphics/space/nauvis-reflectivity.png",
    width = 2048,
    height = 1024
  },
  global_cloud =
  {
    filename = "__corrundum__/graphics/space/corrundum-cloud.png",
    width = 2048,
    height = 1024
  },
  global_cloud_normal =
  {
    filename = "__space-age__/graphics/space/aquilo-cloud-normal.png",
    width = 2048,
    height = 1024
  },
  global_cloud_flow =
  {
    filename = "__space-age__/graphics/space/fulgora-cloud-flow.png",
    width = 2048,
    height = 1024
  }
}