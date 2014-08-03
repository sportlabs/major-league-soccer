require 'logger'
require 'yaml'

logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG

# Check that the teams in mls.yml match up with the squads
# Look for missing data
[2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014].each do |year|
  # Grab the squad files
  path = File.expand_path('.')
  squad_files = Dir["#{path}/../data/#{year}/squads/*"]

  logger.debug("Squad files: #{squad_files}")

  # Grab the mls.yml file
  yml = YAML.load_file("#{path}/../data/#{year}/mls.yml")

  # Look for matches in both file lists
  # Make a copy of each list and delete from those copies
  # When we find a match
  squad_teams = squad_files.dup
  yml_teams = yml["teams"].dup

  yml["teams"].each do |y_team|
    squad_files.each do |s_team|
      if (s_team =~ /#{y_team}/)
        squad_teams.delete(s_team)
        yml_teams.delete(y_team)
        logger.debug("Found a match for #{y_team}: #{s_team}")
      end
    end
  end

  # Both lists should be empty if we found matches
  if (!yml_teams.empty? || !squad_teams.empty?)
    logger.error("Mismatch in team list and roster list: yml teams - #{yml_teams} squad teams - #{squad_teams}")
  end
end
