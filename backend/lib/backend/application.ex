defmodule Backend.Application do
	# See https://hexdocs.pm/elixir/Application.html
	# for more information on OTP Applications
	@moduledoc false

	use Application

	def start(_type, _args) do
		children = [
			{Registry, keys: :duplicate, name: Backend.Registry},
			{Registry, keys: :unique, name: Backend.GameRegistry},
			Backend.GameSupervisor,
			Backend.Server
		]

		# See https://hexdocs.pm/elixir/Supervisor.html
		# for other strategies and supported options
		opts = [strategy: :one_for_one, name: Backend.Supervisor]
		Supervisor.start_link(children, opts)
	end
end
