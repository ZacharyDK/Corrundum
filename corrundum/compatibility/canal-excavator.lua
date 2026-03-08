if not mods["canal-excavator"] then return end

data:extend({{
  type = "mod-data",
  name = "canex-corrundum-config",
  data_type = "canex-surface-config",
  data = {
    surfaceName = "corrundum",
    localisation = {"space-location-name.corrundum"},
    oreStartingAmount = 40,
    mining_time = 2,
    tint = {r = 120, g = 80, b = 60},
    mineResult = {
      {type="item", name = "stone", probability = 0.8, amount = 1},
      {type="item", name = "sulfur", probability = 0.2, amount = 1},
    }
  }
}})