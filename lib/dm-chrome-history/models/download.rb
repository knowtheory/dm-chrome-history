class Download                                                # CREATE TABLE downloads (
  include DataMapper::Resource

  property :id,             Serial                            #   id INTEGER PRIMARY KEY,
  property :full_path,      String,     :required => true     #   full_path LONGVARCHAR NOT NULL,
  property :url,            String,     :required => true     #   url LONGVARCHAR NOT NULL,
  property :start_time,     EpochTime,  :required => true     #   start_time INTEGER NOT NULL,
  property :recieved_bytes, Integer,    :required => true     #   received_bytes INTEGER NOT NULL,
  property :total_bytes,    Integer,    :required => true     #   total_bytes INTEGER NOT NULL,
  property :state,          Integer,    :required => true     #   state INTEGER NOT NULL
end                                                           #);

