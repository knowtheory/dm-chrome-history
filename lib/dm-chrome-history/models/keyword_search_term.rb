class KeywordSearchTerm                               # CREATE TABLE keyword_search_terms (
  include DataMapper::Resource

  property :keyword_id, Serial                        #   keyword_id INTEGER NOT NULL,
  property :url_id,     Integer,  :required => true   #   url_id INTEGER NOT NULL,
  property :lower_term, String,   :required => true   #   lower_term LONGVARCHAR NOT NULL,
  property :term,       String,   :required => true   #   term LONGVARCHAR NOT NULL

  belongs_to :url
end                                                   # );
