require 'lib/dm-chrome-history'

#urls = Url.all(:fields=>[:id, :url, :visit_count], :order=>[:visit_count.desc], :limit =>32000); urls.map{|u| u.visit_count}
Url.count("visit_count.lt" => 1) # => 32 # waaaaat.
Url.all("visit_count.lt" => 1).map{ |u| u.last_visit_time} # looks like someone broke view counting in june.

urls = Url.all("visit_count.gt" => 1)
repeat_visits = urls.size
total_visits = Url.count("visit_count.gte" => 1)

hosts = Url.all.map{ |u| u.url.host }.uniq; ""

def bin_count
  visit_counts = Url.all(:fields=>[:visit_count], :order=>[:visit_count.desc]).map{|u|u.visit_count}.uniq
  bins = {}
  visit_counts.each{ |bin| bins[bin] = Url.count(:visit_count => bin) }
  bins
end

def bin_percent
  bins = {}
  url_count = Url.count
  bin_count.each{ |bin, count| bins[bin] = count.to_f / url_count * 100 }
  bins
end

hosts = Url.all(:fields=>[:url]).map{|u| u.url.match(/^\w+:\/\/([^\/]+)/).to_a.last }; ""

host_counts = {};  Url.all(:fields=>[:url, :visit_count]).each{|u| host_counts[u.url.host] ||= 0; host_counts[u.url.host] += u.visit_count  }; ""

hour_histogram = {}
Url.first.visits.map{ |v| hour_histogram[v.visit_time.hour] ||= 0; hour_histogram[v.visit_time.hour] += 1 }
hour_histogram.sort_by{ |k,v| - v }

# Aggregate hourly browsing histogram
hour_histogram = {}
Visit.all.map{ |v| hour_histogram[v.visit_time.hour] ||= 0; hour_histogram[v.visit_time.hour] += 1 }; hour_histogram.sort_by{ |k,v| - v }

daily_histogram = {}
Visit.all.map{ |v| daily_histogram[v.visit_time.wday] ||= 0; daily_histogram[v.visit_time.wday] += 1 }; daily_histogram.sort_by{ |k,v| - v }

hour_histogram = {}; daily_histogram = {}
Visit.all.map do |v|
  daily_histogram[v.visit_time.wday] ||= 0; daily_histogram[v.visit_time.wday] += 1
  hour_histogram[v.visit_time.hour] ||= 0; hour_histogram[v.visit_time.hour] += 1
end; ""

rd = Url.all("url.like" => "%ruby-doc%"); rd.size
visits = rd.visits
hour_histogram = {}
visits.map{ |v| hour_histogram[v.visit_time.hour] ||= 0; hour_histogram[v.visit_time.hour] += 1 }; hour_histogram.sort_by{ |k,v| - v }
daily_histogram = {}
visits.map{ |v| daily_histogram[v.visit_time.wday] ||= 0; daily_histogram[v.visit_time.wday] += 1 }; daily_histogram.sort_by{ |k,v| - v }

def normalize(hist)
  total = 0
  hist.values.each{|v| total += v}
  normalized = {}
  hist.each{ |k,v| normalized[k] = v.to_f / total}
  return normalized
end
