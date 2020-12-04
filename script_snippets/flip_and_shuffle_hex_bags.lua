--[[
  Place this on the Global script
]]--
function flip_and_shuffle_sector_tiles(params)
  local bag = params.bag
  for i,v in ipairs(bag.getObjects())
  do
    local innerGuid = getObjectFromGUID(v["guid"])
    local tile = bag.takeObject(innerGuid)
    tile.flip()
    bag.putObject(tile)
  end
  bag.shuffle()
end

--[[
  Place this snippet as a script on the individual bags for the sector tiles

]]--
function onLoad()
  params = { bag = self }
  Global.call('flip_and_shuffle_sector_tiles', params)
end
