# Major League Soccer (MLS) Scripts

Scripts for scraping US Major League Soccer data.

## Usage

A `Rakefile` is included, which can be used to generate historical data:

```
rake -T
rake all               # Generate all MLS data
rake clean_match_data  # Remove existing match data
rake gen_match_data    # Generate all historical fixture data
rake gen_squads        # Generate the squads for each year
rake migrate_yml       # Generate a base .yml file for each year
```

`mls_scraper.rb` Can be used as a stand-alone script, or imported as a library.  Some examples of standalone usage:

```
ruby mls_scraper.rb -h
Usage: mls_scraper.rb [-o FILE -y YEAR -d games|teams|roster -v]
    -v, --verbose                    Print debug information
    -o, --output FILE                Output resuls to FILE
    -y, --year YEAR                  Get historical data for YEAR
    -r, --roster                     Get historical data for roster
    -a file1,file2,file3,...,        Helper files for formatting.  e.g. For roster, these can be team .yml files
        --aux_file
```

```
# Parse roster data from 2005 for all teams
ruby mls_scraper.rb -r -y 2005 -o data/2005/squads/ -a teams_us.txt,teams_ca.txt

# Parse match data from 2005 for all teams
ruby mls_scraper.rb -y 2005 -o data/2005/mls.txt
```

## Sources

* http://www.espnfc.com
* http://data2.7m.cn

