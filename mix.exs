defmodule GoogleCalendar.Mixfile do
  use Mix.Project

  def project do
    [app: :google_calendar,
     version: "0.1.2",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "A simple wrapper for Google Calendar API",
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :oauth2]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:oauth2, "~> 0.9"},
     {:earmark, ">= 0.0.0", only: :dev},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  def package do
    [ name: :google_calendar,
      files: ["lib", "mix.exs"],
      maintainers: ["dinhtungtp"],
      licenses: ["Framgia Vietnam"],
      links: %{"Github" => "https://github.com/tung6192/google_calendar"}
    ]
  end
end
