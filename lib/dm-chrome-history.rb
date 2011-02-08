require 'dm-core'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-types'

require 'dm-chrome-history/types/chrome_epoch_time'
require 'dm-chrome-history/types/transition'

require 'dm-chrome-history/models/download'
require 'dm-chrome-history/models/keyword_search_term'
require 'dm-chrome-history/models/segment'
require 'dm-chrome-history/models/url'
require 'dm-chrome-history/models/visit'

module Chrome
  def self.setup_history(path, stfu=false)
    raise "Don't use your Chrome history in place. Quit Chrome, make a copy, and try again" if !stfu and
      (path.include?("/Library/Application Support/Google/")) # add more conditions for other OSes.
    
    raise "Couldn't find a Chrome history database at #{path}" unless File.exists?(path)
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(:default, "sqlite://#{path}")
  end
end

#$:.unshift('./lib'); require 'dm-chrome-history'; Chrome.setup_history('/Users/knowtheory/data/History')
#DateTime.now.midnight.prev_day.prev_day
#visits = Visit.all('visit_time.gte' => DateTime.now.midnight.prev_day.prev_day, 'visit_time.lt' => DateTime.now.midnight.prev_day)
#urls = visits.map(&:url)