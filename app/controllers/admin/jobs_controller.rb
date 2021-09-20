# frozen_string_literal: true

module Admin
  class JobsController < BaseController

    def create
      OrderGeneratorWorker.perform_async
    end
  end
end
