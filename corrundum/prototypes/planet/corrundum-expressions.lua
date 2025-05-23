--Copied from vulcanus

data:extend{
  ---- Constants
  {
    type = "noise-expression",
    name = "corrundum_ore_spacing",
    expression = 96
  },
  {
    type = "noise-expression",
    name = "corrundum_shared_influence",
    expression = 105 * 3
  },
  {
    type = "noise-expression",
    name = "corrundum_biome_contrast",
    expression = 2 -- higher values mean sharper transitions
  },
  {
    type = "noise-expression",
    name = "corrundum_cracks_scale",
    expression = 0.325
  },

  {
    --functions more like a cliffiness multiplier as all the mountain tiles have it offset.
    type = "noise-expression",
    name = "corrundum_mountains_elevation_multiplier",
    expression = 1.5
  },

  ---- HELPERS
  {
    type = "noise-expression",
    name = "corrundum_starting_area_multiplier",
    -- reduced richness for starting resources
    expression = "lerp(1, 0.06, clamp(0.5 + corrundum_starting_circle, 0, 1))"
  },
  {
    type = "noise-expression",
    name = "corrundum_richness_multiplier",
    expression = "6 + distance / 10000"
  },
  {
    type = "noise-expression",
    name = "corrundum_scale_multiplier",
    expression = "slider_rescale(control:corrundum_volcanism:frequency, 3)"
  },
  {
    type = "noise-function",
    name = "corrundum_detail_noise",
    parameters = {"seed1", "scale", "octaves", "magnitude"},
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = seed1 + 12243,\z
                                    octaves = octaves,\z
                                    persistence = 0.6,\z
                                    input_scale = 1 / 50 / scale,\z
                                    output_scale = magnitude}"
  },
  {
    type = "noise-function",
    name = "corrundum_plasma",
    parameters = {"seed", "scale", "scale2", "magnitude1", "magnitude2"},
    expression = "abs(basis_noise{x = x,\z
                                  y = y,\z
                                  seed0 = map_seed,\z
                                  seed1 = 12643,\z
                                  input_scale = 1 / 50 / scale,\z
                                  output_scale = magnitude1}\z
                      - basis_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = 13423 + seed,\z
                                    input_scale = 1 / 50 / scale2,\z
                                    output_scale = magnitude2})"
  },
  {
    type = "noise-function",
    name = "corrundum_threshold",
    parameters = {"value", "threshold"},
    expression = "(value - (1 - threshold)) * (1 / threshold)"
  },
  {
    type = "noise-function",
    name = "corrundum_contrast",
    parameters = {"value", "c"},
    expression = "clamp(value, c, 1) - c"
  },

  ---- ELEVATION
  {
    type = "noise-expression",
    name = "corrundum_elevation",
    --intended_property = "elevation",
    expression = "max(-500, corrundum_elev)"
  },
  ---- TEMPERATURE: Used to place hot vs cold tilesets, e.g. cold - warm - hot cracks.
  {
    type = "noise-expression",
    name = "corrundum_temperature",
    --intended_property = "temperature",
    expression = "100\z
                  + 100 * var('control:temperature:bias')\z
                  - min(corrundum_elev, corrundum_elev / 100)\z
                  - 2 * corrundum_moisture\z
                  - 1 * corrundum_aux\z
                  - 20 * corrundum_petrol_lands_biome\z
                  + 200 * max(0, mountain_volcano_spots - 0.6)"
  },
  ---- AUX (0-1): On corrundum this is Rockiness.
  ---- 0 is flat and arranged as paths through rocks.
  ---- 1 are rocky "islands" for rock clusters, chimneys, etc.
  {
    type = "noise-expression",
    name = "corrundum_aux",
    --intended_property = "aux",
    expression = "clamp(min(abs(multioctave_noise{x = x,\z
                                                  y = y,\z
                                                  seed0 = map_seed,\z
                                                  seed1 = 2,\z
                                                  octaves = 5,\z
                                                  persistence = 0.6,\z
                                                  input_scale = 0.2,\z
                                                  output_scale = 0.6}),\z
                            0.3 - 0.6 * corrundum_flood_paths), 0, 1)"
  },
  
  --Originally from vulcanus, but I don't think this is necessary here.
  ---- MOISTURE (0-1): On corrundum used for vegetation clustering.
  ---- 0 is no vegetation, such as ash bowels in the petrol_lands.
  ---- 1 is vegetation pathches (mainly in petrol_lands).
  ---- As this drives the ash bowls, it also has an impact on small rock & pebble placement.
  {
    type = "noise-expression",
    name = "corrundum_moisture",
    --intended_property = "moisture",
    expression = "clamp(1\z
                        - abs(multioctave_noise{x = x,\z
                                                y = y,\z
                                                seed0 = map_seed,\z
                                                seed1 = 4,\z
                                                octaves = 2,\z
                                                persistence = 0.6,\z
                                                input_scale = 0.025,\z
                                                output_scale = 0.25})\z
                        - abs(multioctave_noise{x = x,\z
                                                y = y,\z
                                                seed0 = map_seed,\z
                                                seed1 = 400,\z
                                                octaves = 3,\z
                                                persistence = 0.62,\z
                                                input_scale = 0.051144353,\z
                                                output_scale = 0.25})\z
                        - 0.2 * corrundum_flood_cracks_a, 0, 1)"
  },

  ---- Starting Area blobs
  {
    type = "noise-expression",
    name = "corrundum_starting_area_radius",
    expression = "0.7 * 0.75"
  },
  {
    type = "noise-expression",
    name = "corrundum_starting_direction",
    expression = "-1 + 2 * (map_seed_small & 1)"
  },
  {
    type = "noise-expression",
    name = "corrundum_petrol_lands_angle",
    expression = "map_seed_normalized * 3600"
  },
  {
    type = "noise-expression",
    name = "corrundum_mountains_angle",
    expression = "corrundum_petrol_lands_angle + 120 * corrundum_starting_direction"
  },
  {
    type = "noise-expression",
    name = "corrundum_basalts_angle",
    expression = "corrundum_petrol_lands_angle + 240 * corrundum_starting_direction"
  },
  {
    type = "noise-expression",
    name = "corrundum_petrol_lands_start",
    -- requires more influence because it is smaller and has no mountain boost
    expression = "4 * starting_spot_at_angle{ angle = corrundum_petrol_lands_angle,\z
                                              distance = 170 * corrundum_starting_area_radius,\z
                                              radius = 350 * corrundum_starting_area_radius,\z
                                              x_distortion = 0.1 * corrundum_starting_area_radius * (corrundum_wobble_x + corrundum_wobble_large_x + corrundum_wobble_huge_x),\z
                                              y_distortion = 0.1 * corrundum_starting_area_radius * (corrundum_wobble_y + corrundum_wobble_large_y + corrundum_wobble_huge_y)}"
  },
  {
    type = "noise-expression",
    name = "corrundum_basalts_start",
    expression = "2 * starting_spot_at_angle{ angle = corrundum_basalts_angle,\z
                                              distance = 250,\z
                                              radius = 550 * corrundum_starting_area_radius,\z
                                              x_distortion = 0.1 * corrundum_starting_area_radius * (corrundum_wobble_x + corrundum_wobble_large_x + corrundum_wobble_huge_x),\z
                                              y_distortion = 0.1 * corrundum_starting_area_radius * (corrundum_wobble_y + corrundum_wobble_large_y + corrundum_wobble_huge_y)}"
  },
  {
    type = "noise-expression",
    name = "corrundum_mountains_start",
    expression = "2 * starting_spot_at_angle{ angle = corrundum_mountains_angle,\z
                                              distance = 250 * corrundum_starting_area_radius,\z
                                              radius = 500 * corrundum_starting_area_radius,\z
                                              x_distortion = 0.05 * corrundum_starting_area_radius * (corrundum_wobble_x + corrundum_wobble_large_x + corrundum_wobble_huge_x),\z
                                              y_distortion = 0.05 * corrundum_starting_area_radius * (corrundum_wobble_y + corrundum_wobble_large_y + corrundum_wobble_huge_y)}"
  },
  {
    type = "noise-expression",
    name = "corrundum_starting_area", -- used for biome blending
    expression = "clamp(max(corrundum_basalts_start, corrundum_mountains_start, corrundum_petrol_lands_start), 0, 1)"
  },
  {
    type = "noise-expression",
    name = "corrundum_starting_circle", -- Used to push random ores away. No not clamp.
    -- 600-650 circle
    expression = "1 + corrundum_starting_area_radius * (300 - distance) / 50"
  },

  ---- BIOME NOISE

  {
    type = "noise-function",
    name = "corrundum_biome_noise",
    parameters = {"seed1", "scale"},
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    persistence = 0.65,\z
                                    seed0 = map_seed,\z
                                    seed1 = seed1,\z
                                    octaves = 5,\z
                                    input_scale = corrundum_scale_multiplier / scale}"
  },
  {
    type = "noise-function",
    name = "corrundum_biome_multiscale",
    parameters = {"seed1", "scale", "bias"},
    expression = "bias + lerp(corrundum_biome_noise(seed1, scale * 0.5),\z
                              corrundum_biome_noise(seed1 + 1000, scale),\z
                              clamp(distance / 10000, 0, 1))"
  },
  {
    type = "noise-expression",
    name = "corrundum_mountains_biome_noise",
    expression = "corrundum_biome_multiscale{seed1 = 342,\z
                                            scale = 60,\z
                                            bias = 0}"
  },
  {
    type = "noise-expression",
    name = "corrundum_petrol_lands_biome_noise",
    expression = "corrundum_biome_multiscale{seed1 = 12416,\z
                                            scale = 40,\z
                                            bias = 0}"
  },
  {
    type = "noise-expression",
    name = "corrundum_basalts_biome_noise",
    expression = "corrundum_biome_multiscale{seed1 = 42416,\z
                                            scale = 80,\z
                                            bias = 0}"
  },


  {
    type = "noise-expression",
    name = "corrundum_petrol_lands_raw",
    expression = "lerp(corrundum_petrol_lands_biome_noise, starting_weights, clamp(2 * corrundum_starting_area, 0, 1))",
    local_expressions =
    {
      starting_weights = "-corrundum_mountains_start + corrundum_petrol_lands_start - corrundum_basalts_start"
    }
  },
  {
    type = "noise-expression",
    name = "corrundum_basalts_raw",
    expression = "lerp(corrundum_basalts_biome_noise, starting_weights, clamp(2 * corrundum_starting_area, 0, 1))",
    local_expressions =
    {
      starting_weights = "-corrundum_mountains_start - corrundum_petrol_lands_start + corrundum_basalts_start"
    }
  },

  {
    type = "noise-expression",
    name = "corrundum_mountains_raw_pre_volcano",
    expression = "lerp(corrundum_mountains_biome_noise, starting_weights, clamp(2 * corrundum_starting_area, 0, 1))",
    local_expressions =
    {
      starting_weights = "corrundum_mountains_start - corrundum_petrol_lands_start - corrundum_basalts_start"
    }
  },
  {
    type = "noise-expression",
    name = "corrundum_mountains_biome_full_pre_volcano",
    expression = "corrundum_mountains_raw_pre_volcano - max(corrundum_petrol_lands_raw, corrundum_basalts_raw)"
  },

  {
    type = "noise-expression",
    name = "mountain_volcano_spots",
    expression = "max(corrundum_starting_volcano_spot, raw_spots - starting_protector)",
    local_expressions =
    {
      starting_protector = "clamp(starting_spot_at_angle{ angle = corrundum_mountains_angle + 180 * corrundum_starting_direction,\z
                                                          distance = (400 * corrundum_starting_area_radius) / 2,\z
                                                          radius = 800 * corrundum_starting_area_radius,\z
                                                          x_distortion = corrundum_wobble_x/2 + corrundum_wobble_large_x/12 + corrundum_wobble_huge_x/80,\z
                                                          y_distortion = corrundum_wobble_y/2 + corrundum_wobble_large_y/12 + corrundum_wobble_huge_y/80}, 0, 1)",
      raw_spots = "spot_noise{x = x + corrundum_wobble_x/2 + corrundum_wobble_large_x/12 + corrundum_wobble_huge_x/80,\z
                              y = y + corrundum_wobble_y/2 + corrundum_wobble_large_y/12 + corrundum_wobble_huge_y/80,\z
                              seed0 = map_seed,\z
                              seed1 = 1,\z
                              candidate_spot_count = 1,\z
                              suggested_minimum_candidate_point_spacing = volcano_spot_spacing,\z
                              skip_span = 1,\z
                              skip_offset = 0,\z
                              region_size = 256,\z
                              density_expression = volcano_area / volcanism_sq,\z
                              spot_quantity_expression = volcano_spot_radius * volcano_spot_radius,\z
                              spot_radius_expression = volcano_spot_radius,\z
                              hard_region_target_quantity = 0,\z
                              spot_favorability_expression = volcano_area,\z
                              basement_value = 0,\z
                              maximum_spot_basement_radius = volcano_spot_radius}",
      volcano_area = "lerp(corrundum_mountains_biome_full_pre_volcano, 0, corrundum_starting_area)",
      volcano_spot_radius = "200 * volcanism",
      volcano_spot_spacing = "1500 * volcanism",
      volcanism = "0.3 + 0.7 * slider_rescale(control:corrundum_volcanism:size, 3) / slider_rescale(corrundum_scale_multiplier, 3)",
      volcanism_sq = "volcanism * volcanism"
    }
  },
  {
    type = "noise-expression",
    name = "corrundum_starting_volcano_spot",
    expression = "clamp(starting_spot_at_angle{ angle = corrundum_mountains_angle,\z
                                                distance = 400 * corrundum_starting_area_radius,\z
                                                radius = 200,\z
                                                x_distortion = corrundum_wobble_x/2 + corrundum_wobble_large_x/12 + corrundum_wobble_huge_x/80,\z
                                                y_distortion = corrundum_wobble_y/2 + corrundum_wobble_large_y/12 + corrundum_wobble_huge_y/80}, 0, 1)"
  },

  {
    type = "noise-expression",
    name = "corrundum_mountains_raw_volcano",
    -- moderate influence for the outer 1/3 of the volcano, ramp to high influence for the middle third, and maxed for the innter third
    expression = "0.5 * corrundum_mountains_raw_pre_volcano + max(2 * mountain_volcano_spots, 10 * clamp((mountain_volcano_spots - 0.33) * 3, 0, 1))"
  },

  -- full range biomes with no clamping, good for away-from-edge targeting.
  {
    type = "noise-expression",
    name = "corrundum_mountains_biome_full",
    expression = "corrundum_mountains_raw_volcano - max(corrundum_petrol_lands_raw, corrundum_basalts_raw)"
  },
  {
    type = "noise-expression",
    name = "corrundum_petrol_lands_biome_full",
    expression = "corrundum_petrol_lands_raw - max(corrundum_mountains_raw_volcano, corrundum_basalts_raw)"
  },
  {
    type = "noise-expression",
    name = "corrundum_basalts_biome_full",
    expression = "corrundum_basalts_raw - max(corrundum_mountains_raw_volcano, corrundum_petrol_lands_raw)"
  },

  -- clamped 0-1 biomes
  {
    type = "noise-expression",
    name = "corrundum_mountains_biome",
    expression = "clamp(corrundum_mountains_biome_full * corrundum_biome_contrast, 0, 1)"
  },
  {
    type = "noise-expression",
    name = "corrundum_petrol_lands_biome",
    expression = "clamp(corrundum_petrol_lands_biome_full * corrundum_biome_contrast, 0, 1)"
  },
  {
    type = "noise-expression",
    name = "corrundum_basalts_biome",
    expression = "clamp(corrundum_basalts_biome_full * corrundum_biome_contrast, 0, 1)"
  },


  {
    type = "noise-expression",
    name = "corrundum_resource_penalty",
    expression = "random_penalty_inverse(2.5, 1)"
  },
  {
    type = "noise-expression",
    name = "corrundum_wobble_x",
    expression = "corrundum_detail_noise{seed1 = 10, scale = 1/8, octaves = 2, magnitude = 4}"
  },
  {
    type = "noise-expression",
    name = "corrundum_wobble_y",
    expression = "corrundum_detail_noise{seed1 = 1010, scale = 1/8, octaves = 2, magnitude = 4}"
  },
  {
    type = "noise-expression",
    name = "corrundum_wobble_large_x",
    expression = "corrundum_detail_noise{seed1 = 20, scale = 1/2, octaves = 2, magnitude = 50}"
  },
  {
    type = "noise-expression",
    name = "corrundum_wobble_large_y",
    expression = "corrundum_detail_noise{seed1 = 1020, scale = 1/2, octaves = 2, magnitude = 50}"
  },
  {
    type = "noise-expression",
    name = "corrundum_wobble_huge_x",
    expression = "corrundum_detail_noise{seed1 = 30, scale = 2, octaves = 2, magnitude = 800}"
  },
  {
    type = "noise-expression",
    name = "corrundum_wobble_huge_y",
    expression = "corrundum_detail_noise{seed1 = 1030, scale = 2, octaves = 2, magnitude = 800}"
  },

  {
    type = "noise-expression",
    name = "mountain_basis_noise",
    expression = "basis_noise{x = x,\z
                              y = y,\z
                              seed0 = map_seed,\z
                              seed1 = 13423,\z
                              input_scale = 1 / 500,\z
                              output_scale = 250}"
  },
  {
    type = "noise-expression",
    name = "mountain_plasma",
    expression = "corrundum_plasma(102, 2.5, 10, 125, 625)"
  },
  {
    type = "noise-expression",
    name = "mountain_elevation",
    expression = "lerp(max(clamp(mountain_plasma, -100, 10000), mountain_basis_noise),\z
                       mountain_plasma,\z
                       clamp(0.7 * mountain_basis_noise, 0, 1))\z
                  * (1 - clamp(corrundum_plasma(13, 2.5, 10, 0.15, 0.75), 0, 1))",
  },
  {
    type = "noise-expression",
    name = "mountain_lava_spots",
    expression = "clamp(corrundum_threshold(mountain_volcano_spots * 1.95 - 0.95,\z
                                           0.4 * clamp(corrundum_threshold(corrundum_mountains_biome, 0.5), 0, 1))\z
                                           * corrundum_threshold(clamp(corrundum_plasma(17453, 0.2, 0.4, 10, 20) / 20, 0, 1), 1.8),\z
                        0, 1)"
  },
  {
    type = "noise-function",
    name = "volcano_inverted_peak",
    parameters = {"spot", "inversion_point"},
    expression = "(inversion_point - abs(spot - inversion_point)) / inversion_point"
  },
  {
    type = "noise-expression",
    name = "corrundum_mountains_func",
    expression = "lerp(mountain_elevation, 700 * volcano_inverted_peak(mountain_volcano_spots, 0.65), clamp(mountain_volcano_spots * 3, 0, 1))\z
     + 200 * (aux - 0.5) * (mountain_volcano_spots + 0.5)"
  },
  {
    type = "noise-expression",
    name = "corrundum_petrol_lands_func",
    expression = "300 + 0.001 * min(basis_noise{x = x,\z
                                                y = y,\z
                                                seed0 = map_seed,\z
                                                seed1 = 12643,\z
                                                input_scale = corrundum_scale_multiplier / 50 / scale,\z
                                                output_scale = 150},\z
                                    basis_noise{x = x,\z
                                                y = y,\z
                                                seed0 = map_seed,\z
                                                seed1 = 12643,\z
                                                input_scale = corrundum_scale_multiplier / 50 / scale,\z
                                                output_scale = 150})",
    local_expressions = {scale = 3}
  },
  {
    type = "noise-expression",
    name = "corrundum_hairline_cracks",
    expression = "corrundum_plasma(15223, 0.3 * corrundum_cracks_scale, 0.6 * corrundum_cracks_scale, 0.6, 1)"
  },
  {
    type = "noise-expression",
    name = "corrundum_flood_cracks_a",
    expression = "lerp(min(corrundum_plasma(7543, 2.5 * corrundum_cracks_scale, 4 * corrundum_cracks_scale, 0.5, 1),\z
                           corrundum_plasma(7443, 1.5 * corrundum_cracks_scale, 3.5 * corrundum_cracks_scale, 0.5, 1)),\z
                       1,\z
                       clamp(corrundum_detail_noise(241, 2 * corrundum_cracks_scale, 2, 0.25), 0, 1))"
  },
  {
    type = "noise-expression",
    name = "corrundum_flood_cracks_b",
    expression = "lerp(1,\z
                       min(corrundum_plasma(12223, 2 * corrundum_cracks_scale, 3 * corrundum_cracks_scale, 0.5, 1),\z
                           corrundum_plasma(152, 1 * corrundum_cracks_scale, 1.5 * corrundum_cracks_scale, 0.25, 0.5)) - 0.5,\z
                       clamp(0.2 + corrundum_detail_noise(821, 6 * corrundum_cracks_scale, 2, 0.5), 0, 1))"
  },
  {
    type = "noise-expression",
    name = "corrundum_flood_paths",
    -- make paths through the lava cracks, get walkable areas above 0, the first value is the path height
    expression = "0.4\z
                  - corrundum_plasma(1543, 1.5 * corrundum_cracks_scale, 3 * corrundum_cracks_scale, 0.5, 1)\z
                  + min(0, corrundum_detail_noise(121, corrundum_cracks_scale * 4, 2, 0.5))",
  },
  {
    type = "noise-expression",
    name = "corrundum_flood_basalts_func",
    -- add hairline cracks to break up edges, crop hearilyie cracks peaks so it is more of a plates + cracks pattern
    -- lava level should be 0 and below, solid ground above 0
    expression = "min(max(corrundum_flood_cracks_a - 0.125, corrundum_flood_paths), corrundum_flood_cracks_b) + 0.3 * min(0.5, corrundum_hairline_cracks)"
  },

  {
    type = "noise-expression",
    name = "corrundum_elevation_offset",
    expression = "0"
  },
  {
    type = "noise-function",
    name = "corrundum_biome_blend",
    parameters = {"fade", "noise", "offset"},
    expression = "fade * (noise - offset)"
  },
  {
    type = "noise-expression",
    name = "corrundum_elev",
    expression = "corrundum_elevation_offset\z
                  + lerp(lerp(120 * corrundum_basalt_lakes_multisample,\z
                              20 + corrundum_mountains_func * corrundum_mountains_elevation_multiplier,\z
                              corrundum_mountains_biome),\z
                         corrundum_petrol_lands_func,\z
                         corrundum_petrol_lands_biome)",
    local_expressions =
    {
      corrundum_basalt_lakes_multisample = "min(multisample(corrundum_basalt_lakes, 0, 0),\z
                                               multisample(corrundum_basalt_lakes, 1, 0),\z
                                               multisample(corrundum_basalt_lakes, 0, 1),\z
                                               multisample(corrundum_basalt_lakes, 1, 1))"
    }
  },
  {
    type = "noise-expression",
    name = "corrundum_basalt_lakes",
    expression = "min(1,\z
                      -0.2 + corrundum_flood_basalts_func\z
                      - 0.35 * clamp(corrundum_contrast(corrundum_detail_noise(837, 1/40, 4, 1.25), 0.95)\z
                                     * corrundum_contrast(corrundum_detail_noise(234, 1/50, 4, 1), 0.95)\z
                                     * corrundum_detail_noise(643, 1/70, 4, 0.7),\z
                                     0, 3))"
  },

  ---- RESOURCES
  -- metals in lowlands lava rivers
  -- sulfuric acid, and calcite on highlands mountains.
  -- sulfur and lichen/trees on petrol_lands_biome deserts.

  {
    type = "noise-expression",
    name = "corrundum_resource_wobble_x",
    expression = "corrundum_wobble_x + 0.25 * corrundum_wobble_large_x"
  },
  {
    type = "noise-expression",
    name = "corrundum_resource_wobble_y",
    expression = "corrundum_wobble_y + 0.25 * corrundum_wobble_large_y"
  },
  {
    type = "noise-expression",
    name = "corrundum_starting_platinum", -- don't use the slider for radius becuase it can make platinum in the safe area
    expression = "starting_spot_at_angle{ angle = corrundum_basalts_angle - 10 * corrundum_starting_direction,\z
                                          distance = 450 * corrundum_starting_area_radius,\z
                                          radius = 30 / 1.5,\z
                                          x_distortion = 0.5 * corrundum_resource_wobble_x,\z
                                          y_distortion = 0.5 * corrundum_resource_wobble_y}"
  },
  {
    type = "noise-expression",
    name = "corrundum_starting_sulfur_ore",
    expression = "starting_spot_at_angle{ angle = corrundum_petrol_lands_angle + 15 * corrundum_starting_direction,\z
                                          distance = 180 * corrundum_starting_area_radius,\z
                                          radius = 30 * corrundum_sulfur_ore_size,\z
                                          x_distortion = 0.5 * corrundum_resource_wobble_x,\z
                                          y_distortion = 0.5 * corrundum_resource_wobble_y}"
  },
  {
    type = "noise-expression",
    name = "corrundum_starting_calcite",
    expression = "starting_spot_at_angle{ angle = corrundum_mountains_angle - 20 * corrundum_starting_direction,\z
                                          distance = 350 * corrundum_starting_area_radius,\z
                                          radius = 35 / 1.5 * corrundum_calcite_size,\z
                                          x_distortion = 0.5 * corrundum_resource_wobble_x,\z
                                          y_distortion = 0.5 * corrundum_resource_wobble_y}"
  },
 
  {
    type = "noise-function",
    name = "corrundum_spot_noise",
    parameters = {"seed", "count", "spacing", "span", "offset", "region_size", "density", "quantity", "radius", "favorability"},
    expression = "spot_noise{x = x + corrundum_resource_wobble_x,\z
                             y = y + corrundum_resource_wobble_y,\z
                             seed0 = map_seed,\z
                             seed1 = seed,\z
                             candidate_spot_count = count,\z
                             suggested_minimum_candidate_point_spacing = 128,\z
                             skip_span = span,\z
                             skip_offset = offset,\z
                             region_size = region_size,\z
                             density_expression = density,\z
                             spot_quantity_expression = quantity,\z
                             spot_radius_expression = radius,\z
                             hard_region_target_quantity = 0,\z
                             spot_favorability_expression = favorability,\z
                             basement_value = -1,\z
                             maximum_spot_basement_radius = 128}"
  },
  {
    type = "noise-expression",
    name = "corrundum_basalts_resource_favorability",
    expression = "clamp(((corrundum_basalts_biome_full * (corrundum_starting_area < 0.01)) - buffer) * contrast, 0, 1)",
    local_expressions =
    {
      buffer = 0.3, -- push ores away from biome edges.
      contrast = 2
    }
  },
  {
    type = "noise-expression",
    name = "corrundum_mountains_resource_favorability",
    expression = "clamp(main_region - (mountain_volcano_spots > 0.78), 0, 1)",
    local_expressions =
    {
      buffer = 0.4, -- push ores away from biome edges.
      contrast = 2,
      main_region = "clamp(((corrundum_mountains_biome_full * (corrundum_starting_area < 0.01)) - buffer) * contrast, 0, 1)"
    }
  },
  {
    type = "noise-expression",
    name = "corrundum_mountains_sulfur_favorability",
    expression = "clamp(((corrundum_mountains_biome_full * (corrundum_starting_area < 0.01)) - buffer) * contrast, 0, 1)",
    local_expressions =
    {
      buffer = 0.3, -- push ores away from biome edges.
      contrast = 2
    }
  },
  {
    type = "noise-expression",
    name = "corrundum_petrol_lands_resource_favorability",
    expression = "clamp(((corrundum_petrol_lands_biome_full * (corrundum_starting_area < 0.01)) - buffer) * contrast, 0, 1)",
    local_expressions =
    {
      buffer = 0.3, -- push ores away from biome edges.
      contrast = 2
    }
  },
  {
    type = "noise-function",
    name = "corrundum_place_metal_spots",
    parameters = {"seed", "count", "offset", "size", "freq", "favor_biome"},
    expression = "min(clamp(-1 + 4 * favor_biome, -1, 1), metal_spot_noise - corrundum_hairline_cracks / 30000)",
    local_expressions =
    {
      metal_spot_noise = "corrundum_spot_noise{seed = seed,\z
                                              count = count,\z
                                              spacing = corrundum_ore_spacing,\z
                                              span = 3,\z
                                              offset = offset,\z
                                              region_size = 500 + 500 / freq,\z
                                              density = favor_biome * 4,\z
                                              quantity = size * size,\z
                                              radius = size,\z
                                              favorability = favor_biome > 0.9}"
    }
  },
  {
    type = "noise-function",
    name = "corrundum_place_sulfur_spots", --This was used to control sulfur geysers. 
    parameters = {"seed", "count", "offset", "size", "freq", "favor_biome"},
    expression = "min(2 * favor_biome - 1, corrundum_spot_noise{seed = seed,\z
                                                               count = count,\z
                                                               spacing = corrundum_ore_spacing,\z
                                                               span = 3,\z
                                                               offset = offset,\z
                                                               region_size = 450 + 450 / freq,\z
                                                               density = favor_biome * 4,\z
                                                               quantity = size * size,\z
                                                               radius = size,\z
                                                               favorability = favor_biome > 0.9})"
  },
  {
    type = "noise-function",
    name = "corrundum_place_non_metal_spots",
    parameters = {"seed", "count", "offset", "size", "freq", "favor_biome"},
    expression = "min(2 * favor_biome - 1, corrundum_spot_noise{seed = seed,\z
                                                               count = count,\z
                                                               spacing = corrundum_ore_spacing,\z
                                                               span = 3,\z
                                                               offset = offset,\z
                                                               region_size = 400 + 400 / freq,\z
                                                               density = favor_biome * 4,\z
                                                               quantity = size * size,\z
                                                               radius = size,\z
                                                               favorability = favor_biome > 0.9})"
  },

  {
    type = "noise-expression",
    name = "corrundum_platinum_ore_size",
    expression = "slider_rescale(control:platinum_ore:size, 2)"
  },
  {
    type = "noise-expression",
    name = "corrundum_chalcopyrite_ore_size",
    expression = "slider_rescale(control:chalcopyrite_ore:size, 2)"
  },
  {
    type = "noise-expression",
    name = "corrundum_platinum_ore_region",
    -- -1 to 1: needs a positive region for resources & decoratives plus a subzero baseline and skirt for surrounding decoratives.
    expression = "max(corrundum_starting_platinum,\z
                      min(1 - corrundum_starting_circle,\z
                          corrundum_place_metal_spots(789, 15, 2,\z
                                                     corrundum_platinum_ore_size * min(1.2, corrundum_ore_dist) * 25,\z
                                                     control:platinum_ore:frequency,\z
                                                     corrundum_basalts_resource_favorability)))"
  },
  {
    type = "noise-expression",
    name = "corrundum_chalcopyrite_ore_region",
    -- -1 to 1: needs a positive region for resources & decoratives plus a subzero baseline and skirt for surrounding decoratives.
    expression = "max(corrundum_starting_platinum,\z
                      min(1 - corrundum_starting_circle,\z
                          corrundum_place_metal_spots(1000, 20, 3,\z
                                                     corrundum_chalcopyrite_ore_size * min(1.2, corrundum_ore_dist) * 25,\z
                                                     control:chalcopyrite_ore:frequency,\z
                                                     corrundum_basalts_resource_favorability)))"
  },
  {
    type = "noise-expression",
    name = "corrundum_platinum_ore_probability",
    expression = "(control:platinum_ore:size > 0) * (1000 * ((1 + corrundum_platinum_ore_region) * random_penalty_between(0.9, 1, 1) - 1))"
  },
  {
    type = "noise-expression",
    name = "corrundum_chalcopyrite_ore_probability",
    expression = "(control:chalcopyrite_ore:size > 0) * (1200 * ((1 + corrundum_chalcopyrite_ore_region) * random_penalty_between(0.9, 1, 1) - 1))"
  },
  {
    type = "noise-expression",
    name = "corrundum_platinum_ore_richness",
    expression = "corrundum_platinum_ore_region * random_penalty_between(0.9, 1, 1)\z
                  * 10000 * corrundum_starting_area_multiplier\z
                  * control:platinum_ore:richness / corrundum_platinum_ore_size"
  },
  {
    type = "noise-expression",
    name = "corrundum_chalcopyrite_ore_richness",
    expression = "corrundum_chalcopyrite_ore_region * random_penalty_between(0.9, 1, 1)\z
                  * 15000 * corrundum_starting_area_multiplier\z
                  * control:chalcopyrite_ore:richness / corrundum_chalcopyrite_ore_size"
  },

  {
    type = "noise-expression",
    name = "corrundum_sulfur_ore_size",
    expression = "slider_rescale(control:sulfur_ore:size, 2)"
  },
  {
    type = "noise-expression",
    name = "corrundum_sulfur_ore_region",
    -- -1 to 1: needs a positive region for resources & decoratives plus a subzero baseline and skirt for surrounding decoratives.
    expression = "max(corrundum_starting_sulfur_ore,\z
                      min(1 - corrundum_starting_circle,\z
                          corrundum_place_non_metal_spots(782349, 12, 1,\z
                                                         corrundum_sulfur_ore_size * min(1.2, corrundum_ore_dist) * 25,\z
                                                         control:sulfur_ore:frequency,\z
                                                         corrundum_petrol_lands_resource_favorability)))"
  },
  {
    type = "noise-expression",
    name = "corrundum_sulfur_ore_probability",
    expression = "(control:sulfur_ore:size > 0) * (1000 * ((1 + corrundum_sulfur_ore_region) * random_penalty_between(0.9, 1, 1) - 1))"
  },
  {
    type = "noise-expression",
    name = "corrundum_sulfur_ore_richness",
    expression = "corrundum_sulfur_ore_region * random_penalty_between(0.9, 1, 1)\z
                  * 18000 * corrundum_starting_area_multiplier\z
                  * control:sulfur_ore:richness / corrundum_sulfur_ore_size"
  },

  {
    type = "noise-expression",
    name = "corrundum_calcite_size",
    expression = "slider_rescale(control:calcite:size, 2)"
  },
  {
    type = "noise-expression",
    name = "corrundum_calcite_region",
    -- -1 to 1: needs a positive region for resources & decoratives plus a subzero baseline and skirt for surrounding decoratives.
    expression = "max(corrundum_starting_calcite,\z
                      min(1 - corrundum_starting_circle,\z
                          corrundum_place_non_metal_spots(749, 12, 1,\z
                                                         corrundum_calcite_size * min(1.2, corrundum_ore_dist) * 25,\z
                                                         control:calcite:frequency,\z
                                                         corrundum_mountains_resource_favorability)))"
  },
  {
    type = "noise-expression",
    name = "corrundum_calcite_probability",
    expression = "(control:calcite:size > 0) * (1000 * ((1 + corrundum_calcite_region) * random_penalty_between(0.9, 1, 1) - 1))"
  },
  {
    type = "noise-expression",
    name = "corrundum_calcite_richness",
    expression = "corrundum_calcite_region * random_penalty_between(0.9, 1, 1)\z
                  * 24000 * corrundum_starting_area_multiplier\z
                  * control:calcite:richness / corrundum_calcite_size"
  },


  {
    type = "noise-expression",
    name = "corrundum_ore_dist",
    expression = "max(1, distance / 4000)"
  },

  -- DECORATIVES - Inherited from Vulcanus. TODO REFINE.
  {
    type = "noise-expression",
    name = "corrundum_decorative_knockout", -- small wavelength noise (5 tiles-ish) to make decoratives patchy
    expression = "multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 1300000, octaves = 2, input_scale = 1/3}"
  },

  {
    type = "noise-expression",
    name = "corrundum_rock_noise",
    expression = "multioctave_noise{x = x,\z
                                    y = y,\z
                                    seed0 = map_seed,\z
                                    seed1 = 137,\z
                                    octaves = 4,\z
                                    persistence = 0.7,\z
                                    input_scale = 0.1,\z
                                    output_scale = 0.4}"
    -- 0.1 / slider_rescale(var('control:rocks:frequency'), 2),\z
  },

--[[
  {
    type = "noise-expression",
    name = "corrundum_tree",
    expression = "min(10 * (corrundum_petrol_lands_biome - 0.9),\z
                      -1.5 + 1.5 * moisture + 0.5 * (moisture > 0.9) - 0.5 * aux + 0.5 * corrundum_decorative_knockout)"
  }
--]]
}

