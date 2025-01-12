local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")
local tile_graphics = require("__base__/prototypes/tile/tile-graphics")
local lava_to_out_of_map_transition = space_age_tiles_util.lava_to_out_of_map_transition
space_age_tiles_util = space_age_tiles_util or {}
local tile_trigger_effects = require("__base__.prototypes.tile.tile-trigger-effects")
local tile_sounds = require("__space-age__/prototypes/tile/tile-sounds")
-- copied from gleba
local tile_pollution = require("__space-age__/prototypes/tile/tile-pollution-values")
local tile_graphics = require("__base__/prototypes/tile/tile-graphics")
local tile_spritesheet_layout = tile_graphics.tile_spritesheet_layout
local lake_ambience =
{
  {
    sound =
    {
      variations = sound_variations("__base__/sound/world/water/waterlap", 10, 0.4),
      advanced_volume_control =
      {
        fades = {fade_in = {curve_type = "cosine", from = {control = 0.5, volume_percentage = 0.0}, to = {1.5, 100.0}}}
      }
    },
    radius = 7.5,
    min_entity_count = 10,
    max_entity_count = 30,
    entity_to_sound_ratio = 0.1,
    average_pause_seconds = 8
  },
  {
    sound =
      {
        variations = sound_variations("__space-age__/sound/world/tiles/rain-on-water", 10, 0.2),
        advanced_volume_control =
        {
          fades = {fade_in = {curve_type = "cosine", from = {control = 0.5, volume_percentage = 0.0}, to = {1.5, 100.0}}},
        }
      },
      min_entity_count = 10,
      max_entity_count = 25,
      entity_to_sound_ratio = 0.1,
      average_pause_seconds = 5,
  }
}

local oil_driving_sound =
{
  sound =
  {
    filename = "__base__/sound/driving/vehicle-surface-oil.ogg", volume = 0.6,
    advanced_volume_control = {fades = {fade_in = {curve_type = "cosine", from = {control = 0.5, volume_percentage = 0.0}, to = {1.5, 100.0 }}}}
  },
  fade_ticks = 6
}

