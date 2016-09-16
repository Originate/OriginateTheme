#!/usr/bin/ruby

require 'pathname'
require 'xcodeproj'

# Constants.
path_to_xcode_build_script = '"${PODS_ROOT}/OriginateTheme/OriginateTheme/Scripts/ot_generator.py" -i "${OTTHEME}" -o "${PODS_ROOT}/OriginateTheme/OriginateTheme/Sources/Classes/"'
xcode_build_script_name = '[OT] Generate Theme Files'

# Path Varialbe is passed by OriginateTheme.podspec.
path_to_spec = ARGV[0]

# Path to the Xcode project.
path_to_project = Dir.glob(Pathname.new(path_to_spec) + '../../**/*.xcodeproj')[0]

# Open Xcode project and check if shell script is already installed.
project = Xcodeproj::Project.open(path_to_project)
main_target = project.targets.first

script_installed = false
main_target.shell_script_build_phases.each { |run_script|
  script_installed = true if run_script.name == xcode_build_script_name
}

# Install shell script build phase.
if (!script_installed)
  puts "Installing run script in Xcode project #{path_to_project}"
  phase = main_target.new_shell_script_build_phase(xcode_build_script_name)
  phase.shell_script = path_to_xcode_build_script
  project.save()
else
  puts "Run script already installed"
end
