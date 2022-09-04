require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  setup do
    @profile = profiles(:one)
  end

  test "visiting the index" do
    visit profiles_url
    assert_selector "h1", text: "Profiles"
  end

  test "creating a Profile" do
    visit profiles_url
    click_on "New Profile"

    fill_in "Actionnaire email", with: @profile.actionnaire_email
    fill_in "Actionnaire tel", with: @profile.actionnaire_tel
    fill_in "Adresse1", with: @profile.adresse1
    fill_in "Adresse2", with: @profile.adresse2
    fill_in "Code postal", with: @profile.code_postal
    fill_in "Cv", with: @profile.cv
    fill_in "Email contact", with: @profile.email_contact
    fill_in "Name", with: @profile.name
    fill_in "Nationalite", with: @profile.nationalite
    fill_in "Nom actionnaire principal", with: @profile.nom_actionnaire_principal
    fill_in "Nom contact", with: @profile.nom_contact
    fill_in "Nom gestionnaire", with: @profile.nom_gestionnaire
    fill_in "Nom societe", with: @profile.nom_societe
    fill_in "Num entreprise quebec", with: @profile.num_entreprise_quebec
    fill_in "Num gesttionnaire", with: @profile.num_gesttionnaire
    fill_in "Num tel", with: @profile.num_tel
    fill_in "Pays", with: @profile.pays
    fill_in "Photo", with: @profile.photo
    fill_in "Post souhaite", with: @profile.post_souhaite
    fill_in "Prenom", with: @profile.prenom
    fill_in "Province", with: @profile.province
    fill_in "Region", with: @profile.region
    fill_in "Secteur activite", with: @profile.secteur_activite
    fill_in "Sondage", with: @profile.sondage
    fill_in "Statut juridique", with: @profile.statut_juridique
    fill_in "Tel contact", with: @profile.tel_contact
    fill_in "User", with: @profile.user_id
    fill_in "Ville", with: @profile.ville
    click_on "Create Profile"

    assert_text "Profile was successfully created"
    click_on "Back"
  end

  test "updating a Profile" do
    visit profiles_url
    click_on "Edit", match: :first

    fill_in "Actionnaire email", with: @profile.actionnaire_email
    fill_in "Actionnaire tel", with: @profile.actionnaire_tel
    fill_in "Adresse1", with: @profile.adresse1
    fill_in "Adresse2", with: @profile.adresse2
    fill_in "Code postal", with: @profile.code_postal
    fill_in "Cv", with: @profile.cv
    fill_in "Email contact", with: @profile.email_contact
    fill_in "Name", with: @profile.name
    fill_in "Nationalite", with: @profile.nationalite
    fill_in "Nom actionnaire principal", with: @profile.nom_actionnaire_principal
    fill_in "Nom contact", with: @profile.nom_contact
    fill_in "Nom gestionnaire", with: @profile.nom_gestionnaire
    fill_in "Nom societe", with: @profile.nom_societe
    fill_in "Num entreprise quebec", with: @profile.num_entreprise_quebec
    fill_in "Num gesttionnaire", with: @profile.num_gesttionnaire
    fill_in "Num tel", with: @profile.num_tel
    fill_in "Pays", with: @profile.pays
    fill_in "Photo", with: @profile.photo
    fill_in "Post souhaite", with: @profile.post_souhaite
    fill_in "Prenom", with: @profile.prenom
    fill_in "Province", with: @profile.province
    fill_in "Region", with: @profile.region
    fill_in "Secteur activite", with: @profile.secteur_activite
    fill_in "Sondage", with: @profile.sondage
    fill_in "Statut juridique", with: @profile.statut_juridique
    fill_in "Tel contact", with: @profile.tel_contact
    fill_in "User", with: @profile.user_id
    fill_in "Ville", with: @profile.ville
    click_on "Update Profile"

    assert_text "Profile was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile" do
    visit profiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile was successfully destroyed"
  end
end
