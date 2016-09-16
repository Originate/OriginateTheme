#!/usr/bin/ruby

require 'pathname'
require 'xcodeproj'

path_to_xcode_build_script = '"${SRCROOT}/Pods/OriginateTheme/run_script.sh"'
xcode_build_script_name = '[OT] Generate Theme Files'

path_to_spec = ARGV[0] # Passed from podspec using path variable
path_to_project = Dir.glob(Pathname.new(path_to_spec) + '../**/*.xcodeproj')[0]

project = Xcodeproj::Project.open(path_to_project)
main_target = project.targets.first
script_installed = false

# main_target.shell_script_build_phases.each { |run_script|
#   script_installed = true if run_script.name == xcode_build_script_name
# }

if (!script_installed)
  puts "Installing run script in Xcode project #{path_to_project}"
  phase = main_target.new_shell_script_build_phase(xcode_build_script_name)
  phase.shell_script = path_to_xcode_build_script
  main_target.instance_variable_set(:@build_phases, main_target.build_phases().rotate(-1))
  #main_target.instance_variable_set(:@shell_script_build_phases, main_target.shell_script_build_phases().rotate(-1))
  puts main_target.shell_script_build_phases()
  puts project
  project.save()
else
  puts "Run script already installed"
end
