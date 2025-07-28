# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class ScryptencCli < Formula
  desc "Utility for encrypt and decrypt files"
  homepage "https://sorairolake.github.io/scryptenc-rs/"
  url "https://github.com/sorairolake/scryptenc-rs/archive/refs/tags/scryptenc-cli-v0.8.1.tar.gz"
  sha256 "a4b4956a81867ee01cebcbc62f7555c33ee5df9c0934e6198a8d52a73b44be77"
  license "GPL-3.0-or-later"
  head "https://github.com/sorairolake/scryptenc-rs.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    ENV["CARGO_PROFILE_RELEASE_LTO"] = "true"
    ENV["CARGO_PROFILE_RELEASE_PANIC"] = "abort"

    system "cargo", "install", *std_cargo_args(path: "crates/cli")

    system "asciidoctor", "-b", "manpage", "docs/man/man1/*.1.adoc"
    man1.install Dir["docs/man/man1/*.1"]

    system "#{bin}/rscrypt completion bash > rscrypt.bash"
    system "#{bin}/rscrypt completion fish > rscrypt.fish"
    system "#{bin}/rscrypt completion zsh > _rscrypt"
    bash_completion.install "rscrypt.bash"
    fish_completion.install "rscrypt.fish"
    zsh_completion.install "_rscrypt"
  end

  test do
    system "#{bin}/rscrypt", "-V"
  end
end
