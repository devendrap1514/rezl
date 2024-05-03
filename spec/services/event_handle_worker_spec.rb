require 'rails_helper'
RSpec.describe EventHandleWorker, type: :job do
  describe "#perform" do
    context '#return message \'Event stored successfully\'' do
      before(:each) do
        # create property using
        @property = Property.new(name: "Property Name")
        @body = {
          'uri': payload['uri'],
          'event_name': event['name'],
          'status': event['status'],
          'start_time': event['start_time'],
          'invitee_first_name': payload['first_name'],
          'invitee_last_name': payload['last_name'],
          'reschedule_url': payload['reschedule_url'],
          'phone_number': payload['questions_and_answers'][0]['answer']
        }
      end
      it 'should save event data in database' do
        expect {
          describe_class.perform(@property.id, @body)
        }.to change(Tour, :count).by(1)
      end

      it 'should not save event data in database if event is canceled' do
        @body[:status] = 'canceled'
        expect {
          @described_class_obj.check_and_save_in_db(@body)
        }.to change(BxBlockActivityFeed::Tour, :count).by(0)
      end

      it 'should delete awaiting tour data from database if event is canceled' do
        @body[:status] = 'canceled'
        tour = create(:tour, uri: @body[:uri], status: 'awaiting', property: @property)
        expect {
          @described_class_obj.check_and_save_in_db(@body)
        }.to change(BxBlockActivityFeed::Tour, :count).by(-1)
      end

      it 'should delete scheduled tour data from database if event is canceled' do
        @body[:status] = 'canceled'
        account = create(:email_account, property_code: @property.code)
        tour = create(:tour, uri: @body[:uri], event_status: 'active', status: 'scheduled', property: @property, account: account)
        expect {
          @described_class_obj.check_and_save_in_db(@body)
        }.to change(BxBlockActivityFeed::Tour, :count).by(-1)
      end
    end
  end
end
