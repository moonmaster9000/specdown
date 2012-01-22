$LOAD_PATH.unshift './lib'
require 'specdown'
require 'rspec/expectations'

class String
  def undent
    gsub(/^.{#{slice(/^ +/).length}}/, '')
  end
end
