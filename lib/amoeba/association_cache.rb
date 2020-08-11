module Amoeba
  module AssociationCache
    def self.flush
      RequestStore.store[:amoeba_cache] = {}
    end

    def self.cache(instance)
      key = get_key(instance)
      cache = get_cache(instance)
      cache[key] = instance
    end

    def self.get(instance)
      key = get_key(instance)
      cache = get_cache(instance)
      result = cache[key]

      return nil if result.nil?

      if result.is_a? Numeric
        return instance.class.find(result)
      end

      if result.id.nil?
        result
      else
        cache[key] = result.id
        result
      end
    end

    # iterates over cached entities and replaces model instances with IDs
    def self.compact
      if RequestStore.store.has_key?(:amoeba_cache)
        cache = RequestStore.store[:amoeba_cache]
        cache.each do |entity, entity_cache|
          entity_cache.each do |key, value|
            if !value.is_a?(Numeric) && !value.id.nil?
              entity_cache[key] = value.id
            end
          end
        end
      end
    end

    private

    def self.get_key(new_object)
      return new_object.name if new_object.respond_to?(:name)
      return Digest::MD5.hexdigest(new_object.attributes.reject{|x| x == 'id'}.values.join(','))
    end

    def self.get_cache(instance)
      class_name = instance.class.name

      cache = nil

      unless RequestStore.store.has_key?(:amoeba_cache)
        cache = {}
        RequestStore.store[:amoeba_cache] = cache
      else
        cache = RequestStore.store[:amoeba_cache]
      end

      unless cache.has_key?(class_name)
        cache[class_name] = {}
      end

      cache[class_name]
    end
  end
end
