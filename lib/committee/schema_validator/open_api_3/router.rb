# frozen_string_literal: true

module Committee
  module SchemaValidator
    class OpenAPI3
      class Router
        # @param [Committee::SchemaValidator::Option] validator_option
        def initialize(schema, validator_option)
          @schema = schema
          @prefix_regexp = ::Committee::SchemaValidator.build_prefix_regexp(validator_option.prefix)
          @validator_option = validator_option
        end

        def includes_request?(request)
          return true unless @prefix_regexp

          prefix_request?(request)
        end

        def build_schema_validator(request)
          Committee::SchemaValidator::OpenAPI3.new(self, request, @validator_option)
        end

        def operation_object(request)
          path = find_path(request)
          path = path.gsub(@prefix_regexp, '') if prefix_request?(request)

          request_method = request.request_method.downcase

          @schema.operation_object(path, request_method)
        end

        private

        def prefix_request?(request)
          return false unless @prefix_regexp

          find_path(request) =~ @prefix_regexp
        end

        def find_path(request)
          request.respond_to?(:original_fullpath) ? request.original_fullpath : request.path
        end
      end
    end
  end
end
