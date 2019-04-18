# frozen_string_literal: true

# Ressource for the members to get products from (vegetables...), and are managed by the 'Aprovisionnement/Commande' team
# Can be CRUDed by an admin, R by members
# Available methods: #address, #name, #description, #managers
class ProductorsController < ApplicationController
  before_action :authenticate_member!

  def index
    @productors = Productor.all
  end

  def new
    if super_admin? || admin?
      @productor = Productor.new

      # address form generator
      @productor_address = @productor.build_address
    else
      redirect_to productors_path
    end
  end

  def create
    return redirect_to productors_path unless super_admin? || admin?

    @productor = Productor.new(permitted_params)
    if @productor.save
      flash[:notice] = "Le producteur a bien été créé"
      redirect_to @productor
    else
      flash[:error] = "Une erreur est survenue, veuillez recommencer l'opération"
    end
  end

  def show
    @productor = Productor.find(params[:id])
  end

  def edit
    if super_admin? || admin?
      @productor = Productor.find(params[:id])

      # address form generator
      @productor_address = @productor.address || @productor.build_address
    else
      redirect_to productors_path
    end
  end

  def update
    return redirect_to '/' unless super_admin? || admin?

    @productor = Productor.find(params[:id])
    if @productor.update_attributes(permitted_params)
      flash[:notice] = "Le producteur a bien été mis à jour"
      redirect_to @productor
    else
      flash[:error] = "Une erreur est survenue, veuillez recommencer l'opération"
      redirect_to edit_productor_path(@productor.id)
    end
  end

  def destroy
    if super_admin? || admin?
      Productor.find(params[:id]).destroy
      flash[:notice] = "Le producteur a été supprimé"
    else
      flash[:error] = "Opération échouée, une erreur est survenue"
    end
    redirect_to productors_path
  end

  private

  def permitted_params
    params.require(:productor).permit(:name, :description, :phone_number, :website_url, :avatar, catalogs: [], address_attributes: %i[id postal_code city street_name_1 street_name_2])
  end
end
