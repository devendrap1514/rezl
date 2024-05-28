require 'rails_helper'
RSpec.describe Admin::TermAndConditionsController, type: :controller do
  include Devise::TestHelpers
  render_views
  let(:term) { create(:term_and_condition) }
  before(:each) do
    @admin_user = create(:admin_user)
    sign_in @admin_user
  end

  describe 'ActiveAdmin config' do
    describe '#before_action' do
      context '#check_updated_terms' do
        it 'should render index page' do
          get :index
          expect(response).to have_http_status(200)
          expect(response).to render_template(:index)
        end
        it 'should redirect to updated terms page if new terms added' do
          term
          get :index
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(updated_terms_admin_term_and_conditions_path)
        end
        it 'should redirect to updated terms page if terms udpated' do
          term
          @admin_user.term_and_conditions << term
          get :index
          expect(response).to have_http_status(200)
          expect(response).to redirect_to(:index)

        end
        it 'should render show page if all terms accepted' do
          @admin_user.term_and_conditions << term
          get :show, params: { id: term.id }
          expect(response).to have_http_status(200)
          expect(response).to render_template(:show)
        end
        #check for owner and super admin also
      end
    end
  end

  describe 'TermsAndCondition' do
    describe '#before_action' do
      context 'Get #updated_terms' do
        it 'should show index page' do
          get :updated_terms
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(admin_root_path)
        end
      end
      context 'Post #accept_terms' do
        it 'should show index page' do
          post :accept_terms
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(admin_root_path)
        end
      end
    end
  end
end
