module Capybara

  module FailShow

    DEBUG_PRINT = false

    def self.activate

      RSpec.configure do |config|

        # Auto-open page if a feature fails
        # http://stackoverflow.com/questions/13982425/how-to-make-rspec-save-and-open-page-automatically-when-any-spec-fails

        config.after do

          # If you want to disable showing the browser window, set fail_show: false on your scenario
          # Example: scenario "Test something on course", fail_show: false do

          fail_show_disabled = RSpec.current_example.metadata[:fail_show] == false
          if !fail_show_disabled && RSpec.current_example.metadata[:type] == :feature && RSpec.current_example.exception.present?

            if DEBUG_PRINT
              puts "Example metadata"
              puts RSpec.current_example.metadata.inspect
              puts "Exception class:"
              puts RSpec.current_example.exception.class.to_s
              puts "Exception:"
              puts RSpec.current_example.exception.inspect
            end

            # Check so it is not something like a Template render error..
            if RSpec.current_example.exception.class.to_s.include?("Capybara") || RSpec.current_example.exception.class.to_s.include?("RSpec")

              # Below essentialy copies save_and_open_page method from Capybara and adds html with error

              path ||= "capybara-#{Time.new.strftime("%Y%m%d%H%M%S")}#{rand(10**10)}.html"
              path = File.expand_path(path, Capybara.save_and_open_page_path) if Capybara.save_and_open_page_path

              FileUtils.mkdir_p(File.dirname(path))

              extrahtml_replacing_body_start = "<body><div style='color:red;position:relative;z-index:1000;'><h3 style='color:red;'>Capybara - This feature failed: #{RSpec.current_example.metadata[:description_args].join('.')}</h3><p>#{RSpec.current_example.exception.message}</p></div>"

              # Only works when dev server running....
              Capybara.asset_host = "http://localhost:3000"

              File.open(path,'w') { |f| f.write(Capybara::Helpers.inject_asset_host(body.gsub(/<body.*>/, extrahtml_replacing_body_start))) }
              begin
                require "launchy"
                Launchy.open(path)
              rescue LoadError
                warn "Please install the launchy gem to open page with save_and_open_page"
              end
            end
          end
        end
      end

    end
  end
end
