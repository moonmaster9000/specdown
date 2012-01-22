module Specdown
  module Pending
    def pending
      raise Specdown::PendingException
    end
  end
end
