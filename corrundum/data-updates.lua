--table.insert(data.raw.lab["lab"].inputs, "electrochemical-science-pack")
data.raw["fluid"]["petroleum-gas"].fuel_value = "0.6MJ"


local all_lab_types = data.raw['lab']
--local all_science_packs = data.raw['tool']['science-pack'] --WHY IS THIS NIL ?!?!??! AND WHY does data.raw['tool'] not iterate to a string

for k,v in pairs(all_lab_types) do
    table.insert(v.inputs,"electrochemical-science-pack") --add my science pack to all labs
end

--[[
for k,v in pairs(all_science_packs) do
    table.insert(data.raw["lab"]["pressure-lab"].inputs,v .. ",")
end
--]]
