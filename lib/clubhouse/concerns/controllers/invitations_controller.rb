module Clubhouse
  module Concerns
    module Controllers
      module InvitationsController
        extend ActiveSupport::Concern

        def index
          render_list(authorize!(scoped))
        end

        def create
          invitation = authorize!(scoped.build)

          CreateInvitation.call({
            invitation: invitation,
            params: whitelist(invitation)
          })

          render json: invitation, status: :created
        end

        def show
          invitation = authorize!(fetch_invitation)
          render json: invitation, status: :ok
        end

        def update
          invitation = authorize!(fetch_invitation)
          invitation.update!(whitelist(invitation))
          render json: invitation, status: :ok
        end

        def destroy
          invitation = authorize!(fetch_invitation)
          invitation.destroy
          head :no_content
        end

        private
        def scoped
          Organization.locate!(params[:organization_id]).invitations
        end

        def fetch_invitation
          Invitation.find(params[:id])
        end
      end
    end
  end
end
