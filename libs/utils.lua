--utils
function clear_list(list)
  local count = #list
  for i=0, count do list[i]=nil end
end
--utils
function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end
--utils
function get_prototypes_list(search_text)
  local items = find_items(search_text)
  local fluids = find_fluids(search_text)
  local ret_mas = {}
  for _,prot in pairs(items) do
    if check_item_setting(prot) then
      table.insert(ret_mas, prot)
    end
  end 
  for _,prot in pairs(fluids) do
    if check_fluid_setting(prot) then
      table.insert(ret_mas, prot)
    end
  end 

  return ret_mas
end
--utils
function check_item_setting(element)
  local item = game.item_prototypes[element.name]
  if item then
    if true and item.has_flag("hidden") and item.flags["hidden"] == true then
      return false
    end
  end
  return true
end
--utils
function check_fluid_setting(element)
  return true
end
--utils
function find_prototypes(mas, search_text, prot_type)
  search_text = normalize_string(search_text)
  local ret_mas = {}
  for _,prot in pairs(mas) do
    if string.match(prot.name:lower(), search_text)  then
      table.insert(ret_mas, {name = prot.name, type = prot_type})
    end
  end 
  return ret_mas
end
--utils
function find_items(search_text)
  return find_prototypes(game.item_prototypes, search_text, "itemName")
end
--utils
function find_fluids(search_text)
  return find_prototypes(game.fluid_prototypes, search_text, "fluidName")
end
--utils
function normalize_string(str)
  if not str then str = "" end
  return string.gsub(str, "%p", "%%%0")
end
--utils
function get_crafting_category_table()
  local category_tb = {}
  for _,item in pairs(game.item_prototypes) do
    local entity = item.place_result
    if entity ~= nil and entity.crafting_categories then
      for category,v in pairs(entity.crafting_categories) do
        table.insert(category_tb, {name = category, entity = entity.name})
      end
    end 
  end 
  return category_tb
end
--utils
function get_madein_list(recipe)
  local ret_tb = {}
  local cat_tb = get_crafting_category_table()
  if recipe then
    local rec_cat = recipe.category
    
    for _,elem in pairs(cat_tb) do
      if (rec_cat == elem.name) then
        table.insert(ret_tb, {name = elem.entity, type = "itemName"})
      end
    end
  end
  return ret_tb
end
--utils
function get_craft_recipe_list(player, element)
  local recipes = player.force.recipes
  local ret_recipe = {}
  for _,recipe in pairs(recipes) do
    if not (recipe.name:find("-flaring") or recipe.name:find("-barrel") or recipe.name:find("-incineration")) then
      for _,product in pairs(recipe.products) do
        
        if product.name == element.name then
          if product.type == element.type then
            table.insert(ret_recipe, recipe)
          end
        end
      end
    end
  end
  return ret_recipe
end
--utils
function get_usage_recipe_list(player, element)
  local recipes = player.force.recipes
  local ret_recipe = {}
  for _,recipe in pairs(recipes) do
    if not (recipe.name:find("-flaring") or recipe.name:find("-barrel") or recipe.name:find("-incineration")) then
      for _,ingredient in pairs(recipe.ingredients) do
        if ingredient.name == element.name and ingredient.type == element.type then
          table.insert(ret_recipe, recipe)
        end
      end
    end
  end
  return ret_recipe
end
--utils
function sort_enable_recipe_list(list)
  local ret_list = {}
  for _,recipe in pairs(list) do
    if recipe and recipe.enabled then
      table.insert(ret_list, recipe)
    end
  end
  for _,recipe in pairs(list) do
    if recipe and not recipe.enabled then
      table.insert(ret_list, recipe)
    end
  end
  return ret_list
end
--utils
function element_exist(element)
  if element.type == "item" then
    local items = game.item_prototypes
    for _,prot in pairs(items) do
      if prot.name == element.name then
        return true
      end
    end
  end
  if element.type == "fluid" then
    local fluids = game.fluid_prototypes
    for _,prot in pairs(fluids) do
      if prot.name == element.name then
        return true
      end
    end
  end
  return false
end
--utils
function get_technologies(player, recipe_name)
  local techs = player.force.technologies
  local ret_tech = nil

  for _,tech in pairs(techs) do
    for _,modifier in pairs(tech.effects) do
      if modifier.type == "unlock-recipe" and modifier.recipe == recipe_name then
        ret_tech = tech
        break
      end
    end
  end

  return ret_tech
end

function get_localised_name(ingr)
  local elem = nil
  if ingr.type == "fluid" then
    elem = game.fluid_prototypes[ingr.name]
  elseif ingr.type == "item" then
    elem = game.item_prototypes[ingr.name]
  end
  if elem == nil then
    return "unknown element"
  else
    return elem.localised_name
  end
end

function get_elem_amount(elem)
  local amt = elem.amount
  if amt == nil then 
    return 0
  else
    return amt
  end
end

function get_elem_prob(elem)
  local prob = elem.probability
  if prob == nil then 
    return 0
  else
    return prob * 100
  end
end

function get_gui_pos(player, dir)
  local index = fnei.oc.get_gui_position( player )
  if index == 1 then
    return player.gui.left
  elseif index == 2 then
    return player.gui.top
  elseif index == 3 then
    return player.gui.center
  else
    player.print("utils: get_gui: invalid direction: "..dir)
  end
end

function open_tech(player, name, list)
  local tech = player.force.technologies[name]
  if tech then
    for _,tech in pairs(tech.prerequisites) do
      if tech.researched == false then
        list = open_tech(player, tech.name, list)
        tech.researched = true
        table.insert( list, tech.name )
      end
    end
  end
  return list
end

function reload_tech(player, list)
  for i=1,#list do
    local tech = player.force.technologies[list[i]]
    if tech then
      tech.researched = false
    end
  end
end

function show_tech(player, name)
  if player.force.technologies[name] then
    local list = {}
    if player and  player.force.current_research then
      global.fnei.cur_tech = {
        name = player.name, 
        tech = player.force.current_research.name, 
        time = 0,
        progress = player.force.research_progress,
      }
    end
    list = open_tech(player, name, list)
    player.force.current_research = name
    reload_tech(player, list)
    fnei.gui.exit_from_gui(player)
    player.opened = 2
    player.force.current_research = nil
  end
end

function return_prev_tech()
  local prev_data = global.fnei.cur_tech
    if prev_data.time > 0 then
      game.players[prev_data.name].force.current_research = prev_data.tech
      game.players[prev_data.name].force.research_progress = prev_data.progress
      global.fnei.cur_tech = nil
    else
      global.fnei.cur_tech.time = global.fnei.cur_tech.time + 1
    end
end