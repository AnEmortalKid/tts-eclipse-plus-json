--[[
  Adds a description context menu to tech tiles. Place this script on the bag that holds the technology tiles.
]]--

mappingURL = 'https://raw.githubusercontent.com/AnEmortalKid/tts-eclipse-plus-json/main/technology_tiles/mappings.json'
descriptionsURL = 'https://raw.githubusercontent.com/AnEmortalKid/tts-eclipse-plus-json/main/technology_tiles/descriptions.json'

-- name : description
tileDescriptions = {}

-- guid : name
tileData = {}

function onLoad()
  loadMappings()
  loadDescriptions()
end

function loadMappings()
  WebRequest.get(mappingURL, |g| populateMappings(g))
end

function populateMappings(webReturn)
  local data = JSON.decode(webReturn.text)
  for name,guids in pairs(data)
  do
    for k,v in pairs(guids)
    do
      tileData[v] = name
    end
  end
end

function loadDescriptions()
  WebRequest.get(descriptionsURL, |g| populateDescriptions(g))
end

function populateDescriptions(webReturn)
  local data = JSON.decode(webReturn.text)
  for name,description in pairs(data)
  do
    tileDescriptions[name] = description
  end
end

function onObjectLeaveContainer(bag, obj)
  if bag.getGUID() == self.getGUID() then
    local name = tileData[obj.getGUID()]
    if name ~= nil then
      local description = tileDescriptions[name]
      if description ~= nil then
        -- set the name on the original tile set, once grouped they will lose the GUID
        obj.setName(name)
        obj.setDescription(description)
        obj.addContextMenuItem('Describe Tile',  |pc| describeTile(pc, name, description))
      end
    end
  end
end

function describeTile(player, name, description)
  local msg = '[b]' .. name .. '[/b]: '.. description
  broadcastToColor(msg, player, { r = 1, g = 1, b = 1})
end
