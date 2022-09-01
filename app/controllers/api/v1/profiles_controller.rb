module Api::V1
  class ProfilesController < Api::V1::ApplicationController
    before_action :set_profile, only: [:show, :update, :destroy]

    respond_to :json

    # GET /profile.json
    # def index
    #    @profiles = Profile.all
    #   #  p "foppopop"
    #   #  p @profiles
    #   #  render json: @profiles
    #    render json: @profiles, methods: :photo_url
    # end

    # GET /profile/1.json
    def show
      @profile = Profile.find(params[:id])
      render json: {
        id: @profile.id,
        "nom": @profile.nom,
        "prenom": @profile.prenom,
        "num_tel": @profile.num_tel,
        "nationalite": @profile.nationalite,
        "adresse1": @profile.adresse1,
        "adresse2": @profile.adresse2,
        "ville":  @profile.ville,
        "region":  @profile.region,
        "province":  @profile.province,
        "pays":  @profile.pays,
        "code_postal":  @profile.code_postal,
        "post_souhaite": @profile.post_souhaite,
        "nom_contact":  @profile.nom_contact,
        "tel_contact":  @profile.tel_contact,
        "email_contact":  @profile.email_contact,
        "sondage":  @profile.sondage,
        "nom_societe":  @profile.nom_societe,
        "num_entreprise_quebec": @profile.num_entreprise_quebec,
        "statut_juridique": @profile.statut_juridique,
        "nom_actionnaire_principal":  @profile.nom_actionnaire_principal,
        "actionnaire_tel":  @profile.actionnaire_tel,
        "actionnaire_email":  @profile.actionnaire_email,
        "photo": @profile.photo_url,
        "cv": @profile.cv_url,
        "user_id": @profile.user_id,
        "created_at": @profile.created_at,
        "updated_at": @profile.updated_at,
        "approved": @profile.approved,
        "pricing_plan": @profile.pricing_plan,
        "bio": @profile.bio,
        "reference": @profile.reference,
        "adresse": @profile.adresse,
        "quartier": @profile.quartier,
        "total_amount": @profile.total_amount,
        "total_paiement": @profile.total_amount,
        "tolal_remuneration": @profile.tolal_remuneration,
        "total_facturation": @profile.total_facturation
        }, status: 200
    end

    def paiement
      @paiements = Paiement.where(owner_id: current_user.profile.id)
      @list_paiement ||= []
      @paiements.map do |paiement| 
        @list = {
        "id": paiement.id,
        "montant": paiement.montant,
        "status": paiement.status,
        "comment": paiement.comment,
        "received": paiement.received_url,
        "confirmation": paiement.confirmation,
        "confirmed_at": paiement.confirmed_at,
        "owner_id": paiement.owner_id,
        "created_at": paiement.created_at,
        "updated_at": paiement.updated_at,
        "admin_confirmation": paiement.admin_confirmation,
        "subscription": paiement.subscription
        }
        @list_paiement << @list
      end
      render json: @list_paiement
    end

    def confirmation_paiement
      @paiement = Paiement.where(id: params[:paiement]).first
      @paiement.update_columns(confirmation: true, confirmed_at: Date.today)
    end
  

    # POST /profile.json
    def create
      @profile = Profile.new(profile_params)
      if @profile.save
        render json: @profile
      else
        render error: {message: "Impossible de creer l'offre"}, status: 400
      end
    end

    # PATCH/PUT /profile/1.json
    def update
      @profile = Profile.find(params[:id])
      if @profile
        @profile.update(profile_params)
        render json: {message: "L'offre a été modifié avec succès."}, status: 200
      else
        render json: {message: "Impossible de modifier l'offre."}, status: 400
      end
    end

    def destroy
      @profile = Profile.find(params[:id])
      if @profile
        @profile.destroy
        render json: {message: "L'offre a été supprimé avec succès"}, status: 200
      else
        render json: {message: "Impossible de supprimer l'offre"}, status: 400
      end
    end

    private
      
      def set_profile
        @profile = Profile.find(params[:id])
      end
      # Only allow a list of trusted parameters through.
      def profile_params
        params.permit(:nom, :prenom, :bio,:num_tel, :nationalite,:adresse,
        :adresse1, :adresse2, :region, :province, :pays,:code_postal,:ville,:time_zone, :quartier,
        :post_souhaite, :nom_contact, :tel_contact, :email_contact, :sondage, 
        :nom_societe,:pricing_plan, :reference,:num_entreprise_quebec, :statut_juridique, :nom_actionnaire_principal, 
        :actionnaire_tel, :actionnaire_email, :user_id,:approved, 
        experiences_attributes: [:id, :description,:profile_id ,:nb_experience, :admin_job_category_id, :diplome, :_destroy], 
        multi_profiles_attributes: [:id, :admin_job_category_id,:prix, :profile_id, :_destroy],
        tarifs_attributes: [:id, :category_id,:prix, :profile_id,:_destroy],
        multi_places_attributes: [:id, :adresse, :profile_id,:_destroy, :adresse1, :adresse2, :country, :region, :province, :code_postal,:ville])
      end
   end
end