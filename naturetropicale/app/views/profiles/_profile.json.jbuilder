json.extract! profile, :id, :name, :prenom, :num_tel, :nationalite, :adresse1, :adresse2, :ville, :region, :province, :pays, :code_postal, :secteur_activite, :post_souhaite, :nom_contact, :tel_contact, :email_contact, :sondage, :nom_societe, :num_entreprise_quebec, :statut_juridique, :nom_actionnaire_principal, :actionnaire_tel, :actionnaire_email, :photo, :cv, :user_id, :created_at, :updated_at :approved
json.url profile_url(profile, format: :json)