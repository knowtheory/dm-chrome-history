CREATE TABLE downloads (
	id INTEGER PRIMARY KEY,
	full_path LONGVARCHAR NOT NULL,
	url LONGVARCHAR NOT NULL,
	start_time INTEGER NOT NULL,
	received_bytes INTEGER NOT NULL,
	total_bytes INTEGER NOT NULL,
	state INTEGER NOT NULL);

CREATE TABLE keyword_search_terms (keyword_id INTEGER NOT NULL,
	url_id INTEGER NOT NULL,
	lower_term LONGVARCHAR NOT NULL,
	term LONGVARCHAR NOT NULL);

CREATE TABLE meta(key LONGVARCHAR NOT NULL UNIQUE PRIMARY KEY,
	value LONGVARCHAR);

CREATE TABLE presentation(url_id INTEGER PRIMARY KEY,
	pres_index INTEGER NOT NULL);

CREATE TABLE segment_usage (id INTEGER PRIMARY KEY,
	segment_id INTEGER NOT NULL,
	time_slot INTEGER NOT NULL,
	visit_count INTEGER DEFAULT 0 NOT NULL);

CREATE TABLE segments (id INTEGER PRIMARY KEY,
	name VARCHAR,
	url_id INTEGER NON NULL,
	pres_index INTEGER DEFAULT -1 NOT NULL);

CREATE TABLE urls(id INTEGER PRIMARY KEY,
	url LONGVARCHAR,
	title LONGVARCHAR,
	visit_count INTEGER DEFAULT 0 NOT NULL,
	typed_count INTEGER DEFAULT 0 NOT NULL,
	last_visit_time INTEGER NOT NULL,
	hidden INTEGER DEFAULT 0 NOT NULL,
	favicon_id INTEGER DEFAULT 0 NOT NULL);

CREATE TABLE visits(id INTEGER PRIMARY KEY,
	url INTEGER NOT NULL,
	visit_time INTEGER NOT NULL,
	from_visit INTEGER,
	transition INTEGER DEFAULT 0 NOT NULL,
	segment_id INTEGER,
	is_indexed BOOLEAN);

CREATE INDEX keyword_search_terms_index1 ON keyword_search_terms (keyword_id, lower_term);
CREATE INDEX keyword_search_terms_index2 ON keyword_search_terms (url_id);
CREATE INDEX segment_usage_time_slot_segment_id ON segment_usage(time_slot, segment_id);
CREATE INDEX segments_name ON segments(name);
CREATE INDEX segments_url_id ON segments(url_id);
CREATE INDEX segments_usage_seg_id ON segment_usage(segment_id);
CREATE INDEX urls_favicon_id_INDEX ON urls (favicon_id);
CREATE INDEX urls_url_index ON urls (url);
CREATE INDEX visits_from_index ON visits (from_visit);
CREATE INDEX visits_time_index ON visits (visit_time);
CREATE INDEX visits_url_index ON visits (url);
