RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'GET #edit' do
    before do
      login_as(user, scope: :user)
      get :edit, params: { id: question }, format: :js
    end

    it 'render template edit view in JS format' do
      expect(response.content_type).to eq Mime[:js]
    end
  end
end
