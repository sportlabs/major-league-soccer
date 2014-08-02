
module Parse

  # Load N YAML files to determine what the keys for for each team
  def lookup_team_keys(files)
    @team_keys = {}
    files.each do |file|
      if (file =~ /\.yml/)
        # Try to use the yml directly
        f = YAML.load_file(file)
        @team_keys += f["teams"]
      else
        # Use the teams.txt files because they have more info - easier to match
        File.open(file).each do |line|
          match = /^([A-Za-z0-9_\-]+),/.match(line)
          if(match && match[1])
            @team_keys[match[1]] = line.strip
          end
        end
      end
    end
    @logger.debug("[lookup_team_keys] team_keys: " + @team_keys.to_s)
  end

  # Lookup a team's key
  def find_key(name)
    @team_keys.each do |key, line|
      if (line =~ /#{name}/i)
        @logger.debug("[find_key] Found #{key} for #{name}")
        return key
      end
    end

    @logger.debug("[find_key] No match for #{name}")
    return "none"
  end

end
