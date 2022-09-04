# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_11_202344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_job_categories", force: :cascade do |t|
    t.string "title"
    t.decimal "amount"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "amount_employee"
    t.index ["parent_id"], name: "index_admin_job_categories_on_parent_id"
  end

  create_table "admin_location_provinces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "admin_location_regions", force: :cascade do |t|
    t.string "name"
    t.bigint "province_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["province_id"], name: "index_admin_location_regions_on_province_id"
  end

  create_table "admin_location_villes", force: :cascade do |t|
    t.string "name"
    t.bigint "region_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region_id"], name: "index_admin_location_villes_on_region_id"
  end

  create_table "admin_paiements", force: :cascade do |t|
    t.decimal "montant"
    t.integer "status"
    t.string "comment"
    t.string "received"
    t.bigint "enterprise_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "worker_id"
    t.bigint "job_id"
    t.datetime "paiement_date"
    t.decimal "worker_amount"
    t.decimal "job_amount"
    t.boolean "confirmate"
    t.datetime "confirmation_date"
    t.index ["enterprise_id"], name: "index_admin_paiements_on_enterprise_id"
    t.index ["job_id"], name: "index_admin_paiements_on_job_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "description"
    t.string "diplome"
    t.integer "nb_experience"
    t.bigint "admin_job_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_job_category_id"], name: "index_experiences_on_admin_job_category_id"
    t.index ["profile_id"], name: "index_experiences_on_profile_id"
  end

  create_table "extras", force: :cascade do |t|
    t.string "designation"
    t.decimal "prix_entreprise"
    t.decimal "prix_employe"
    t.bigint "job_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_extras_on_job_id"
  end

  create_table "freetimes", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_freetimes_on_profile_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_invitations_on_job_id"
    t.index ["profile_id"], name: "index_invitations_on_profile_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "poste"
    t.text "description"
    t.text "information_specifique"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "status"
    t.bigint "owner_id", null: false
    t.bigint "admin_job_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "taux"
    t.string "job_adress"
    t.integer "factor"
    t.string "color"
    t.decimal "job_money"
    t.decimal "employee_money"
    t.integer "type_adress"
    t.boolean "new_proposal"
    t.string "worker_name"
    t.string "ville"
    t.string "province"
    t.string "region"
    t.boolean "employee_dues"
    t.index ["admin_job_category_id"], name: "index_jobs_on_admin_job_category_id"
    t.index ["owner_id"], name: "index_jobs_on_owner_id"
  end

  create_table "multi_places", force: :cascade do |t|
    t.string "adresse"
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "adresse1"
    t.string "adresse2"
    t.string "country"
    t.string "province"
    t.string "ville"
    t.string "region"
    t.string "code_postal"
    t.index ["profile_id"], name: "index_multi_places_on_profile_id"
  end

  create_table "multi_profiles", force: :cascade do |t|
    t.bigint "admin_job_category_id", null: false
    t.decimal "prix"
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_job_category_id"], name: "index_multi_profiles_on_admin_job_category_id"
    t.index ["profile_id"], name: "index_multi_profiles_on_profile_id"
  end

  create_table "paiements", force: :cascade do |t|
    t.decimal "montant"
    t.integer "status"
    t.string "comment"
    t.string "received"
    t.boolean "confirmation"
    t.datetime "confirmed_at"
    t.bigint "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin_confirmation"
    t.boolean "subscription", default: false
    t.index ["owner_id"], name: "index_paiements_on_owner_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.string "num_tel"
    t.string "nationalite"
    t.string "adresse1"
    t.string "adresse2"
    t.string "ville"
    t.string "region"
    t.string "province"
    t.string "pays"
    t.string "code_postal"
    t.string "post_souhaite"
    t.string "nom_contact"
    t.string "tel_contact"
    t.string "email_contact"
    t.string "sondage"
    t.string "nom_societe"
    t.string "num_entreprise_quebec"
    t.string "statut_juridique"
    t.string "nom_actionnaire_principal"
    t.string "actionnaire_tel"
    t.string "actionnaire_email"
    t.string "photo"
    t.string "cv"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approved"
    t.integer "pricing_plan"
    t.string "bio"
    t.string "reference"
    t.string "adresse"
    t.string "quartier"
    t.decimal "total_amount", default: "0.0"
    t.decimal "total_paiement", default: "0.0"
    t.decimal "tolal_remuneration", default: "0.0"
    t.decimal "total_facturation", default: "0.0"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "information_complementaire"
    t.integer "status"
    t.index ["job_id"], name: "index_proposals_on_job_id"
    t.index ["owner_id"], name: "index_proposals_on_owner_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "comment"
    t.bigint "job_id", null: false
    t.bigint "profile_id", null: false
    t.decimal "rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_reviews_on_job_id"
    t.index ["profile_id"], name: "index_reviews_on_profile_id"
  end

  create_table "souscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "pricing_plan"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_souscriptions_on_user_id"
  end

  create_table "tarifs", force: :cascade do |t|
    t.bigint "admin_job_category_id", null: false
    t.bigint "profile_id", null: false
    t.decimal "prix"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_job_category_id"], name: "index_tarifs_on_admin_job_category_id"
    t.index ["profile_id"], name: "index_tarifs_on_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.boolean "terms_conditions"
    t.string "time_zone"
    t.boolean "is_new"
    t.boolean "is_validate"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_location_regions", "admin_location_provinces", column: "province_id"
  add_foreign_key "admin_location_villes", "admin_location_regions", column: "region_id"
  add_foreign_key "admin_paiements", "admin_paiements", column: "job_id"
  add_foreign_key "admin_paiements", "profiles", column: "enterprise_id"
  add_foreign_key "experiences", "admin_job_categories"
  add_foreign_key "experiences", "profiles"
  add_foreign_key "extras", "jobs"
  add_foreign_key "freetimes", "profiles"
  add_foreign_key "invitations", "jobs"
  add_foreign_key "invitations", "profiles"
  add_foreign_key "jobs", "admin_job_categories"
  add_foreign_key "jobs", "profiles", column: "owner_id"
  add_foreign_key "multi_places", "profiles"
  add_foreign_key "multi_profiles", "admin_job_categories"
  add_foreign_key "multi_profiles", "profiles"
  add_foreign_key "paiements", "profiles", column: "owner_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "proposals", "jobs"
  add_foreign_key "proposals", "profiles", column: "owner_id"
  add_foreign_key "reviews", "jobs"
  add_foreign_key "reviews", "profiles"
  add_foreign_key "souscriptions", "users"
  add_foreign_key "tarifs", "admin_job_categories"
  add_foreign_key "tarifs", "profiles"
end
