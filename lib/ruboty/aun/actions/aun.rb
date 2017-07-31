require 'open3'

module Ruboty
  module Aun
    module Actions
      class Aun < Ruboty::Actions::Base
        def call
          handlers.each do |handler|
            Open3.popen2e(handler) do |stdin, stdout_err, wait_thr|
              stdin.puts message.body
              stdin.close

              t = Time.now
              text = ""
              while line = stdout_err.gets
                elapsed = Time.now - t 
                text << line

                if elapsed > 1 && line != nil
                  message.reply(text)
                  t = Time.now
                  text = ""
                end
                Ruboty.logger.debug("msg in aun: #{line}")
              end
              Ruboty.logger.debug("last text aun: #{text}")
              message.reply("last text: #{text}")# unless text == ""
            
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
