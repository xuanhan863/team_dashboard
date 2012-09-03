require "nokogiri"

namespace :graphite do
  desc "Generate Graphite Function list"
  task :generate_functions_file => :environment do
    body = HttpService.request("http://graphite.readthedocs.org/en/1.0/functions.html")
    puts body.size

    page = Nokogiri::HTML(body)
    result = []
    page.css("dl.function").each do |element|
      name = element.css("dt .descname").text
      description = element.css("dd > p")[0].text
      example = element.css("dd pre").text

      result << { :name => name, :description => description, :example => example }
    end

    file = Rails.root.join("app/assets/javascripts/graphite_functions.js")
    puts "Writing to #{file}"

    wrapper = <<-EOF
// This file is autogenerated by graphite.rake
// Do not manually change it.
(function(helpers) {
  helpers.GRAPHITE_FUNCTIONS = #{result.to_json};
})(app.helpers);
    EOF
    
    File.open(file, 'w') { |f| f.write(wrapper) }
    puts "Found #{result.size} graphite functions. Done :-)"
  end
end