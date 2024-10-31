local Fluid = {
  classname = "FNFluid"
}

function Fluid:get_fluid_list()
  Debug:debug(Fluid.classname, "get_fluid_list( )")
  return prototypes.fluid or {}
end

function Fluid:get_vFluid_list(fluid_list)
  Debug:debug(Fluid.classname, "get_vFluid_list_list(", fluid_list and "fluid_list", ")")
  return self:create_visible_fluids(fluid_list)
end

----------------------- secondary function --------------------------

function Fluid:create_visible_fluids(fluid_list)
  local ret_tb = {}

  for _,fluid in pairs(fluid_list) do
    if not fluid.hidden then
      ret_tb[fluid.name] = fluid
    end
  end

  return ret_tb
end

return Fluid