require 'open3'

module Ruboty
  module Aun
    module Actions
      class Aun < Ruboty::Actions::Base
        def call
          handlers.each do |handler|
            Open3.popen2e(handler, stdin_data: message.body) do |stdin, stdout_err, wait_thr|
              while line = stdout_err.gets
                message.reply(stdout_err)
              end
            
              exit_status = wait_thr.value
              unless exit_status.success?
                message.reply("error, exit: #{exit_status}, message: #{stdout_err.chomp}")
              end
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
