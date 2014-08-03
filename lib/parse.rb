
module Parse

  # Load N YAML files to determine what the keys for for each team
  def lookup_team_keys(files)
    @team_keys = {}
    yaml_teams = []
    team_keys = {}
    files.each do |file|
      if (file =~ /\.yml/)
        f = YAML.load_file(file)
        yaml_teams += f["teams"]
      else
        # Use the teams.txt files because they have more info - easier to match
        File.open(file).each do |line|
          match = /^([A-Za-z0-9_\-]+),/.match(line)
          if(match && match[1])
            team_keys[match[1]] = line.strip
          end
        end
      end
    end

    # Scrub the team_keys with the yaml list of teams, if it is provided
    if (!yaml_teams.empty?)
      @team_keys = {}
      yaml_teams.each do |team|
        @team_keys[team] = team_keys[team]
      end
    else
      @team_keys = team_keys
    end

    @logger.debug("[lookup_team_keys] team_keys: " + @team_keys.to_s)
  end

  # Lookup a team's key
  def find_key(name, year=0)
    search_name = name

    # The match source doesn't have the right name for New York in
    # 2005, 2006.  FIXME... find a better way to do this
    if (search_name =~ /New York/)
      if (year >= 2001 && year <= 2005)
        return "nymetro"
      elsif (year > 2005)
        return "newyork"
      end
    end

    @team_keys.each do |key, line|
      if (line =~ /#{name}/i)
        @logger.debug("[find_key] Found #{key} for #{name}")
        return key
      end
    end

    @logger.error("[find_key] No match for #{name}")
    return "none"
  end

end
