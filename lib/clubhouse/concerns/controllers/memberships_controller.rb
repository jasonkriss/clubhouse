module Clubhouse
  module Concerns
    module Controllers
      module MembershipsController
        extend ActiveSupport::Concern

        def index
          render_list(authorize!(scoped))
        end

        def create
          membership = authorize!(scoped.build)

          CreateMembership.call({
            membership: membership,
            user: current_user,
            params: whitelist(membership)
          })

          render json: membership, status: :created
        end

        def show
          membership = authorize!(fetch_membership)
          render json: membership, status: :ok
        end

        def update
          membership = authorize!(fetch_membership)
          membership.update!(whitelist(membership))
          render json: membership, status: :ok
        end

        def destroy
          membership = authorize!(fetch_membership)
          membership.destroy
          head :no_content
        end

        private
        def scoped
          Organization.locate!(params[:organization_id]).memberships
        end

        def fetch_membership
          Membership.find(params[:id])
        end
      end
    end
  end
end
