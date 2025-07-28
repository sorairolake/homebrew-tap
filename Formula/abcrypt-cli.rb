# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class AbcryptCli < Formula
  desc "Utility for encrypt and decrypt files"
  homepage "https://sorairolake.github.io/abcrypt/"
  url "https://github.com/sorairolake/abcrypt/archive/refs/tags/abcrypt-cli-v0.5.1.tar.gz"
  sha256 "6886fa4aa9bfdf9453755a3baf45f94252c2e16fd2ba23863b1276de4c498795"
  license "GPL-3.0-or-later"
  head "https://github.com/sorairolake/abcrypt.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    ENV["CARGO_PROFILE_RELEASE_LTO"] = "true"
    ENV["CARGO_PROFILE_RELEASE_PANIC"] = "abort"

    system "cargo", "install", *std_cargo_args(path: "crates/cli")

    system "asciidoctor", "-b", "manpage", "docs/man/man{1/*.1,5/abcrypt.5}.adoc"
    man1.install Dir["docs/man/man1/*.1"]
    man5.install "docs/man/man5/abcrypt.5"

    system "#{bin}/abcrypt completion bash > abcrypt.bash"
    system "#{bin}/abcrypt completion fish > abcrypt.fish"
    system "#{bin}/abcrypt completion zsh > _abcrypt"
    bash_completion.install "abcrypt.bash"
    fish_completion.install "abcrypt.fish"
    zsh_completion.install "_abcrypt"
  end

  test do
    system "#{bin}/abcrypt", "-V"
  end
end
