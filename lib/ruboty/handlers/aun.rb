require "ruboty/aun/actions/aun"

module Ruboty
  module Handlers
    class Aun < Base
      on /.*/, name: 'aun', description: 'aun hears everything you said', hidden: true, all: true

      def aun(message)
        Ruboty::Aun::Actions::Aun.new(message).call
      end
    end
  end
end
