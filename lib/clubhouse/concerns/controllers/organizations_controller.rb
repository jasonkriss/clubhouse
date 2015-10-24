module Clubhouse
  module Concerns
    module Controllers
      module OrganizationsController
        extend ActiveSupport::Concern

        def index
          render_list(authorize!(scoped))
        end

        def create
          organization = authorize!(scoped.build)

          CreateOrganization.call({
            organization: organization,
            user: current_user,
            params: whitelist(organization)
          })

          render json: organization, status: :created
        end

        def check
          skip_authorization

          head :ok if Organization.validate_attributes!(name: params[:id])
        end

        def show
          organization = authorize!(fetch_organization)
          render json: organization, status: :ok
        end

        def update
          organization = authorize!(fetch_organization)
          organization.update!(whitelist(organization))
          render json: organization, status: :ok
        end

        def destroy
          organization = authorize!(fetch_organization)
          organization.destroy
          head :no_content
        end

        private
        def scoped
          current_user.organizations
        end

        def fetch_organization
          Organization.locate!(params[:id])
        end
      end
    end
  end
end
