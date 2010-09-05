require 'dm-core'

# See chromium/src/base/{time.h,time_mac.cc}

begin
  # provide Time#utc_time for DateTime#to_time in AS
  require 'active_support/core_ext/time/calculations'
rescue LoadError
  # do nothing, extlib is being used and does not require this method
end

module DataMapper
  class Property
    class ChromeEpochTime < Integer
      def load(value)
        return value unless value.respond_to?(:to_int)
        ::Time.at((value.to_i/10**6)-11644473600)
      end

      def dump(value)
        case value
          when ::Integer, ::Time then (value.to_i + 11644473600) * 10**6
          when ::DateTime        then (value.to_time.to_i + 11644473600) * 10**6
        end
      end
    end # class EpochTime
  end # class Property
end # module DataMapper