--Copied from fulgora sprite sheet
local fulgora_rock_sand_transitions =
{
  {
    to_tiles = water_tile_type_names,
    transition_group = water_transition_group_id,

    background_layer_group = "water",
    background_layer_offset = -5,
    masked_background_layer_offset = 1,
    offset_background_layer_by_tile_layer = false,

    spritesheet = "__space-age__/graphics/terrain/water-transitions/fulgora-rock-slab-transition.png",
    layout = tile_spritesheet_layout.transition_16_16_16_4_8_short,
    background_enabled = false,
    effect_map_layout =
    {
      spritesheet = "__space-age__/graphics/terrain/effect-maps/water-fulgora-sand-mask.png",
      --tile_height = 2,
      inner_corner_tile_height = 2,
      outer_corner_tile_height = 2,
      side_tile_height = 2,
      u_transition_tile_height = 2,
      o_transition_count = 1
    },
    background_mask_layout = tile_spritesheet_layout.simple_white_mask
  },
  ground_to_out_of_map_transition
}
local fulgora_oil_sand_transitions =
{
  {
    to_tiles = water_tile_type_names,
    transition_group = water_transition_group_id,

    background_layer_group = "water",
    background_layer_offset = -5,
    masked_background_layer_offset = 1,
    offset_background_layer_by_tile_layer = false,
    spritesheet = "__space-age__/graphics/terrain/water-transitions/fulgora-oil-sand-transition.png",
    layout = tile_spritesheet_layout.transition_16_16_16_4_8_short,
    background_enabled = false,
    effect_map_layout =
    {
      spritesheet = "__space-age__/graphics/terrain/effect-maps/water-fulgora-sand-mask.png",
      --tile_height = 2,
      inner_corner_tile_height = 2,
      outer_corner_tile_height = 2,
      side_tile_height = 2,
      u_transition_tile_height = 2,
      o_transition_count = 1
    },
    background_mask_layout = tile_spritesheet_layout.simple_white_mask
  },
  ground_to_out_of_map_transition
}
local fulgora_sand_transitions_between_transitions =
{
  {
    transition_group1 = default_transition_group_id,
    transition_group2 = water_transition_group_id,

    spritesheet = "__space-age__/graphics/terrain/water-transitions/fulgora-sand-transition.png",
    layout = tile_spritesheet_layout.transition_3_3_3_1_0_only_u_tall,
    background_enabled = false,
    effect_map_layout =
    {
      spritesheet = "__space-age__/graphics/terrain/effect-maps/water-fulgora-sand-to-land-mask.png",
      inner_corner_tile_height = 2,
      outer_corner_tile_height = 2,
      side_tile_height = 2,
      o_transition_count = 0
    },
    water_patch = patch_for_inner_corner_of_transition_between_transition,
  },
  {
    transition_group1 = default_transition_group_id,
    transition_group2 = out_of_map_transition_group_id,

    background_layer_offset = 1,
    background_layer_group = "zero",
    offset_background_layer_by_tile_layer = true,

    spritesheet = "__space-age__/graphics/terrain/out-of-map-transition/fulgora-sand-out-of-map-transition.png",
    layout = tile_spritesheet_layout.transition_3_3_3_1_0,
    overlay_enabled = false
  },
  {
    transition_group1 = water_transition_group_id,
    transition_group2 = out_of_map_transition_group_id,

    background_layer_group = "water",
    background_layer_offset = -5,
    masked_background_layer_offset = 1,
    offset_background_layer_by_tile_layer = false,

    spritesheet = "__space-age__/graphics/terrain/out-of-map-transition/fulgora-sand-shore-out-of-map-transition.png",
    layout = tile_spritesheet_layout.transition_3_3_3_1_0,
    effect_map_layout =
    {
      spritesheet = "__space-age__/graphics/terrain/effect-maps/water-fulgora-sand-to-out-of-map-mask.png",
      o_transition_count = 0
    },
    background_mask_layout = tile_spritesheet_layout.simple_white_mask,
    water_patch = patch_for_inner_corner_of_transition_between_transition
  }
}



local function transition_masks()
  return {
    mask_spritesheet = "__base__/graphics/terrain/masks/transition-1.png",
    mask_layout =
    {
      scale = 0.5,
      inner_corner =
      {
        count = 8,
      },
      outer_corner =
      {
        count = 8,
        x = 64*9
      },
      side =
      {
        count = 8,
        x = 64*9*2
      },
      u_transition =
      {
        count = 1,
        x = 64*9*3
      },
      o_transition =
      {
        count = 1,
        x = 64*9*4
      }
    }
  }
end

--TODO, figure out the nuances of vulcanus tiles noise expression. water_base(-2,200) is working fine for lakes.
data:extend{

  {
    type = "noise-expression",
    name = "petrol_lands_range",
    expression = "2 * (corrundum_petrol_lands_biome - 0.5)\z
                  - 1.5 * (aux - 0.25)\z
                  - 1.5 * (moisture - 0.6)"
  }

}


