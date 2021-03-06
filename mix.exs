defmodule PruBlink.Mixfile do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"

  Mix.shell.info([:green, """
  Mix environment
    MIX_TARGET:   #{@target}
    MIX_ENV:      #{Mix.env}
  """, :reset])

  def project do
    [app: :pru_blink,
     version: "0.1.0",
     elixir: "~> 1.4",
     compilers: [:elixir_make | Mix.compilers],
     target: @target,
     archives: [nerves_bootstrap: "~> 0.6"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     lockfile: "mix.lock.#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(@target),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application, do: application(@target)

  # Specify target specific application configurations
  # It is common that the application start function will start and supervise
  # applications which could cause the host to fail. Because of this, we only
  # invoke PruBlink.start/2 when running on a target.
  def application("host") do
    [extra_applications: [:logger]]
  end
  def application(_target) do
    [mod: {PruBlink, []},
     extra_applications: [:logger]]
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
  def deps do
    [{:nerves, "~> 0.7", runtime: false},
     {:elixir_make, "~> 0.3"},
     {:pru, "~> 0.1.0"}] ++
    deps(@target)
  end

  # Specify target specific dependencies
  def deps("host"), do: []
  def deps(target) do
    [
      {:bootloader, "~> 0.1"},
      {:nerves_runtime, "~> 0.4"}
    ] ++ system(target)
  end

  def system("rpi"), do: Mix.raise "Sorry, this example only works on BeagleBone Black/Green"
  def system("rpi0"), do: Mix.raise "Sorry, this example only works on BeagleBone Black/Green"
  def system("rpi2"), do: Mix.raise "Sorry, this example only works on BeagleBone Black/Green"
  def system("rpi3"), do: Mix.raise "Sorry, this example only works on BeagleBone Black/Green"
  def system("bbb"), do: [{:nerves_system_bbb, ">= 0.0.0", runtime: false}]
  def system("linkit"), do: Mix.raise "Sorry, this example only works on BeagleBone Black/Green"
  def system("ev3"), do: Mix.raise "Sorry, this example only works on BeagleBone Black/Green"
  def system("qemu_arm"), do: Mix.raise "Sorry, this example only works on BeagleBone Black/Green"
  def system(target), do: Mix.raise "Unknown MIX_TARGET: #{target}"

  # We do not invoke the Nerves Env when running on the Host
  def aliases("host"), do: []
  def aliases(_target) do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
