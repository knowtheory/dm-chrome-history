class Segment                                       # CREATE TABLE segments (
  include DataMapper::Resource

  property :id,         Serial                       #  id INTEGER PRIMARY KEY,
  property :name,       String                       #  name VARCHAR,
  property :url_id,     Integer,  :required => true  #  url_id INTEGER NON NULL,
  property :pres_index, Integer,  :default => -1     #  pres_index INTEGER DEFAULT -1 NOT NULL
                                                     
  belongs_to :url
  has n, :visits 
end                                                  # );
                                                         