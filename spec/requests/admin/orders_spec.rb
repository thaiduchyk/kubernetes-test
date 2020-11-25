require 'swagger_helper'

RSpec.describe 'admin/orders', type: :request do

  path '/admin/orders' do

    get 'list orders' do
      response(200, 'successful') do
        tags 'Orders'
        produces 'application/json'

        parameter name: :limit,
                  in: :query,
                  type: :integer,
                  description: 'Amount of items to return',
                  required: false
        parameter name: :expand,
                  in: :query,
                  type: :string,
                  schema: { type: :string, enum: %w[customer shipping_address billing_address] },
                  description: 'Expand items with related resources',
                  required: false

        # query filter parameters
        parameter name: :number,
                  in: :query,
                  type: :string,
                  description: 'Filter items by parameter name',
                  required: false
        parameter name: :status,
                  in: :query,
                  type: :string,
                  schema: { type: :string, enum: Order.statuses.keys },
                  description: 'Filter items by parameter name',
                  required: false
        parameter name: :sale_channel,
                  in: :query,
                  type: :string,
                  schema: { type: :string, enum: Order.sale_channels.keys },
                  description: 'Filter items by parameter name',
                  required: false

        schema type: :object,
               required: [:orders],
                 properties: {
                 orders: {
                   type: :array,
                   items: {
                    '$ref' => '#/components/schemas/order'
                   }
                 }
               }

        before do |example|
          FactoryBot.create_list(:order, 5)
          submit_request(example.metadata)
        end

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        context 'no parameters' do
          it 'returns a valid 200 response with defined schema' do |example|
            assert_response_matches_metadata(example.metadata)
          end
        end

        context 'with limit' do
          let(:limit) { 3 }

          it 'returns limited amount of items' do
            result = JSON.parse(response.body, symbolize_names: true)
            expect(result[:orders].size).to eq(limit)
          end
        end
      end
    end

    post 'creates an order' do
      tags 'Orders'
      consumes 'application/json'
      parameter name: :order, 
                in: :body, 
                schema: { '$ref' => '#/components/schemas/new_order' }

      before do |example|
        submit_request(example.metadata)
      end

      response '201', 'order created' do
        let(:customer) { FactoryBot.create(:customer) } 
        let(:address) { FactoryBot.create(:address) } 
        let(:order) { { number: 'N-001', 
                        sale_channel: Order.sale_channels.keys.sample,
                        customer_id: customer.id,
                        shipping_address_id: address.id,
                        billing_address_id: address.id } }
        
        it 'returns a valid 200 response with defined schema' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end

      response '422', 'invalid request' do
        let(:order) { { number: 'N-001' } }
        run_test!
      end
    end
  end

  path '/admin/orders/{id}' do
    get 'show order' do
      tags 'Orders'
      produces 'application/json'

      parameter name: 'id',
                in: :path,
                type: :string,
                description: 'id'

      parameter name: :expand,
                in: :query,
                type: :string,
                schema: { type: :string, enum: %w[customer shipping_address billing_address] },
                description: 'Expand items with related resources',
                required: false

      response(200, 'successful') do
        let(:order) { FactoryBot.create(:order) } 
        let(:id) { order.id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
      
        run_test!
      end  
    end
  end
end
