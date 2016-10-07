module Committee
  module Drivers
    # Gets a driver instance from the specified name. Raises ArgumentError for
    # an unknown driver name.
    def self.driver_from_name(name)
      case name
      when :hyper_schema
        Committee::Drivers::HyperSchema.new
      when :open_api_2
        Committee::Drivers::OpenAPI2.new
      else
        raise ArgumentError, %{Committee: unknown driver "#{name}".}
      end
    end

    # Driver is a base class for driver implementations.
    class Driver
      def default_path_params
        raise "needs implementation"
      end

      def default_query_params
        raise "needs implementation"
      end

      def name
        raise "needs implementation"
      end

      def parse(data)
        raise "needs implementation"
      end

      def schema_class
        raise "needs implementation"
      end
    end

    # Schema is a base class for driver schema implementations.
    class Schema
    end
  end
end