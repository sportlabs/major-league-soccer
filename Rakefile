#require 'FileUtils'

years = (2005..2014)
debug = ENV['debug'] ? ENV['debug'] : false
stat = ENV['stat'] ? ENV['stat'] : false


years.each do |year|
  directory "data/#{year}"

  file "data/#{year}/squads" => "data/#{year}" do
    sh "mkdir -p data/#{year}/squads/"
    sh "ruby mls_scraper.rb -r -y #{year} -o data/#{year}/squads/ -a teams_us.txt,teams_ca.txt,data/#{year}/mls.yml " + (stat ? "-s " : "" ) + (debug ? "-v" : "")
  end

  file "data/#{year}/mls.txt" => "data/#{year}" do
    sh "ruby mls_scraper.rb -y #{year} -o data/#{year}/mls -a teams_us.txt,teams_ca.txt " + (debug ? "-v" : "")
  end

  file "data/#{year}/mls.yml" => "data/#{year}" do
    sh "ruby mls_scraper.rb -y #{year} -o data/#{year}/mls -a teams_us.txt,teams_ca.txt " + (debug ? "-v" : "")
  end
end

desc "Generate all historical fixture data"
task :gen_match_data => years.map { |year| "data/#{year}/mls.txt"} do
  p "Generated all fixture data"
end

desc "Generate a base .yml file for each year.  Might need manual updates"
task :migrate_yml => years.map {|year| "data/#{year}/mls.yml"} do
  p "Generated all yml data"
end

desc "Generate the squads for each year"
task :gen_squads => years.map {|year| "data/#{year}/squads"} do
  p "Generated all squad data"
end

desc "Remove existing match data"
task :clean_match_data do
  p "Are you sure you want remove all match data (Y/N)? "
  response  = $stdin.gets.strip

  if (response =~ /y/i)
    years.each do |year|
      FileUtils.rm("data/#{year}/mls.txt")
    end
  end
end

desc "Remove existing squad data"
task :clean_squad_data do
  p "Are you sure you want remove all squad data (Y/N)? "
  response  = $stdin.gets.strip

  if (response =~ /y/i)
    years.each do |year|
      FileUtils.rm_rf("data/#{year}/squads")
    end
  end
end


desc "Generate all MLS data"
task :all => [:gen_match_data, :migrate_yml, :gen_squads] do
  p "Generated all data!"
end

desc "Run unit tests"
task :test => [:all] do
  p "Testing is unimplemented" 
end

