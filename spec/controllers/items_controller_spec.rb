require "rails_helper"

describe ItemsController do
  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }
  let(:items) { create_list(:item, 3, user: user) }

  describe "GET #index" do
    before { get :index, params: {}, session: {} }

    it "has a 200 status code" do
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
    before { login user }

    it "saves a new item" do
      expect {
        post :create, params: { item: attributes_for(:item) }
      }.to change(Item, :count).by(1)
    end
    it "redirects to /items/:id" do
      post :create, params: { item: attributes_for(:item) }
      expect(response).to redirect_to "/items/#{assigns(:item).id}"
    end
  end

  describe "PATCH #update" do
    before {
      login user
      get :edit, params: { id: item }, session: {}
    }

    it "assigns @item" do
      expect(assigns(:item)).to eq item
    end
    it "changes @item's attributes" do
        patch :update, params: { id: item, item: attributes_for(:item, title: 'updated test', price: 1500) }
        item.reload
        expect(item.title).to eq "updated test"
        expect(item.price).to eq 1500
    end
    it "redirects to /items/:id" do
      post :create, params: { item: attributes_for(:item) }
      expect(response).to redirect_to "/items/#{assigns(:item).id}"
    end
  end

  describe "DELETE #destroy" do
    before {
      login user
      get :edit, params: { id: item }, session: {}
    }

    it "assigns @item" do
      expect(assigns(:item)).to eq item
    end
    it "destroys the item" do
      expect {
        delete :destroy, params: { id: item }
      }.to change(Item,:count).by(-1)
    end
    it "redirects to /items/manage" do
      delete :destroy, params: { id: item }
      expect(response).to redirect_to manage_items_path
    end
  end

  describe "GET #manage" do
    before {
      login user
      get :manage, params: {}, session: {}
      create(:item) # 別ユーザーのitemを作成する
    }

    it "has a 200 status code" do
      expect(response).to have_http_status(:ok)
    end
    it "assigns @items" do
      expect(assigns(:items)).to match_array items
    end
    it 'renders the :manage template' do
      expect(response).to render_template :manage
    end
  end

  describe "GET #search" do
    let(:search_item) { create(:item, title: "searchTitle") }
    before { items }

    context "when search is searchTitle and status is 2" do
      let(:query) { {search: search_item.title, status: search_item.status} }
      before { get :search, params: query }
      it "has a 200 status code" do
        expect(response).to have_http_status(:ok)
      end
      it "assigns @items" do
        expect(assigns(:items)).to match_array [search_item]
      end
      it "assigns @result_count with 1" do
        expect(assigns(:result_count)).to eq 1
      end
      it "renders the :index template" do
        expect(response).to render_template :index
      end
    end
    context "when search is searchTitle" do
      let(:query) { {search: search_item.title} }
      before { get :search, params: query }
      it "has a 200 status code" do
        expect(response).to have_http_status(:ok)
      end
      it "assigns @items" do
        expect(assigns(:items)).to match_array [search_item]
      end
      it "assigns @result_count with 1" do
        expect(assigns(:result_count)).to eq 1
      end
      it "renders the :index template" do
        expect(response).to render_template :index
      end
    end
    context "when status is 2" do
      let(:query) { {search: "", status: search_item.status} }
      before { get :search, params: query }
      it "has a 200 status code" do
        expect(response).to have_http_status(:ok)
      end
      it "assigns @items" do
        expect(assigns(:items)).to match_array Item.all.to_a
      end
      it "assigns @result_count with 4" do
        expect(assigns(:result_count)).to eq Item.count
      end
      it "renders the :index template" do
        expect(response).to render_template :index
      end
    end
  end
end
