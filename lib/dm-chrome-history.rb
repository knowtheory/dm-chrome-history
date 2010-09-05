=begin
  CREATE TABLE meta(key LONGVARCHAR NOT NULL UNIQUE PRIMARY KEY,value LONGVARCHAR);
  CREATE TABLE presentation(url_id INTEGER PRIMARY KEY,pres_index INTEGER NOT NULL);
  CREATE TABLE segment_usage (id INTEGER PRIMARY KEY,segment_id INTEGER NOT NULL,time_slot INTEGER NOT NULL,visit_count INTEGER DEFAULT 0 NOT NULL);
=end

require 'dm-core'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-types'
require File.join(File.dirname(__FILE__), 'chrome_epoch_time')

#@chrome_history = "sqlite3:///Users/knowtheory/data/chrome_history"
DataMapper.setup(:default, @chrome_history)

class Download
  include DataMapper::Resource

  # CREATE TABLE downloads (id INTEGER PRIMARY KEY,full_path LONGVARCHAR NOT NULL,url LONGVARCHAR NOT NULL,start_time INTEGER NOT NULL,received_bytes INTEGER NOT NULL,total_bytes INTEGER NOT NULL,state INTEGER NOT NULL);
  
  property :id,             Serial
  property :full_path,      String,     :required => true
  property :url,            String,     :required => true
  property :start_time,     EpochTime,  :required => true
  property :recieved_bytes, Integer,    :required => true
  property :total_bytes,    Integer,    :required => true
  property :state,          Integer,    :required => true
end

class KeywordSearchTerm
  include DataMapper::Resource
  
  # CREATE TABLE keyword_search_terms (keyword_id INTEGER NOT NULL,url_id INTEGER NOT NULL,lower_term LONGVARCHAR NOT NULL,term LONGVARCHAR NOT NULL);
  property :keyword_id, Serial
  property :url_id,     Integer,  :required => true
  property :lower_term, String,   :required => true
  property :term,       String,   :required => true
  
  belongs_to :url
end

class Segment
  include DataMapper::Resource
  
  # CREATE TABLE segments (id INTEGER PRIMARY KEY,name VARCHAR,url_id INTEGER NON NULL,pres_index INTEGER DEFAULT -1 NOT NULL);
  
  property :id,         Serial
  property :name,       String
  property :url_id,     Integer,  :required => true
  property :pres_index, Integer,  :default => -1
  
  belongs_to :url
  has n, :visits
end

class Url
  include DataMapper::Resource
  
  # CREATE TABLE urls(
  #   id              INTEGER PRIMARY KEY,
  #   url             LONGVARCHAR,
  #   title           LONGVARCHAR,
  #   visit_count     INTEGER DEFAULT 0 NOT NULL,
  #   typed_count     INTEGER DEFAULT 0 NOT NULL,
  #   last_visit_time INTEGER NOT NULL,
  #   hidden          INTEGER DEFAULT 0 NOT NULL,
  #   favicon_id      INTEGER DEFAULT 0 NOT NULL
  # );
  property :id,               Serial
  property :url,              URI,              :format => :url
  property :title,            String
  property :visit_count,      Integer,          :min => 1
  property :typed_count,      Integer,          :default => 0
  property :last_visit_time,  ChromeEpochTime,  :required => true
  property :hidden,           Integer,          :default => 0
  property :favicon_id,       Integer,          :default => 0
  
  has n, :segments
  has n, :visits, :through => :segments
end

class Visit
  include DataMapper::Resource
  
  # CREATE TABLE visits(id INTEGER PRIMARY KEY,url INTEGER NOT NULL,visit_time INTEGER NOT NULL,from_visit INTEGER,transition INTEGER DEFAULT 0 NOT NULL,segment_id INTEGER,is_indexed BOOLEAN);
  
  property :id,         Serial
  property :url_id,     Integer,          :required => true, :field => "url"
  property :visit_time, ChromeEpochTime,  :required => true
  property :from_visit, Integer
  property :transition, Integer,          :default => 0
  property :segment_id, Integer
  property :is_indexed, Boolean
  
  belongs_to :segment
  belongs_to :url
end