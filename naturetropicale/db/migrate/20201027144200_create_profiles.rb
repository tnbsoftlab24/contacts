class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :nom
      t.string :prenom
      t.string :num_tel
      t.string :nationalite
      t.string :adresse1
      t.string :adresse2
      t.string :ville
      t.string :region
      t.string :province
      t.string :pays
      t.string :code_postal
      # t.string :secteur_activite
      t.string :post_souhaite
      t.string :nom_contact
      t.string :tel_contact
      t.string :email_contact
      t.string :sondage
      t.string :nom_societe
      t.string :num_entreprise_quebec
      t.string :statut_juridique
      t.string :nom_actionnaire_principal
      t.string :actionnaire_tel
      t.string :actionnaire_email
      # t.string :nom_gestionnaire
      # t.string :num_gesttionnaire
      t.string :photo
      t.string :cv
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
