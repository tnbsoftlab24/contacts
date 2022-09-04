require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    get profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_url
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post profiles_url, params: { profile: { actionnaire_email: @profile.actionnaire_email, actionnaire_tel: @profile.actionnaire_tel, adresse1: @profile.adresse1, adresse2: @profile.adresse2, code_postal: @profile.code_postal, cv: @profile.cv, email_contact: @profile.email_contact, name: @profile.name, nationalite: @profile.nationalite, nom_actionnaire_principal: @profile.nom_actionnaire_principal, nom_contact: @profile.nom_contact, nom_gestionnaire: @profile.nom_gestionnaire, nom_societe: @profile.nom_societe, num_entreprise_quebec: @profile.num_entreprise_quebec, num_gesttionnaire: @profile.num_gesttionnaire, num_tel: @profile.num_tel, pays: @profile.pays, photo: @profile.photo, post_souhaite: @profile.post_souhaite, prenom: @profile.prenom, province: @profile.province, region: @profile.region, secteur_activite: @profile.secteur_activite, sondage: @profile.sondage, statut_juridique: @profile.statut_juridique, tel_contact: @profile.tel_contact, user_id: @profile.user_id, ville: @profile.ville } }
    end

    assert_redirected_to profile_url(Profile.last)
  end

  test "should show profile" do
    get profile_url(@profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_url(@profile)
    assert_response :success
  end

  test "should update profile" do
    patch profile_url(@profile), params: { profile: { actionnaire_email: @profile.actionnaire_email, actionnaire_tel: @profile.actionnaire_tel, adresse1: @profile.adresse1, adresse2: @profile.adresse2, code_postal: @profile.code_postal, cv: @profile.cv, email_contact: @profile.email_contact, name: @profile.name, nationalite: @profile.nationalite, nom_actionnaire_principal: @profile.nom_actionnaire_principal, nom_contact: @profile.nom_contact, nom_gestionnaire: @profile.nom_gestionnaire, nom_societe: @profile.nom_societe, num_entreprise_quebec: @profile.num_entreprise_quebec, num_gesttionnaire: @profile.num_gesttionnaire, num_tel: @profile.num_tel, pays: @profile.pays, photo: @profile.photo, post_souhaite: @profile.post_souhaite, prenom: @profile.prenom, province: @profile.province, region: @profile.region, secteur_activite: @profile.secteur_activite, sondage: @profile.sondage, statut_juridique: @profile.statut_juridique, tel_contact: @profile.tel_contact, user_id: @profile.user_id, ville: @profile.ville } }
    assert_redirected_to profile_url(@profile)
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete profile_url(@profile)
    end

    assert_redirected_to profiles_url
  end
end
