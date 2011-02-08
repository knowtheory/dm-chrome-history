module DataMapper
  class Property
    class Transition < Enum
      def custom?; true; end
  
      def initialize(model, name, options = {}, type = nil)
        options[:flags] = options.fetch(:flags, 
        [:link, :typed, :auto_bookmark, :auto_subframe, :manual_subframe, 
         :generated, :start_page, :form_submit, :reload, :keyword, :keyword_generated])
        super(model, name, options, type)
      end
  
      def load(value)
        super(value & 0xFF)
      end

      def dump(value)
        raise StandardError, "Transitions in Chrome are lossy, and can not be set."
      end
    end

    class TransitionMask < Integer
      def custom?; true; end
      accept_options :mask
      
      def initialize(model, name, options={}, type = nil)
        @mask = options.fetch(:mask, 0xFF)
        super
      end
      
      def load(value)
        (value & @mask) != 0
      end
  
      def dump(value)
        raise StandardError, "Transitions in Chrome are lossy, and can not be set."
      end
    end
  end
end