data:extend(
  {
    {
        type = "tile",
        name = "petroleum-tile",
        order = "b[corrundum]-a[petroleum]",
        --subgroup = "corrundum-tiles",
        collision_mask = tile_collision_masks.water(), --tile_collision_masks.oil_ocean_deep(), --
        autoplace = {probability_expression = "water_base(-2, 200)"},
        lowland_fog = true,
        particle_tints = tile_graphics.fulgora_oil_ocean_particle_tints,
        layer = 1,
        layer_group = "water-overlay",
        --sprite_usage_surface = "corrundum", -- was gleba in tenebris. Not sure why
        variants =
        {
          main =
          {
            {
              picture = "__corrundum__/graphics/tile/petrol-1.png",
              count = 1,
              scale = 0.5,
              size = 1
            },
            {
              picture = "__corrundum__/graphics/tile/petrol-2.png",
              count = 1,
              scale = 0.5,
              size = 2
            },
            {
              picture = "__corrundum__/graphics/tile/petrol-4.png",
              count = 1,
              scale = 0.5,
              size = 4
            },

          },
          empty_transitions=true,
        },
        transitions = {lava_to_out_of_map_transition},
        transitions_between_transitions = data.raw.tile["water"].transitions_between_transitions,
        walking_sound = sound_variations("__base__/sound/walking/resources/oil", 7, 1, volume_multiplier("main-menu", 1.5)),
        landing_steps_sound = sound_variations("__base__/sound/walking/resources/oil", 7, 1, volume_multiplier("main-menu", 2.9)),
        driving_sound = oil_driving_sound,
        map_color = {90,80,22},
        walking_speed_modifier = 0.8,
        vehicle_friction_modifier = 8.0,
        trigger_effect = tile_trigger_effects.sand_trigger_effect(),
        default_cover_tile = "landfill",
        fluid = "petroleum-gas",
        ambient_sounds = lake_ambience
    }
  },
  {
    name = "corrundum-dunes",
    type = "tile",
    order = "b[natural]-b[dunes]",
    subgroup = "corrundum-tiles",
    collision_mask = tile_collision_masks.ground(),
    autoplace = {
      probability_expression = 1 --"1 + fulgora_dunes"
    },
    layer = 7,
    map_color={36, 20, 16},
    vehicle_friction_modifier = 4,
    --absorptions_per_second = tile_pollution.corrundum,
    sprite_usage_surface = "corrundum",
    variants =
    {
      transition = transition_masks(),
      material_background =
      {
        picture = "__corrundum__/graphics/terrain/corrundum-dunes.png",
        line_length = 4,
        count = 16,
        scale = 0.5
      },
      material_texture_width_in_tiles = 10,
      material_texture_height_in_tiles = 7
    },
    transitions = fulgora_rock_sand_transitions,
    transitions_between_transitions = fulgora_sand_transitions_between_transitions,
    walking_sound = sound_variations("__base__/sound/walking/sand", 9, 0.8, volume_multiplier("main-menu", 2.9)),
    landing_steps_sound = tile_sounds.landing.sand,
    driving_sound = sand_driving_sound,
    ambient_sounds = sand_ambient_sound,
    scorch_mark_color = {r = 0.3, g = 0.3, b = 0.3, a = 1.000},
    trigger_effect = tile_trigger_effects.sand_trigger_effect()
  },
  {
    name = "corrundum-sand",
    type = "tile",
    order = "b[natural]-c[sand]",
    subgroup = "corrundum-tiles",
    collision_mask = tile_collision_masks.ground(),
    autoplace = {
      probability_expression = 1 --"1 - fulgora_dunes"
    },
    layer = 8,
    map_color={36, 20, 16},
    vehicle_friction_modifier = 4,
    --absorptions_per_second = tile_pollution.fulgora,
    sprite_usage_surface = "corrundum",
    variants =
    {
      transition = transition_masks(),
      material_background =
      {
        picture = "__corrundum__/graphics/terrain/corrundum-sand.png",
        line_length = 4,
        count = 16,
        scale = 0.5
      },
      material_texture_width_in_tiles = 10,
      material_texture_height_in_tiles = 7
    },
    transitions = fulgora_rock_sand_transitions,
    transitions_between_transitions = fulgora_sand_transitions_between_transitions,
    walking_sound = sound_variations("__base__/sound/walking/sand", 9, 0.8, volume_multiplier("main-menu", 2.9)),
    landing_steps_sound = tile_sounds.landing.sand,
    driving_sound = sand_driving_sound,
    ambient_sounds = sand_ambient_sound,
    scorch_mark_color = {r = 0.3, g = 0.3, b = 0.3, a = 1.000},
    trigger_effect = tile_trigger_effects.sand_trigger_effect()
  }



)

table.insert(water_tile_type_names, "petroleum-tile")