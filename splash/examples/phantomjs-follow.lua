-- Implementation of "follow.js" example from
-- PhantomJS
-- https://github.com/ariya/phantomjs/blob/master/examples/follow.js

USERS = {
  'PhantomJS',
  'ariyahidayat',
  'detronizator',
  'KDABQt',
  'lfranchi',
  'jonleighton',
  '_jamesmgreene',
  'Vitalliumm',
}

local base = 'http://mobile.twitter.com/'
function follow(splash, user)
  local ok, msg = splash:go(base .. user)
  if not ok then
    return "Can't get followers of " .. user .. ': ' .. msg
  end
  -- in practice it is easier to use splash:select(...):text(); evaljs
  -- is just to make example closer to PhantomJS
  return splash:evaljs([[
    document.querySelector('div.profile td.stat.stat-last div.statnum').innerText;
  ]]);
end

function process(splash, users)
  local result = {}
  for idx, user in ipairs(users) do
    result[user] = follow(splash, user)
  end
  return result
end

return {users=process(splash, USERS)}
