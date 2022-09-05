require "rails_helper"

RSpec.describe ContactsController, :type => :controller do
  let(:contact_attributes) {
    {
      first_name: "Test first name", 
      last_name: "Test last name", 
      email: "Testemail@gmail.com", 
      phone_number: "97990900"
    }
  }

  let(:default_contact){ Contact.create}

  describe "GET #index" do
    it "returns a 200 OK status" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do

    # context "with valid params" do
    #   let(:contact) { Contact.create(contact_attributes) }
    #   it "response with 200 status" do
    #     expect(response).to have_http_status(:ok)
    #     expect(Contact.count).to eq(1)
    #   end
    # end

    # context "with invalid params" do
    #   let(:invalid_create) { Contact.create }
    #   it "response with 422 status" do        
    #     expect(response).to have_http_status(:unprocessable_entity)        
    #   end
    # end
  end

  describe "Update #put" do

    it "response with 200 status" do
      default_contact.update(contact_attributes)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "Show #get" do
    let(:contacts) { Contact.all }
    it "response with 200 status" do
      contacts.last
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE #destroy" do
    let(:contact) { Contact.create(contact_attributes) }
    it "response with 200 status" do
      contact.destroy
      expect(response).to have_http_status(:ok)
    end
  end
end



