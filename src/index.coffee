through = require 'through'

###
helper for browserify transforms,
sandwich the original data between a head and tail.
###
module.exports = (pattern, head, tail) ->
  (fileName) ->
    return through() unless pattern.test(fileName)
    write = (data) ->
      if head?
        @queue head
        head = null  # once
      @queue(data)
    end = ->
      @queue(tail)
      @queue(null)
    through write, end
