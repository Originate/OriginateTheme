#!/usr/bin/env ruby

require 'pathname'
require 'xcodeproj'

# Installs the build script and build setting necessary for OriginateTheme
# to auto-generate theme files from a .json theme file. This method is
# intended to be called from the `post_install` hook of Podfile.
#
# @param  [Pod::Installer ] installer
# @param  [String] path to .json file, relative to Podfile
#
# @return [Void]
#
def install_originatetheme(installer:, json_path:)
  project = installer.pods_project

  puts "[OriginateTheme] Beginning generator script installation..."

  add_originatetheme_build_setting(project: project, json_path: json_path)
  add_originatetheme_build_phase(project: project)

  puts "[OriginateTheme] Done."
end


def add_originatetheme_build_setting(project:, json_path:)
  puts "[OriginateTheme] Adding $OTTHEME User-Defined Setting..."
  project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['OTTHEME'] = Pathname.new(json_path)
    end
  end
end


def add_originatetheme_build_phase(project:)
  target            = project.targets.find { |t| t.name == 'OriginateTheme' }
  build_script_name = '[OriginateTheme] Generate Theme Files'
  build_script      = '"${PODS_ROOT}/OriginateTheme/OriginateTheme/Scripts/ot_generator.py" -i "${OTTHEME}" -o "${PODS_ROOT}/OriginateTheme/OriginateTheme/Objective-C/Sources/Classes/"'

  # create build phase
  build_phase = begin
    phase = project.new(Xcodeproj::Project::Object::PBXShellScriptBuildPhase)
    phase.name = build_script_name
    phase.shell_script = build_script
    phase
  end

  # insert build phase before "Compile Sources" (otherwise, we could simply use `new_shell_script_build_phase`)
  compile_phase_index = target.build_phases.index { |p| p.class == Xcodeproj::Project::Object::PBXSourcesBuildPhase } || 0
  target.build_phases.insert(compile_phase_index, build_phase)

  # save changes
  project.save()

  puts "[OriginateTheme] Added generator script as Build Phase of '#{target.name}' target."
end
