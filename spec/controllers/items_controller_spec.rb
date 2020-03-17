require "rails_helper"

describe ItemsController do
  let(:item) { create(:item) }
  let(:items) { create_list(:item, 2) }

  describe "GET #index" do
    before { get :index, params: {}, session: {} }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @items' do
      expect(assigns(:items)).to match_array items
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, params: { id: item }, session: {} }

    it "has a 200 status code" do
      expect(response).to have_http_status(:ok)
    end

    it "assigns @item" do
      expect(assigns(:item)).to eq item
    end

    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

  describe "POST #create" do
  end

  describe "PATCH #update" do
  end

  describe "DELETE #destroy" do
  end
end
