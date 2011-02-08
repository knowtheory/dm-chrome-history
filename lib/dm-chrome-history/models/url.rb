class Url                                                           # CREATE TABLE urls(
  include DataMapper::Resource

  property :id,               Serial                                #   id              INTEGER PRIMARY KEY,
  property :url,              URI                                   #   url             LONGVARCHAR,
  property :title,            String                                #   title           LONGVARCHAR,
  property :visit_count,      Integer,          :min => 1           #   visit_count     INTEGER DEFAULT 0 NOT NULL,
  property :typed_count,      Integer,          :default => 0       #   typed_count     INTEGER DEFAULT 0 NOT NULL,
  property :last_visit_time,  ChromeEpochTime,  :required => true   #   last_visit_time INTEGER NOT NULL,
  property :hidden,           Integer,          :default => 0       #   hidden          INTEGER DEFAULT 0 NOT NULL,
  property :favicon_id,       Integer,          :default => 0       #   favicon_id      INTEGER DEFAULT 0 NOT NULL
  
  has n, :segments
  has n, :segment_visits, "Visit", :through => :segments # Visit class isn't loaded yet, use a String.
  has n, :visits
end                                                                 # );
