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

                if elapsed > 1
                  message.reply(truncate_text(text))
                  t = Time.now
                  text = ""
                end
                text << line
              end
              message.reply(truncate_text(text)) unless text.nil?
            
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

        def truncate_text(text)
          text.size > 3900 ? text[0..3900].chomp + "..........(`truncated`)\n" : text
        end
      end
    end
  end
end
