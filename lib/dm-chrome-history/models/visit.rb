class Visit
  include DataMapper::Resource
  
  # CREATE TABLE visits(id INTEGER PRIMARY KEY,url INTEGER NOT NULL,visit_time INTEGER NOT NULL,from_visit INTEGER,transition INTEGER DEFAULT 0 NOT NULL,segment_id INTEGER,is_indexed BOOLEAN);

  # see http://src.chromium.org/viewvc/chrome/trunk/src/chrome/common/page_transition_types.h
  # or http://blogs.sans.org/computer-forensics/2010/01/21/google-chrome-forensics/ for analysis.
  
  property :id,                 Serial
  property :url_id,             Integer,          :required => true, :field => "url"
  property :visit_time,         ChromeEpochTime,  :required => true
  property :referrer_id,        Integer,          :field => "from_visit"
  property :transition,         Transition,       :default => 0, :writer => :private
  property :history_navigation, TransitionMask,   :field => "transition", :mask => 0x01000000, :writer => :private
  property :navigation_start,   TransitionMask,   :field => "transition", :mask => 0x10000000, :writer => :private
  property :navigation_end,     TransitionMask,   :field => "transition", :mask => 0x20000000, :writer => :private
  property :client_redirect,    TransitionMask,   :field => "transition", :mask => 0x40000000, :writer => :private
  property :server_redirect,    TransitionMask,   :field => "transition", :mask => 0x80000000, :writer => :private
  property :segment_id,         Integer
  property :is_indexed,         Boolean
  
  belongs_to  :segment
  belongs_to  :url, :child_key => [:url_id]
  belongs_to  :parent_visit, Visit, :parent_key=>[:referrer_id]
  has n,      :child_visits, Visit, :child_key => [:referrer_id]
end

#require 'dm-chrome-history'; DataMapper::Logger.new(STDOUT, 0); DataMapper.setup(:default, "sqlite3:///Users/knowtheory/data/archived_history")
