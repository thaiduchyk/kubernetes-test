require 'swagger_helper'

RSpec.describe 'admin/orders', type: :request do

  path '/admin/orders' do

    get('list orders') do
      response(200, 'successful') do
        before { FactoryBot.create_list(:order, 5) }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 number: { type: :string },
                 status: { type: :string },
                 total: { type: :string },
                 shipping_cost: { type: :number, format: :float },
                 tax: { type: :number, format: :float },
                 sale_channel: { type: :string },
               },
               required: [ 'id', 'number', 'status', 'total', 'shipping_cost', 'tax', 'sale_channel' ]

        run_test!
      end
    end
  end

  path '/admin/orders/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show order') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end
end
