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
function get_prototypes_list(player, search_text)
  search_text = search_text:gsub(" ", "-"):lower()
  local items = find_items(search_text)
  local fluids = find_fluids(search_text)
  local ret_mas = {}
  for _,prot in pairs(items) do
    if check_item_setting(player, prot) then
      table.insert(ret_mas, prot)
    end
  end 
  for _,prot in pairs(fluids) do
    if check_fluid_setting(player, prot) then
      table.insert(ret_mas, prot)
    end
  end 

  return ret_mas
end
--utils
function check_item_setting(player, element)
  local item = game.item_prototypes[element.name]
  if item then
    if not fnei.oc.show_hidden_item(player) and item.has_flag("hidden") and item.flags["hidden"] == true then
      return false
    end
    return true
  end
  return false
end
--utils
function check_fluid_setting(player, element)
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
      --out(entity.name.." "..entity.ingredient_count)
      for category,v in pairs(entity.crafting_categories) do
        table.insert(category_tb, {cat_name = category, item_name = item.name})
      end
    end 
  end 
  return category_tb
end
--utils
function item_exists( list, item_name )
  for _,elem in pairs(list) do
    if elem.name == item_name then
      return true
    end
  end
  return false
end
--utils
function get_item_list_from_cat_tb( category )
  local cat_tb = get_crafting_category_table()
  local items = {}
  for _,elem in pairs(cat_tb) do
    if category == nil or category == elem.cat_name then
      if not item_exists(items, elem.item_name) then
        table.insert(items, {name = elem.item_name, type = "itemName"})
      end
    end
  end
  return items
end
--utils
function get_filtred_items( player, recipe )
  local ret_list = {}
  local items = get_craft_cat_whis_amount(player, recipe.category, #recipe.ingredients)
  for _,item in pairs(items) do
    if fnei.oc.get_craft_state_for_building( player, item.name) then
      table.insert(ret_list, {type = "item", name = item})
    end
  end
  return ret_list
end
--utils
function get_madein_list( player, recipe )
  if recipe then
    --[[if player.character then
      local cr_cat = player.character.prototype.crafting_categories
      if cr_cat then
        for category,v in pairs(cr_cat) do
          out(category)
        end
      end
    end]]
    return get_filtred_items(player, recipe)
  else 
    return {}
  end
end

--utils
function can_player_craft_this_recipe( player, recipe )
  if player and player.character then
    local cr_cat = player.character.prototype.crafting_categories
    if cr_cat then
      for category,v in pairs(cr_cat) do
        if category == recipe.category then
          return true
        end
      end
    end
  end
  return false
end

--utils
function check_non_destination( player, recipe )
  if not fnei.oc.show_non_destination(player) and not recipe.enabled and get_technologies(player, recipe.name) == nil then
    return false
  end
  return true
end
--utils
function get_filtered_recipe_list( player, recipes )
  local filer_buf = {}
  local ret_list = {}
  for _,rec in pairs(recipes) do
    local cat = rec.category
    if cat then
      if filer_buf[cat] == nil then
        filer_buf[cat] = get_filtred_items(player, rec)
      end
      if #filer_buf[cat] > 0 and check_non_destination(player, rec) then
        table.insert(ret_list, rec)
      end
    end
  end
  return ret_list
end
--utils
function get_craft_recipe_list( player, element )
  local recipes = player.force.recipes
  local ret_recipe = {}
  for _,recipe in pairs(recipes) do
    for _,product in pairs(recipe.products) do
      if product.name == element.name then
        if product.type == element.type then
          table.insert(ret_recipe, recipe)
        end
      end
    end
  end
  return get_filtered_recipe_list(player, ret_recipe)
end
--utils
function get_usage_recipe_list( player, element )
  local recipes = player.force.recipes
  local ret_recipe = {}
  for _,recipe in pairs(recipes) do
    for _,ingredient in pairs(recipe.ingredients) do
      if ingredient.name == element.name and ingredient.type == element.type then
        table.insert(ret_recipe, recipe)
      end
    end
  end
  return get_filtered_recipe_list(player, ret_recipe)
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

function get_gui_pos(player)
  local index = fnei.oc.get_gui_position( player )
  if index == 1 then
    return player.gui.left
  elseif index == 2 then
    return player.gui.top
  elseif index == 3 then
    return player.gui.center
  else
    player.print("utils: get_gui: invalid direction: " .. index)
  end
end

function open_tech(player, name, list)
  local tech = player.force.technologies[name]
  if tech then
    for _,tech in pairs(tech.prerequisites) do
      if tech.researched == false then
        list = open_tech(player, tech.name, list)
        for _,effect in pairs(tech.effects) do
          if effect.type == "unlock-recipe" then
            local recipe = player.force.recipes[effect.recipe]
            if recipe and recipe.enabled == true then
              table.insert(list.recipe, recipe.name)
            end
          end
        end
        tech.researched = true
        table.insert(list.tech, tech.name)
      end
    end
  end
  return list
end

function reload_tech(player, list)
  local tech_list = list.tech
  for i=1,#tech_list do
    local tech = player.force.technologies[tech_list[i]]
    if tech then
      tech.researched = false
    end
  end
  local recipe_list = list.recipe
  for i=1,#recipe_list do
    local recipe = player.force.recipes[recipe_list[i]]
    if recipe then
      recipe.enabled = true
    end
  end
end

function show_tech(player, name)
  if player.force.technologies[name] then
    local list = {}
    list.tech = {}
    list.recipe = {}
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