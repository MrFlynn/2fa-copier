require "formula"
require "etc"

class Auth-Code-Copier < Formula
  homepage  "https://github.com/MrFlynn/2fa-copier"
  version   "v1.0"

  if OS.linux?
    odie "Not compatible with Linux."
  end

  user = Etc.getpwuid(Process.uid).name

  def install
    # Copy all files to the application directory.
    system "cp",        ".",
                        "/usr/local/Cellar/auth-code-copier/#{version}"

    # Insert keys into the launchd plist to run as the same user that is running Homebrew.
    system "sed",       "i13<key>Username</key>",
                        "/usr/local/Cellar/auth-code-copier/#{version}/local.auth-code-copier.plist"

    system "sed",       "i14<string>#{user}</string>",
                        "/usr/local/Cellar/auth-code-copier/#{version}/local.auth-code-copier.plist"

    system "sed",       "i15<true/>",
                        "/usr/local/Cellar/auth-code-copier/#{version}/local.auth-code-copier.plist"

    # Register the launchd service.
    system "launchctl", "load",
                        "-w",
                        "/usr/local/Cellar/auth-code-copier/#{version}/local.auth-code-copier.plist"

    # Launch the service.
    system "launchctl", "start",
                        "local.auth-code-copier"
  end
end
