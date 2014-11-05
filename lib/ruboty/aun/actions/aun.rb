require 'open3'

module Ruboty
  module Aun
    module Actions
      class Aun < Ruboty::Actions::Base
        def call
          handlers.each do |handler|
            output, error, status = Open3.capture3(handler, stdin_data: message.body)

            unless output.empty?
              message.reply(output.chomp)
            end

            unless error.empty? && status.success?
              message.reply("error, exit: #{status}, message: #{error.chomp}")
            end
          end
        end

        private

        def handlers
          Dir['aun/**/*'].select {|handler| File.executable?(handler) }
        end
      end
    end
  end
end
