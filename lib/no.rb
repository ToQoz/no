require "no/version"

module NO
  class NullObject < Object
    %w(to_a to_c to_f to_h to_i to_r to_s rationalize & ! nil?).each do |method|
      next unless nil.respond_to?(method)

      define_method(method) do |*args|
        nil.send(method, *args)
      end
    end

    def == a
      if a.is_a?(::NO::NullObject)
        super
      else
        nil.== a
      end
    end

    def ^ a
      if a.is_a?(::NO::NullObject) # for "NO::NullObject ^ NO::NullObject returns false"
        false
      else
        nil.^ a
      end
    end

    def | a
      if a.is_a?(::NO::NullObject) # for "NO::NullObject | NO::NullObject returns false"
        false
      else
        nil.| a
      end
    end

    def method_missing name, *args
      if nil.respond_to?(name)
        nil.send(name, *args)
      else
        nil
      end
    end
  end
end
