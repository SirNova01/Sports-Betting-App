# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Where Swagger JSON/YAML files are generated
  config.openapi_root = Rails.root.join('swagger').to_s

  # Defines Swagger documents
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      # Add the `components` section with a security scheme
      components: {
        securitySchemes: {
          BearerAuth: {
            type: :apiKey,
            name: 'Authorization',
            in: :header
          }
        }
      },
      # (Optional) If you want all endpoints to require the Bearer token by default:
      # security: [ { BearerAuth: [] } ],
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ]
    }
  }

  # Outputs YAML (instead of JSON) when running rswag:specs:swaggerize
  config.openapi_format = :yaml
end
