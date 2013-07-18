emitter = 
  callbacks: {}


bind = (ev, callback) ->
  evs   = ev.split(' ')
  calls = emitter.callbacks
  for name in evs
    emitter.callbacks[name] or= []
    emitter.callbacks[name].push callback


trigger = (args...) ->
  ev = args.shift()
  return unless emitter.callbacks[ev]
  for callback in emitter.callbacks[ev]
    if callback(args...) is false
      break
  true


unbind = (ev, callback) ->
  evs = ev.split ' '
  for name in evs
    list = emitter.callbacks[name]
    continue unless list
    unless callback
      delete emitter.callbacks[name]
      continue
    for cb, i in list when (cb is callback)
      list = list.slice()
      list.splice i, 1
      emitter.callbacks[name] = list
      break


callbacks_map = -> emitter.callbacks


module.exports = {bind, trigger, unbind, callbacks_map}