require 'open3'

module Ruboty
  module Aun
    module Actions
      class Aun < Ruboty::Actions::Base
        def call
          handlers.each do |handler|
            last_text = ""
            message.reply('before open')
            Open3.popen2e(handler) do |stdin, stdout_err, wait_thr|
              stdin.puts message.body
              stdin.close

              t = Time.now
              text = ""
              while line = stdout_err.gets
                elapsed = Time.now - t 

                if elapsed > 1
                  message.reply(text)
                  t = Time.now
                  text = ""
                end
                text << line
                last_text = text
              end
              message.reply(last_text)
            
              exit_status = wait_thr.value
              unless exit_status.success?
                message.reply("error, exit: #{exit_status}, message: #{stdout_err.chomp}")
              end
            end
            message.reply(last_text)
            message.reply('after open')
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
