require 'rails_helper'


RSpec.describe OrdersController, type: :request do

   let(:body) do
      { 
         email: 'kmlcanaydin@gmail.com', 
         total: 69.99, 
         status: 'pending'
      }
   end

   let(:fields) do
      %w(id email total status updated_at created_at)
   end

   def json
      @json ||= JSON.parse(response.body)
   end

   def post_request
      post('/orders', params: body)
   end

   it 'return 200' do
      #% yapmasını istediğim işlem
      post_request
      #% olması gerekeni bildiriyorum ;
      expect(response).to have_http_status(200)
   end 

   it 'should create order' do
      expect do
         post_request
      end.to change { Order.count }.by(1)
   end

   it 'return email' do
      post_request
      expect(json['email']).to eq body[:email]
   end

   it 'return status' do
      post_request
      expect(json['status']).to eq body[:status]
   end

   it 'return total' do
      post_request
      expect(json['total'].to_f).to eq body[:total]
   end

   it 'return fields' do
      post_request
      expect(json.keys).to match_array(fields)
   end

end